<template>
  <el-card class="mypassword">
    <div slot="header">
      修改密码
    </div>
    <el-form ref="password" :rules="rules" :form="form" :model="form" label-width="80px">
      <el-form-item label="旧密码" prop="oldpassword">
        <el-input v-model="form.oldpassword"></el-input>
      </el-form-item>
      <el-form-item label="新密码" prop="newpassword">
        <el-input v-model="form.newpassword"></el-input>
      </el-form-item>
      <el-form-item>
        <el-button @click="submit()" type="primary">确定修改</el-button>
      </el-form-item>
    </el-form>
  </el-card>
</template>

<script>
import { mapMutations } from 'vuex'

export default {
  data () {
    return {
      rules: {
        oldpassword: { required: true, message: '旧密码不能为空' },
        newpassword: { required: true, message: '新密码不能为空' }
      },
      form: {
        oldpassword: '',
        newpassword: ''
      }
    }
  },
  methods: {
    ...mapMutations([
      'setLogout'
    ]),
    submit () {
      this.$refs.password.validate(valid => {
        if (valid) {
          this.$axios.put('/v1/students/password', this.form).then(res => {
            if (res.data.ok === 1) {
              this.$message.success('密码修改成功，请重新登录')
              this.setLogout()
              this.$router.push('/login')
            }
          })
        }
      })
    }
  }
}
</script>

<style lang="less">
.mypassword {
  width: 500px;
  height: 300px;
  position: absolute;
  left: 50%;
  transform: translateX(-50%);
}
</style>
