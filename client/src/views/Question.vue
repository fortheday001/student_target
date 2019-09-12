<template>
  <div class="class">
    <el-row class="tool-box">
      <el-col :span="12">
        <el-select v-model="filter.target_id">
          <el-option label="所有目标" value=""></el-option>
          <el-option v-for="v in targetData" :key="v.id" :label="v.title" :value="v.id"></el-option>
        </el-select>
      </el-col>
      <el-col :span="12" class="buttons">
        <el-button @click="dialog.addDialog.show=true">添加新的记录</el-button>
      </el-col>
    </el-row>
    <div class="data-box">
      <el-card>
        <el-table :data="questionData" border>
          <el-table-column type="selection" width="40">
          </el-table-column>
          <el-table-column width="50" label="id" prop="id">
          </el-table-column>
          <el-table-column prop="question" label="问题">
          </el-table-column>
          <el-table-column prop="options" label="提示">
          </el-table-column>
          <el-table-column prop="answer" label="答案">
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
        <el-form-item label="选择目标" prop="target_id">
          <el-select v-model="form.target_id" placeholder="选择要查看的目标">
            <el-option label="所有目标" value=""></el-option>
            <el-option v-for="v in targetData" :key="v.id" :label="v.title" :value="v.id"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="问题" prop="question">
          <el-input autocomplete="off" v-model="form.question"></el-input>
        </el-form-item>
        <el-form-item label="提示/选项" prop="options">
          <el-input autocomplete="off" v-model="form.options" type="textarea" :rows="3"></el-input>
        </el-form-item>
        <el-form-item label="答案" prop="answer">
          <el-input autocomplete="off" v-model="form.answer" type="textarea" :rows="3"></el-input>
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
        question: '',
        answer: '',
        options: '',
        target_id: ''
      },
      filter: {
        target_id: '',
        page: 1,
        id: '',
        per_page: 20
      },
      total: 0,
      rules: {
        target_id: { required: true, message: '必须要选择一个目标' },
        question: { required: true, message: '必须输入问题' },
        answer: { required: true, message: '必须要输入答案' }
      },
      dialog: {
        addDialog: {
          show: false
        }
      },
      questionData: [],
      targetData: []
    }
  },
  watch: {
    filter: {
      deep: true,
      handler: function () {
        this.getQuestionData()
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
        this.$axios.delete(`/v1/questions/${id}`).then(res => {
          if (res.data.ok === 1) {
            this.getQuestionData()
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
          this.$axios.post('/v1/questions', this.form).then(res => {
            if (res.data.ok === 1) {
              this.getQuestionData()
              this.dialog.addDialog.show = false
            }
          })
        }
      })
    },
    getQuestionData () {
      // 获取习题数据
      this.$axios.get('/v1/questions', { params: this.filter }).then(res => {
        this.questionData = res.d.list
        this.total = res.d.total
      })
    },
    loadData () {
      this.getQuestionData()

      this.$axios.get('/v1/targets').then(res => {
        this.targetData = res.d.list
      })
    }
  },
  created () {
    this.loadData()
  }
}
</script>
