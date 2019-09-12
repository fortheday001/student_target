<template>
  <div class="class">
    <el-row class="tool-box">
      <el-col :span="12">
        <el-select v-model="filter.type">
          <el-option label="所有类型" value=""></el-option>
          <el-option label="知识点" value="0"></el-option>
          <el-option label="项目" value="1"></el-option>
          <el-option label="情商" value="2"></el-option>
        </el-select>
      </el-col>
      <el-col :span="12" class="buttons">
        <el-button @click="dialog.addDialog.show=true">添加新的记录</el-button>
      </el-col>
    </el-row>
    <div class="data-box">
      <el-card>
        <el-table :data="targetData" border>
          <el-table-column type="selection" width="40">
          </el-table-column>
          <el-table-column width="50" label="id" prop="id">
          </el-table-column>
          <el-table-column prop="options" label="类型" width="100">
            <template slot-scope="scope">
              <el-tag v-if="scope.row.type==0">知识点</el-tag>
              <el-tag v-else-if="scope.row.type==1">项目</el-tag>
              <el-tag v-else-if="scope.row.type==2">情商</el-tag>
            </template>
          </el-table-column>
          <el-table-column prop="title" label="标题">
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
        <el-form-item label="类型" prop="type">
          <el-select v-model="form.type">
            <el-option label="知识点" value="0"></el-option>
            <el-option label="项目" value="1"></el-option>
            <el-option label="情商" value="2"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="标题" prop="title">
          <el-input autocomplete="off" v-model="form.title"></el-input>
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
        title: '',
        type: ''
      },
      filter: {
        type: '',
        page: 1,
        id: '',
        per_page: 20
      },
      total: 0,
      rules: {
        title: { required: true, message: '标题不能为空' },
        type: { required: true, message: '必须要选择类型' }
      },
      dialog: {
        addDialog: {
          show: false
        }
      },
      targetData: []
    }
  },
  watch: {
    filter: {
      deep: true,
      handler: function () {
        this.getTargetData()
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
        this.$axios.delete(`/v1/targets/${id}`).then(res => {
          if (res.data.ok === 1) {
            this.getTargetData()
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
          this.$axios.post('/v1/targets', this.form).then(res => {
            if (res.data.ok === 1) {
              this.getTargetData()
              this.dialog.addDialog.show = false
            }
          })
        }
      })
    },
    getTargetData () {
      // 获取习题数据
      this.$axios.get('/v1/targets', { params: this.filter }).then(res => {
        this.targetData = res.d.list
        this.total = res.d.total
      })
    },
    loadData () {
      this.getTargetData()

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
