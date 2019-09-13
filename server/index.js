const Koa = require('koa');
const Router = require('koa-router');
const db = require('./db')
const jwt = require('./jwt')
const bodyParser = require('koa-bodyparser');
const cors = require('@koa/cors');

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
                    WHERE a.id=b.student_id AND c.type=0) type0,
                    (SELECT COUNT(*) 
                    FROM st_student_targets b 
                    LEFT JOIN st_targets c ON b.target_id=c.id
                    WHERE a.id=b.student_id AND c.type=1) type1,
                    (SELECT COUNT(*) 
                    FROM st_student_targets b 
                    LEFT JOIN st_targets c ON b.target_id=c.id
                    WHERE a.id=b.student_id AND c.type=2) type2
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
    let _sql = `SELECT a.*,b.isok,b.ischk
                 FROM st_targets a
                  LEFT JOIN st_student_targets b ON (a.id=b.target_id AND b.student_id=?)
                   ORDER BY a.category ASC`

    let values = [ctx.params.id]

    // 根据 type 搜索
    if(ctx.query.type) {
        _sql += ' WHERE a.type=?'
        values.push(ctx.query.type)
    }

    const [rows, fields] = await db.query(_sql, values)
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

app.use(routerNoJwt.routes())
    .use(routerNoJwt.allowedMethods())

app.use(jwt.checkToken)

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

// 学生查询自己的目标
studentRouter.get('/api/v1/mytargets', async ctx=>{
    let _sql = `SELECT a.*,b.isok,b.ischk
                 FROM st_targets a
                  LEFT JOIN st_student_targets b ON (a.id=b.target_id AND b.student_id=?)
                   ORDER BY a.category ASC`

    let values = [ctx.state.user.id]

    // 根据 type 搜索
    if(ctx.query.type) {
        _sql += ' WHERE a.type=?'
        values.push(ctx.query.type)
    }

    const [rows, fields] = await db.query(_sql, values)
    ctx.body = {
        ok: 1,
        data: rows
    }
})

// 查询习题
studentRouter.get('/api/v1/questions', async ctx=>{
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
        let page = ctx.query.page || 1
        let per_page = ctx.query.per_page || 10
        let _offset = (page-1)*per_page
        let _sql2 = `SELECT * FROM st_questions ${_where} LIMIT ${_offset},${per_page}`
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

// 查询目标
studentRouter.get('/api/v1/targets', async ctx=>{
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
            _value = [ctx.query.type]
        }

        let _sql1 = `SELECT COUNT(*) total FROM st_targets ${_where}`
        
        const [rows, fields] = await db.query(_sql1, _value)

        // 翻页
        let page = ctx.query.page || 1
        let per_page = ctx.query.per_page || 10
        let _offset = (page-1)*per_page
        let _sql2 = `SELECT * FROM st_targets ${_where} ORDER BY category ASC LIMIT ${_offset},${per_page}`
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

app.use(studentRouter.routes())
    .use(studentRouter.allowedMethods())


/*************** 需要老师 JWT 验证的路由 */
// 验证令牌
app.use(jwt.checkTeacher)

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

// 查询学生
router.get('/api/v1/students', async ctx=>{
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
        type: ctx.request.body.type
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
        type: ctx.request.body.type
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


app.use(router.routes())
    .use(router.allowedMethods())

app.listen(7000);