<template>
  <div class="class">
    <div class="tool-box">
      <el-button @click="dialog.addDialog.show=true">添加今天日报</el-button>
    </div>
    <div class="data-box">
      <el-card>
        <el-table :data="dayReportData" border>
          <el-table-column
          width="150"
          label="日期"
          :formatter="dateFormat"
          prop="date">
          </el-table-column>
          <el-table-column label="内容" prop="content">
          </el-table-column>
        </el-table>
        <br>
        <el-pagination
          background
          layout="prev, pager, next"
          :total="total"
          :current-page.sync="filter.page"
          :page-size="filter.per_page">
        </el-pagination>
      </el-card>
    </div>
    <!-- 添加的表单 -->
    <el-dialog title="添加日报" :visible.sync="dialog.addDialog.show">
      <el-form ref="addform" :rules="rules" :model="form">
        <el-form-item label="内容（最多3000字）" prop="content">
          <el-input autocomplete="off" v-model="form.content" type="textarea" :rows="3"></el-input>
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
        content: ''
      },
      filter: {
        page: 1,
        per_page: 20
      },
      total: 0,
      rules: {
        content: { required: true, message: '日报内容不能为空' }
      },
      dialog: {
        addDialog: {
          show: false
        }
      },
      dayReportData: []
    }
  },
  watch: {
    filter: {
      deep: true,
      handler: function () {
        this.getDayReportData()
      }
    }
  },
  methods: {
    dateFormat: function (row, column) {
      var t = new Date(row.date)
      return t.getFullYear() + '-' + (t.getMonth() + 1) + '-' + t.getDate()
    },
    addFormSubmit () {
      this.$refs.addform.validate(valid => {
        if (valid) {
          this.$axios.post('/v1/day_reports', this.form).then(res => {
            if (res.data.ok === 1) {
              this.getDayReportData()
              this.dialog.addDialog.show = false
            }
          })
        }
      })
    },
    getDayReportData () {
      // 获取习题数据
      this.$axios.get('/v1/mydayreports', { params: this.filter }).then(res => {
        this.dayReportData = res.d.list
        this.total = res.d.total
      })
    },
    loadData () {
      this.getDayReportData()
    }
  },
  created () {
    this.loadData()
  }
}
</script>
