<template>
  <div class="class">
    <el-row class="tool-box">
      <el-col :span="12">
        <el-select v-model="filter.class_id">
          <el-option label="所有班级" value=""></el-option>
          <el-option v-for="v in classData" :key="v.id" :label="v.class_name" :value="v.id"></el-option>
        </el-select>
      </el-col>
      <el-col :span="12" class="buttons">
        <el-button @click="dialog.addDialog.show=true">添加新的记录</el-button>
      </el-col>
    </el-row>
    <div class="data-box">
      <el-card>
        <el-table :data="studentData" border>
          <el-table-column type="selection" width="40">
          </el-table-column>
          <el-table-column width="50" label="id" prop="id">
          </el-table-column>
          <el-table-column prop="stu_name" label="姓名">
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
        <el-row class="footer">
          <el-col :span="10">
            <el-button size="mini" type="danger">删除所选</el-button>
          </el-col>
          <el-col :span="14">
            <el-pagination
              background
              layout="prev, pager, next"
              :total="total"
              :current-page.sync="filter.page"
              :page-size="filter.per_page">
            </el-pagination>
          </el-col>
        </el-row>
      </el-card>
    </div>
    <!-- 添加的表单 -->
    <el-dialog title="添加新记录" :visible.sync="dialog.addDialog.show">
      <el-form ref="addform" :rules="rules" :model="form">
        <el-form-item label="选择班级" prop="target_id">
          <el-select v-model="form.class_id" placeholder="选择班级">
            <el-option v-for="v in classData" :key="v.id" :label="v.class_name" :value="v.id"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="姓名" prop="stu_name">
          <el-input autocomplete="off" v-model="form.stu_name"></el-input>
        </el-form-item>
        <el-form-item label="密码" prop="password">
          <el-input autocomplete="off" v-model="form.password"></el-input>
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
        stu_name: '',
        password: '',
        class_id: ''
      },
      filter: {
        class_id: '',
        page: 1,
        id: '',
        per_page: 20
      },
      total: 0,
      rules: {
        stu_name: { required: true, message: '学生姓名不能为空' },
        password: { required: true, message: '密码不能为空' }
      },
      dialog: {
        addDialog: {
          show: false
        }
      },
      studentData: [],
      classData: []
    }
  },
  watch: {
    filter: {
      deep: true,
      handler: function () {
        this.getStudentData()
      }
    }
  },
  methods: {
    deleteClicked (id) {
      this.$confirm('确定要删除吗？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.$axios.delete(`/v1/students/${id}`).then(res => {
          if (res.data.ok === 1) {
            this.getStudentData()
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
          this.$axios.post('/v1/students', this.form).then(res => {
            if (res.data.ok === 1) {
              this.getStudentData()
              this.dialog.addDialog.show = false
            }
          })
        }
      })
    },
    getStudentData () {
      // 获取习题数据
      this.$axios.get('/v1/students', { params: this.filter }).then(res => {
        this.studentData = res.d.list
        this.total = res.d.total
      })
    },
    loadData () {
      this.getStudentData()

      this.$axios.get('/v1/classes').then(res => {
        this.classData = res.d.list
      })
    }
  },
  created () {
    this.loadData()
  }
}
</script>
