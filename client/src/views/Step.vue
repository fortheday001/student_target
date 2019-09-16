<template>
  <div class="step">
    <div class="tool-box">
      <el-button @click="dialog.addDialog.show=true">添加新的记录</el-button>
    </div>
    <div class="data-box">
      <el-card>
        <el-table :data="stepData" border>
          <el-table-column width="50" label="id" prop="id">
          </el-table-column>
          <el-table-column prop="step_name" label="阶段名称">
          </el-table-column>
          <el-table-column prop="step_desc" label="阶段描述">
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
        <el-form-item label="阶段名称" prop="step_name">
          <el-input autocomplete="off" v-model="form.step_name" placeholder="请输入阶段名称"></el-input>
        </el-form-item>
        <el-form-item label="阶段描述" prop="step_desc">
          <el-input type="textarea" :row="8" autocomplete="off" v-model="form.step_desc" placeholder="请输入阶段描述"></el-input>
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
        step_name: '',
        step_desc: ''
      },
      dialog: {
        addDialog: {
          show: false
        }
      },
      rules: {
        step_name: { required: true, message: '必须输入阶段名称' }
      },
      stepData: []
    }
  },
  methods: {
    deleteClicked (id) {
      this.$confirm('确定要删除吗？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.$axios.delete(`/v1/steps/${id}`).then(res => {
          if (res.data.ok === 1) {
            this.getStepData()
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
          this.$axios.post('/v1/steps', this.form).then(res => {
            if (res.data.ok === 1) {
              this.getStepData()
              this.dialog.addDialog.show = false
            }
          })
        }
      })
    },
    getStepData () {
    // 获取习题数据
      this.$axios.get('/v1/steps').then(res => {
        this.stepData = res.d.list
      })
    }
  },
  created () {
    this.getStepData()
  }
}
</script>
