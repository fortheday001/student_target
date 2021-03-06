const Koa = require('koa');
const Router = require('koa-router');
const db = require('./db')
const jwt = require('./jwt')
const bodyParser = require('koa-bodyparser');
const cors = require('@koa/cors');
const moment = require('moment');

const app = new Koa();

app.use(bodyParser());
app.use(cors());

const routerNoJwt = new Router();
/************* 不需要 JWT 验证的路由 */
// 老师登录
routerNoJwt.post('/api/v1/teachers/access_tokens', async (ctx, next)=>{
    let _sql = 'SELECT * FROM st_teachers WHERE username=?'
    const [rows, fields] = await db.query(_sql, [ctx.request.body.username])
    if(rows.length > 0) {
        if(rows[0].password === ctx.request.body.password) {
            ctx.body = {
                ok: 1,
                data: {
                    token: jwt.create({
                        id: rows[0].id,
                        type: 'teacher'
                    })
                }
            }
        } else {
            ctx.body = {
                ok: 0,
                error: "用户名或者密码错误"
            }
        }
    } else {
        ctx.body = {
            ok: 0,
            error: "用户名或者密码错误"
        }
    }
})

// 查看某个班级某一天的日报
routerNoJwt.get('/api/v1/classes/:class_id/day_reports/:date', async (ctx, next)=>{
    let _sql = `SELECT a.stu_name,b.content,b.date,b.plan
                 FROM st_students a 
                  LEFT JOIN st_day_reports b ON(a.id=b.student_id AND b.date=?)
                  WHERE a.class_id=?`
    const [rows, fields] = await db.query(_sql, [ctx.params.date, ctx.params.class_id])

    ctx.body = {
        ok: 1,
        data: rows
    }
})

// 学生登录
routerNoJwt.post('/api/v1/students/access_tokens', async ctx=>{
    let _sql = 'SELECT * FROM st_students WHERE stu_name=?'
    let _values = [ctx.request.body.username]

    const [rows, fields] = await db.query(_sql, _values)
    if(rows.length > 0) {
        if(rows[0].password === ctx.request.body.password) {
            ctx.body = {
                ok: 1,
                data: {
                    token: jwt.create({
                        id: rows[0].id,
                        type: 'student'
                    })
                }
            }
        } else {
            ctx.body = {
                ok: 0,
                error: "用户名或者密码错误"
            }
        }
    } else {
        ctx.body = {
            ok: 0,
            error: "用户名或者密码错误"
        }
    }
})

// 查询一个班级所有学生目标完成情况
routerNoJwt.get('/api/v1/classes/:id/targets', async ctx=>{
    const [type0Rows, type0Fields] = await db.query('SELECT COUNT(*) c FROM st_targets WHERE type=0')
    const [type1Rows, type1Fields] = await db.query('SELECT COUNT(*) c FROM st_targets WHERE type=1')
    const [type2Rows, type2Fields] = await db.query('SELECT COUNT(*) c FROM st_targets WHERE type=2')

    let _sql = `SELECT a.id stu_id,a.stu_name,
                    (SELECT COUNT(*) 
                    FROM st_student_targets b 
                    LEFT JOIN st_targets c ON b.target_id=c.id
                    WHERE a.id=b.student_id AND c.type=0 AND b.ischk=1) type0,
                    (SELECT COUNT(*) 
                    FROM st_student_targets b 
                    LEFT JOIN st_targets c ON b.target_id=c.id
                    WHERE a.id=b.student_id AND c.type=1 AND b.ischk=1) type1,
                    (SELECT COUNT(*) 
                    FROM st_student_targets b 
                    LEFT JOIN st_targets c ON b.target_id=c.id
                    WHERE a.id=b.student_id AND c.type=2 AND b.ischk=1) type2,
                    (SELECT COUNT(*) 
                    FROM st_student_targets b 
                    WHERE a.id=b.student_id AND b.isok=1 AND b.opt_time BETWEEN NOW() AND (NOW() - interval 24 hour)) day1,
                    (SELECT COUNT(*) 
                    FROM st_student_targets b 
                    WHERE a.id=b.student_id AND b.isok=1 AND b.opt_time BETWEEN NOW() AND (NOW() - interval 48 hour)) day2,
                    (SELECT COUNT(*) 
                    FROM st_student_targets b 
                    WHERE a.id=b.student_id AND b.isok=1 AND b.opt_time BETWEEN NOW() AND (NOW() - interval 72 hour)) day3
                FROM st_students a
                    WHERE a.class_id=?`

    let _values = [ctx.params.id]

    const [rows, fields] = await db.query(_sql, _values)
    
    ctx.body = {
        ok: 1,
        data: {
            type0_total: type0Rows[0].c,
            type1_total: type1Rows[0].c,
            type2_total: type2Rows[0].c,
            list: rows
        }
    }
})

// 查询某个学生的目标
routerNoJwt.get('/api/v1/students/:id/targets', async ctx=>{
    let values = [ctx.params.id]
    let _where = 1
    let _sql

    // 根据 type 搜索
    if(ctx.query.type) {
        _where += ' AND a.type=? '
        values.push(ctx.query.type)
    }

    if(ctx.query.step_id) {
        _where += ' AND a.step_id=? '
        values.push(ctx.query.step_id)
    }

    _sql = `SELECT a.*,b.isok,b.ischk
                 FROM st_targets a
                  LEFT JOIN st_student_targets b ON (a.id=b.target_id AND b.student_id=?)
                   WHERE ${_where}
                   ORDER BY a.category ASC`

    const [rows, fields] = await db.query(_sql, values)


    ctx.body = {
        ok: 1,
        data: rows
    }
})

// 查询某个学生每个阶段的目标完成率
routerNoJwt.get('/api/v1/students/:id/target_tongji', async ctx=>{

    // 统计阶段完成率
    const _sql1 = `SELECT COUNT(*) total,r.cc,x.step_id,c.step_name
                    FROM st_targets x
                    LEFT JOIN (SELECT COUNT(*) cc,b.step_id
                                FROM st_student_targets a 
                                LEFT JOIN st_targets b ON a.target_id=b.id
                                    WHERE a.student_id = ? AND a.ischk=1
                                    GROUP BY b.step_id) r 
                    ON x.step_id=r.step_id
                    LEFT JOIN st_steps c ON c.id=x.step_id
                    WHERE x.step_id>0
                    GROUP BY x.step_id
                     ORDER BY x.step_id`
    await db.query('set global sql_mode=""')
    const [rows, fields] = await db.query(_sql1, [ctx.params.id])

    ctx.body = {
        ok: 1,
        data: rows
    }
})

// 查询班级
routerNoJwt.get('/api/v1/classes', async ctx=>{
    if(ctx.query.id) {
        let _sql = 'SELECT * FROM st_classes WHERE id = ?'
        const [rows, fields] = await db.query(_sql, [ctx.query.id])
        ctx.body = {
            ok: 1,
            data: rows[0]
        }
    } else {
        let _sql1 = 'SELECT COUNT(*) total FROM st_classes'
        const [rows, fields] = await db.query(_sql1)

        let page = ctx.query.page || 1
        let per_page = ctx.query.per_page || 10
        let _offset = (page-1)*per_page
        let _sql2 = `SELECT * FROM st_classes LIMIT ${_offset},${per_page}`
        const [data, dataFields] = await db.query(_sql2)
        ctx.body = {
            ok: 1,
            data: {
                total: rows[0].total,
                list: data
            }
        }
    }
})

// 查询阶段
routerNoJwt.get('/api/v1/steps', async ctx=>{
    if(ctx.query.id) {
        let _sql = 'SELECT * FROM st_steps WHERE id = ?'
        const [rows, fields] = await db.query(_sql, [ctx.query.id])
        ctx.body = {
            ok: 1,
            data: rows[0]
        }
    } else {
        let _sql1 = 'SELECT COUNT(*) total FROM st_steps'
        const [rows, fields] = await db.query(_sql1)

        let page = ctx.query.page || 1
        let per_page = ctx.query.per_page || 10
        let _offset = (page-1)*per_page
        let _sql2 = `SELECT * FROM st_steps LIMIT ${_offset},${per_page}`
        const [data, dataFields] = await db.query(_sql2)
        ctx.body = {
            ok: 1,
            data: {
                total: rows[0].total,
                list: data
            }
        }
    }
})

// 查询目标
routerNoJwt.get('/api/v1/targets', async ctx=>{
    if(ctx.query.id) {
        let _sql = 'SELECT * FROM st_targets WHERE id = ?'
        const [rows, fields] = await db.query(_sql, [ctx.query.id])
        ctx.body = {
            ok: 1,
            data: rows[0]
        }
    } else {
        let _where = ' WHERE 1 '
        let _value = []

        if(ctx.query.type) {
            _where += ' AND type=? '
            _value.push(ctx.query.type)
        }

        if(ctx.query.step_id) {
            _where += ' AND step_id=? '
            _value.push(ctx.query.step_id)
        }

        if(ctx.query.category) {
            _where += ' AND category=? '
            _value.push(ctx.query.category)
        }

        let _sql1 = `SELECT COUNT(*) total FROM st_targets ${_where}`
        
        const [rows, fields] = await db.query(_sql1, _value)

        // 翻页
        let _limit = ''
        if(ctx.query.page) {
            let page = ctx.query.page || 1
            let per_page = ctx.query.per_page || 10
            let _offset = (page-1)*per_page
            _limit = ` LIMIT ${_offset},${per_page}`
        }
        
        let _sql2 = `SELECT * FROM st_targets ${_where} ORDER BY category ASC ${_limit}`


        
        const [data, dataFields] = await db.query(_sql2, _value)

        ctx.body = {
            ok: 1,
            data: {
                total: rows[0].total,
                list: data
            }
        }
    }
})


const studentRouter = new Router()

// 学生修改密码
studentRouter.put('/api/v1/students/password', async ctx=>{
    
    const [rows, fields] = await db.query('SELECT password FROM st_students WHERE id = ?', [ctx.state.user.id])
    if(rows[0].password === ctx.request.body.oldpassword) {

        let _sql = `UPDATE st_students SET ? WHERE id = ?`
        let _data = {
            password: ctx.request.body.newpassword
        }
        await db.query(_sql, [_data, ctx.state.user.id])

        ctx.body = {
            ok: 1
        }

    } else {
        ctx.body = {
            ok: 0,
            error: '旧密码输入错误'
        }
    }
})

// 学生修改一个目标的掌握情况
studentRouter.put('/api/v1/mytargets/:id', async ctx=>{
    let _sql = `REPLACE INTO st_student_targets SET ?`
    let _data = {
        student_id: ctx.state.user.id,
        target_id: ctx.params.id,
        isok: ctx.request.body.ok
    }
    await db.query(_sql, _data)

    ctx.body = {
        ok: 1
    }
})

// 学生查看自己的日报
studentRouter.get('/api/v1/mydayreports', async ctx=>{
    // 翻页
    let _limit = ''
    if(ctx.query.page) {
        let page = ctx.query.page || 1
        let per_page = ctx.query.per_page || 10
        let _offset = (page-1)*per_page
        _limit = ` LIMIT ${_offset},${per_page} `
    }
    
    let _sql = `SELECT * FROM st_day_reports WHERE student_id=? ORDER BY date DESC ${_limit}`
    const [rows, fields] = await db.query(_sql, [ctx.state.user.id])

    let _sql1 = `SELECT COUNT(*) total FROM st_day_reports WHERE student_id=?`
    const [rows1, fields1] = await db.query(_sql1, [ctx.state.user.id])

    ctx.body = {
        ok: 1,
        data: {
            list: rows,
            total: rows1[0].total
        }
    }
})

// 学生发表日报
studentRouter.post('/api/v1/day_reports', async ctx=>{
    const _date = new Date()
    let _today = moment().format('YYYY-MM-DD')

    let _sql1 = 'SELECT COUNT(*) total FROM st_day_reports WHERE date=? AND student_id=?'
    const [rows1, fields1] = await db.query(_sql1, [_today, ctx.state.user.id])

    if(rows1[0].total == 0) {
        let _sql = 'INSERT INTO st_day_reports SET ?'
        let _data
        if(ctx.request.body.content) {
            _data = {
                student_id: ctx.state.user.id,
                date: _today,
                content: ctx.request.body.content
            }
        } else {
            _data = {
                student_id: ctx.state.user.id,
                date: _today,
                plan: ctx.request.body.plan
            }
        }
        await db.query(_sql, _data)
    } else {
        let _sql
        if(ctx.request.body.content) {
            _sql = 'UPDATE st_day_reports SET content=? WHERE student_id=? AND date=?'
            await db.query(_sql, [ctx.request.body.content, ctx.state.user.id, _today])
        } else {
            _sql = 'UPDATE st_day_reports SET plan=? WHERE student_id=? AND date=?'
            await db.query(_sql, [ctx.request.body.plan, ctx.state.user.id, _today])
            console.log(_sql)
        }
    }
    ctx.body = {
        ok: 1
    }
})

// 查询某个学生每个阶段的目标完成率
studentRouter.get('/api/v1/mytargets/target_tongji', async ctx=>{

    // 统计阶段完成率
    const _sql1 = `SELECT COUNT(*) total,r.cc,x.step_id,c.step_name
                    FROM st_targets x
                    LEFT JOIN (SELECT COUNT(*) cc,b.step_id
                                FROM st_student_targets a 
                                LEFT JOIN st_targets b ON a.target_id=b.id
                                    WHERE a.student_id = ? AND a.ischk=1
                                    GROUP BY b.step_id) r 
                    ON x.step_id=r.step_id
                    LEFT JOIN st_steps c ON c.id=x.step_id
                    WHERE x.step_id>0
                    GROUP BY x.step_id
                     ORDER BY x.step_id`
    await db.query('set sql_mode=""')
    const [rows, fields] = await db.query(_sql1, [ctx.state.user.id])

    ctx.body = {
        ok: 1,
        data: rows
    }
})

// 学生查询自己的目标
studentRouter.get('/api/v1/mytargets', async ctx=>{
    let _where = 1
    let values = [ctx.state.user.id]

    // 根据 type 搜索
    if(ctx.query.type) {
        _where += ' AND a.type=?'
        values.push(ctx.query.type)
    }

    if(ctx.query.step_id) {
        _where += ' AND a.step_id=? '
        values.push(ctx.query.step_id)
    }

    let _sql = `SELECT a.*,b.isok,b.ischk
                 FROM st_targets a
                  LEFT JOIN st_student_targets b ON (a.id=b.target_id AND b.student_id=?)
                   WHERE ${_where}
                   ORDER BY a.category ASC`

    const [rows, fields] = await db.query(_sql, values)
    ctx.body = {
        ok: 1,
        data: rows
    }
})

// 查询习题
routerNoJwt.get('/api/v1/questions', async ctx=>{
    if(ctx.query.id) {
        let _sql = 'SELECT * FROM st_questions WHERE id = ?'
        const [rows, fields] = await db.query(_sql, [ctx.query.id])
        ctx.body = {
            ok: 1,
            data: rows[0]
        }
    } else {
        let _where = ' WHERE 1 '
        let _value = []

        if(ctx.query.target_id) {
            _where += ' AND target_id=? '
            _value = [ctx.query.target_id]
        }

        let _sql1 = `SELECT COUNT(*) total FROM st_questions ${_where}`
        
        const [rows, fields] = await db.query(_sql1, _value)

        // 翻页
        let _limit = ''
        if(ctx.query.page) {
            let page = ctx.query.page || 1
            let per_page = ctx.query.per_page || 10
            let _offset = (page-1)*per_page
            _limit = ` LIMIT ${_offset},${per_page} `
        }
        
        let _sql2 = `SELECT * FROM st_questions ${_where} ${_limit}`
        const [data, dataFields] = await db.query(_sql2, _value)

        ctx.body = {
            ok: 1,
            data: {
                total: rows[0].total,
                list: data
            }
        }
    }  
})

// 查询学生
routerNoJwt.get('/api/v1/students', async ctx=>{
    if(ctx.query.id) {
        let _sql = 'SELECT * FROM st_students WHERE id = ?'
        const [rows, fields] = await db.query(_sql, [ctx.query.id])
        ctx.body = {
            ok: 1,
            data: rows[0]
        }
    } else {
        let _where = ' WHERE 1 '
        let _value = []

        if(ctx.query.class_id) {
            _where += ' AND class_id=? '
            _value = [ctx.query.class_id]
        }

        let _sql1 = `SELECT COUNT(*) total FROM st_students ${_where}`
        
        const [rows, fields] = await db.query(_sql1, _value)

        // 翻页
        let page = ctx.query.page || 1
        let per_page = ctx.query.per_page || 10
        let _offset = (page-1)*per_page
        let _sql2 = `SELECT * FROM st_students ${_where} LIMIT ${_offset},${per_page}`
        const [data, dataFields] = await db.query(_sql2, _value)

        ctx.body = {
            ok: 1,
            data: {
                total: rows[0].total,
                list: data
            }
        }
    }
})




/*************** 需要老师 JWT 验证的路由 */
// 验证令牌


const router = new Router()
// 添加班级
router.post('/api/v1/classes', async ctx=>{
    let _sql = 'INSERT INTO st_classes SET ?'
    let _data = {
        class_name: ctx.request.body.class_name
    }
    await db.query(_sql, _data)

    ctx.body = {
        ok: 1
    }
})

// 删除班级
router.delete('/api/v1/classes/:id', async ctx=>{
    let _sql = 'DELETE FROM st_classes WHERE id = ?'
    await db.query(_sql, [ctx.params.id])

    ctx.body = {
        ok: 1
    }
})

// 修改班级
router.put('/api/v1/classes/:id', async ctx=>{
    let _sql = 'UPDATE st_classes SET ? WHERE id = ?'
    let _data = {
        class_name: ctx.request.body.class_name
    }
    await db.query(_sql, [_data, ctx.params.id])

    ctx.body = {
        ok: 1
    }
})

/*************** 阶段管理 */
// 添加阶段
router.post('/api/v1/steps', async ctx=>{
    let _sql = 'INSERT INTO st_steps SET ?'
    let _data = {
        step_name: ctx.request.body.step_name,
        step_desc: ctx.request.body.step_desc,
    }
    await db.query(_sql, _data)

    ctx.body = {
        ok: 1
    }
})

// 删除阶段
router.delete('/api/v1/steps/:id', async ctx=>{
    let _sql = 'DELETE FROM st_steps WHERE id = ?'
    await db.query(_sql, [ctx.params.id])

    ctx.body = {
        ok: 1
    }
})

// 修改阶段
router.put('/api/v1/steps/:id', async ctx=>{
    let _sql = 'UPDATE st_steps SET ? WHERE id = ?'
    let _data = {
        step_name: ctx.request.body.step_name,
        step_desc: ctx.request.body.step_desc,
    }
    await db.query(_sql, [_data, ctx.params.id])

    ctx.body = {
        ok: 1
    }
})

/*************** 学生管理 */
// 添加学生
router.post('/api/v1/students', async ctx=>{
    let _sql = 'INSERT INTO st_students SET ?'
    let _data = {
        stu_name: ctx.request.body.stu_name,
        password: ctx.request.body.password,
        class_id: ctx.request.body.class_id
    }
    await db.query(_sql, _data)

    ctx.body = {
        ok: 1
    }
})

// 删除学生
router.delete('/api/v1/students/:id', async ctx=>{
    let _sql = 'DELETE FROM st_students WHERE id = ?'
    await db.query(_sql, [ctx.params.id])

    ctx.body = {
        ok: 1
    }
})

// 修改学生
router.put('/api/v1/students/:id', async ctx=>{
    let _sql = 'UPDATE st_students SET ? WHERE id = ?'
    let _data = {
        stu_name: ctx.request.body.stu_name,
        password: ctx.request.body.password,
        class_id: ctx.request.body.class_id
    }
    await db.query(_sql, [_data, ctx.params.id])

    ctx.body = {
        ok: 1
    }
})


/*************** 老师管理 */
// 添加老师
router.post('/api/v1/teachers', async ctx=>{
    let _sql = 'INSERT INTO st_teachers SET ?'
    let _data = {
        username: ctx.request.body.username,
        password: ctx.request.body.password
    }
    await db.query(_sql, _data)

    ctx.body = {
        ok: 1
    }
})

// 删除老师
router.delete('/api/v1/teachers/:id', async ctx=>{
    if(ctx.params.id === 1) {
        ctx.body = {
            ok: 0,
            error: '超级管理员不能删除'
        }
    } else {
        let _sql = 'DELETE FROM st_teachers WHERE id = ?'
        await db.query(_sql, [ctx.params.id])
        ctx.body = {
            ok: 1
        }
    }
})

// 修改老师
router.put('/api/v1/teachers/:id', async ctx=>{
    let _sql = 'UPDATE st_teachers SET ? WHERE id = ?'
    let _data = {
        username: ctx.request.body.username,
        password: ctx.request.body.password
    }
    await db.query(_sql, [_data, ctx.params.id])

    ctx.body = {
        ok: 1
    }
})

// 查询老师
router.get('/api/v1/teachers', async ctx=>{
    if(ctx.query.id) {
        let _sql = 'SELECT * FROM st_teachers WHERE id = ?'
        const [rows, fields] = await db.query(_sql, [ctx.query.id])
        ctx.body = {
            ok: 1,
            data: rows[0]
        }
    } else {
        let _sql1 = 'SELECT COUNT(*) total FROM st_teachers'
        const [rows, fields] = await db.query(_sql1)

        let page = ctx.query.page || 1
        let per_page = ctx.query.per_page || 10
        let _offset = (page-1)*per_page
        let _sql2 = `SELECT * FROM st_teachers LIMIT ${_offset},${per_page}`
        const [data, dataFields] = await db.query(_sql2)
        ctx.body = {
            ok: 1,
            data: {
                total: rows[0].total,
                list: data
            }
        }
    }
})

/*************** 目标管理 */
// 添加目标
router.post('/api/v1/targets', async ctx=>{
    let _sql = 'INSERT INTO st_targets SET ?'
    let _data = {
        title: ctx.request.body.title,
        category: ctx.request.body.category,
        type: ctx.request.body.type,
        step_id: ctx.request.body.step_id,
        description: ctx.request.body.description
    }
    await db.query(_sql, _data)

    ctx.body = {
        ok: 1
    }
})

// 删除目标
router.delete('/api/v1/targets/:id', async ctx=>{
    let _sql = 'DELETE FROM st_targets WHERE id = ?'
    await db.query(_sql, [ctx.params.id])

    ctx.body = {
        ok: 1
    }
})

// 修改目标
router.put('/api/v1/targets/:id', async ctx=>{
    let _sql = 'UPDATE st_targets SET ? WHERE id = ?'
    let _data = {
        title: ctx.request.body.title,
        category: ctx.request.body.category,
        type: ctx.request.body.type,
        step_id: ctx.request.body.step_id,
        description: ctx.request.body.description
    }
    await db.query(_sql, [_data, ctx.params.id])

    ctx.body = {
        ok: 1
    }
})

/*************** 习题管理 */
// 添加习题
router.post('/api/v1/questions', async ctx=>{
    let _sql = 'INSERT INTO st_questions SET ?'
    let _data = {
        question: ctx.request.body.question,
        options: ctx.request.body.options,
        answer: ctx.request.body.answer,
        target_id: ctx.request.body.target_id
    }
    await db.query(_sql, _data)

    ctx.body = {
        ok: 1
    }
})

// 删除习题
router.delete('/api/v1/questions/:id', async ctx=>{
    let _sql = 'DELETE FROM st_questions WHERE id = ?'
    await db.query(_sql, [ctx.params.id])

    ctx.body = {
        ok: 1
    }
})

// 修改习题
router.put('/api/v1/questions/:id', async ctx=>{
    let _sql = 'UPDATE st_questions SET ? WHERE id = ?'
    let _data = {
        question: ctx.request.body.question,
        options: ctx.request.body.options,
        answer: ctx.request.body.answer,
        target_id: ctx.request.body.target_id
    }
    await db.query(_sql, [_data, ctx.params.id])

    ctx.body = {
        ok: 1
    }
})

/*************** 目标完成情况 */
// 老师审核一个目标的掌握情况
router.put('/api/v1/students/:student_id/targets/:target_id', async ctx=>{
    let _sql = `REPLACE INTO st_student_targets SET ?`
    let _data = {
        student_id: ctx.params.student_id,
        target_id: ctx.params.target_id,
        ischk: ctx.request.body.ok
    }
    await db.query(_sql, _data)

    ctx.body = {
        ok: 1
    }
})

// 无须登录的路由
app.use(routerNoJwt.routes())
    .use(routerNoJwt.allowedMethods())

// 必须登录的路由
app.use(jwt.checkToken)
app.use(studentRouter.routes())
    .use(studentRouter.allowedMethods())

// 必须是老师登录的路由
app.use(jwt.checkTeacher)
app.use(router.routes())
    .use(router.allowedMethods())

app.listen(7000);