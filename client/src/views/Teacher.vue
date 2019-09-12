<template>
  <div class="class">
    <div class="tool-box">
      <el-button @click="dialog.addDialog.show=true">添加新的记录</el-button>
    </div>
    <div class="data-box">
      <el-card>
        <el-table :data="teacherData" border>
          <el-table-column width="50" label="id" prop="id">
          </el-table-column>
          <el-table-column prop="username" label="姓名">
          </el-table-column>
          <el-table-column prop="password" label="密码">
          </el-table-column>
          <el-table-column width="150" label="操作">
            <template slot-scope="scope">
              <el-button size="mini">修改</el-button>
              <el-button @click="deleteClicked(scope.row.id)" size="mini" type="danger">删除</el-button>
            </template>
          </el-table-column>
        </el-table>
      </el-card>
    </div>

    <!-- 添加班级的表单 -->
    <el-dialog title="添加新记录" :visible.sync="dialog.addDialog.show">
      <el-form ref="addform" :rules="rules" :model="form">
        <el-form-item label="用户名" prop="username">
          <el-input autocomplete="off" v-model="form.username" placeholder="请输入用户名"></el-input>
        </el-form-item>
        <el-form-item label="密码" prop="password">
          <el-input autocomplete="off" v-model="form.password" placeholder="请输入密码"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer">
        <el-button @click="dialog.addDialog.show = false">取 消</el-button>
        <el-button type="primary" @click="addFormSubmit">确 定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
export default {
  data () {
    return {
      form: {
        username: '',
        password: ''
      },
      dialog: {
        addDialog: {
          show: false
        }
      },
      rules: {
        username: { required: true, message: '用户名不能为空' },
        password: { required: true, message: '密码不能为空' }
      },
      teacherData: []
    }
  },
  methods: {
    deleteClicked (id) {
      this.$confirm('确定要删除吗？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.$axios.delete(`/v1/teachers/${id}`).then(res => {
          if (res.data.ok === 1) {
            this.getTeacherData()
            this.$message({
              type: 'success',
              message: '删除成功!'
            })
          }
        })
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消删除'
        })
      })
    },
    addFormSubmit () {
      this.$refs.addform.validate(valid => {
        if (valid) {
          this.$axios.post('/v1/teachers', this.form).then(res => {
            if (res.data.ok === 1) {
              this.getTeacherData()
              this.dialog.addDialog.show = false
            }
          })
        }
      })
    },
    getTeacherData () {
    // 获取习题数据
      this.$axios.get('/v1/teachers').then(res => {
        this.teacherData = res.d.list
      })
    }
  },
  created () {
    this.getTeacherData()
  }
}
</script>
