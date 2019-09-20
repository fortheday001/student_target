<template>
  <div class="class">
    <div class="tool-box">
      <el-button @click="dialog.addPlanDialog.show=true">添加学习计划</el-button>
      <el-button @click="dialog.addDialog.show=true">添加学习日报</el-button>
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
          <el-table-column prop="plan" label="学习计划">
          </el-table-column>
          <el-table-column prop="content" label="学习日报">
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
    <!-- 添加学习计划 -->
    <el-dialog title="添加学习计划" :visible.sync="dialog.addPlanDialog.show">
      <el-form ref="addplanform" :rules="rules" :model="planform">
        <el-form-item label="今日学习计划（最多2500字），写写今天自习时的学习计划" prop="plan">
          <el-input autocomplete="off" v-model="planform.plan" type="textarea" :rows="3"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer">
        <el-button @click="dialog.addPlanDialog.show = false">取 消</el-button>
        <el-button type="primary" @click="addPlanFormSubmit">确 定</el-button>
      </div>
    </el-dialog>
    <!-- 添加学习日报 -->
    <el-dialog title="添加学习日报" :visible.sync="dialog.addDialog.show">
      <el-form ref="addform" :rules="rules" :model="form">
        <el-form-item label="今日工作总结（最多2500字），写写今天的学习成果、遇到的问题、心得、建议等" prop="content">
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
      planform: {
        plan: ''
      },
      filter: {
        page: 1,
        per_page: 20
      },
      total: 0,
      rules: {
        content: { required: true, message: '内容不能为空' },
        plan: { required: true, message: '内容不能为空' }
      },
      dialog: {
        addDialog: {
          show: false
        },
        addPlanDialog: {
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
    addPlanFormSubmit () {
      this.$refs.addplanform.validate(valid => {
        if (valid) {
          this.$axios.post('/v1/day_reports', this.planform).then(res => {
            if (res.data.ok === 1) {
              this.getDayReportData()
              this.dialog.addPlanDialog.show = false
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
