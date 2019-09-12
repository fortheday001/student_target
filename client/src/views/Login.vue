<template>
  <el-card class="login">
    <div slot="header">
      登录
    </div>
    <el-form ref="login" :rules="rules" :form="form" :model="form" label-width="80px">
      <el-form-item>
        <el-radio-group v-model="loginType">
          <el-radio-button label="学生登录"></el-radio-button>
          <el-radio-button label="老师登录"></el-radio-button>
        </el-radio-group>
      </el-form-item>
      <el-form-item label="用户名" prop="username">
        <el-input v-model="form.username"></el-input>
      </el-form-item>
      <el-form-item label="密码" prop="password">
        <el-input v-model="form.password"></el-input>
      </el-form-item>
      <el-form-item>
        <el-button @click="submit()" type="primary">登录</el-button>
      </el-form-item>
    </el-form>
  </el-card>
</template>

<script>
import { mapMutations } from 'vuex'

export default {
  data () {
    return {
      loginType: '学生登录',
      rules: {
        username: { required: true, message: '用户名不能为空' },
        password: { required: true, message: '密码不能为空' }
      },
      form: {
        username: '',
        password: ''
      }
    }
  },
  methods: {
    ...mapMutations([
      'setLogin'
    ]),
    submit () {
      this.$refs.login.validate(valid => {
        if (valid) {
          let url
          if (this.loginType === '学生登录') {
            url = '/v1/students/access_tokens'
          } else {
            url = '/v1/teachers/access_tokens'
          }
          this.$axios.post(url, this.form).then(res => {
            if (res.data.ok === 1) {
              // 保存到浏览器
              localStorage.setItem('token', res.d.token)
              localStorage.setItem('username', this.form.username)
              localStorage.setItem('type', this.loginType)

              // 更新导航条的登录状态
              this.setLogin({
                username: this.form.username,
                type: this.loginType
              })

              // 跳转
              this.$router.push('/')
            }
          })
        }
      })
    }
  }
}
</script>

<style lang="less">
.login {
  width: 500px;
  height: 350px;
  position: absolute;
  left: 50%;
  transform: translateX(-50%);
}
</style>
