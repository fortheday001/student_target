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

        <el-select v-model="filter.category" placeholder="选择分类">
          <el-option label="所有分类" value=""></el-option>
          <el-option v-for="(v, k) in target_category" :key="k" :label="v" :value="v"></el-option>
        </el-select>

        <el-select v-model="filter.step_id">
          <el-option label="所有阶段" value=""></el-option>
          <el-option v-for="v in stepData" :key="v.id" :label="v.step_name" :value="v.id"></el-option>
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
          <el-table-column label="分类" prop="category" width="200">
            <template slot-scope="scope">
              <el-tag type="danger">{{scope.row.category}}</el-tag>
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
        <el-form-item label="分类" prop="category">
          <el-select v-model="form.category">
            <el-option v-for="(v, k) in target_category" :key="k" :label="v" :value="v"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="阶段" prop="step_id">
          <el-select v-model="form.step_id">
            <el-option v-for="v in stepData" :key="v.id" :label="v.step_name" :value="v.id"></el-option>
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
      target_category: [
        '01.HTML',
        '02.CSS',
        '03.JS基础语法',
        '04.DOM操作',
        '05.BOM操作',
        '06.异步操作',
        '07.ES678',
        '08.Node',
        '09.npm',
        '10.Node第三方模块',
        '11.Vue基础',
        '12.Vue组件',
        '13.Vue路由',
        '14.Vuex',
        '15.客户端接口调用',
        '16.服务器端接口开发',
        '17.MySQL',
        '18.RESTFul API',
        '19.在线商城',
        '20.项目开发'
      ],
      form: {
        title: '',
        category: '',
        type: '',
        step_id: ''
      },
      filter: {
        type: '',
        category: '',
        step_id: '',
        page: 1,
        id: '',
        per_page: 999
      },
      total: 0,
      rules: {
        title: { required: true, message: '标题不能为空' },
        category: { required: true, message: '必须选择一个分类' },
        step_id: { required: true, message: '必须选择一个阶段' },
        type: { required: true, message: '必须要选择类型' }
      },
      dialog: {
        addDialog: {
          show: false
        }
      },
      targetData: [],
      stepData: []
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

      // 获取阶段数据
      this.$axios.get('/v1/steps').then(res => {
        this.stepData = res.d.list
      })
    }
  },
  created () {
    this.loadData()
  }
}
</script>
