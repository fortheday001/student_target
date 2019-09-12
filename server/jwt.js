var jwt = require('jsonwebtoken');

// 加密 KEY
const key = 'fjdl;safj;3$#trefadsHJFDA.FDA12#$%#@$EQWD;fda'
// 过期时间
const expire = 86400  // 24小时，单位：秒

function create(data) {
    return jwt.sign(data, key, { expiresIn: expire })
}

async function checkTeacher(ctx, next) {
    if(ctx.state.user.type == 'teacher') {
        await next()
    } else {
        ctx.body = {
            ok: 0,
            error: '令牌无效'
        }
    }
}

async function checkToken(ctx, next) {
    if(!ctx.headers.authorization) {
        ctx.body = {
            ok: 0,
            error: '令牌无效'
        }
    } else {
        // 验证令牌
        await jwt.verify(ctx.headers.authorization.substring(7), key, async (err, encoded)=>{
            // 如果出错，说明令牌过期或者是假令牌
            if(err) {
                ctx.body = {
                    ok: 0,
                    error: '令牌无效'
                }
            }
            else {
                ctx.state.user = encoded
                await next()
            }
        })
    }
}



module.exports = {
    create,
    checkToken,
    checkTeacher
}