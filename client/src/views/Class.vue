<template>
  <div class="class">
    <div class="tool-box">
      <el-button @click="dialog.addDialog.show=true">添加新的记录</el-button>
    </div>
    <div class="data-box">
      <el-card>
        <el-table :data="classData" border>
          <el-table-column width="50" label="id" prop="id">
          </el-table-column>
          <el-table-column prop="class_name" label="班级名称">
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
        <el-form-item label="班级名称" prop="class_name">
          <el-input autocomplete="off" v-model="form.class_name" placeholder="请输入班级名称"></el-input>
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
        class_name: ''
      },
      dialog: {
        addDialog: {
          show: false
        }
      },
      rules: {
        class_name: { required: true, message: '必须输入班级名称' }
      },
      classData: []
    }
  },
  methods: {
    deleteClicked (id) {
      this.$confirm('确定要删除吗？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.$axios.delete(`/v1/classes/${id}`).then(res => {
          if (res.data.ok === 1) {
            this.getClassData()
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
          this.$axios.post('/v1/classes', this.form).then(res => {
            if (res.data.ok === 1) {
              this.getClassData()
              this.dialog.addDialog.show = false
            }
          })
        }
      })
    },
    getClassData () {
    // 获取习题数据
      this.$axios.get('/v1/classes').then(res => {
        this.classData = res.d.list
      })
    }
  },
  created () {
    this.getClassData()
  }
}
</script>
