<template>
  <div class="index">
    <div class="search-box">
      <el-select @change="filterChanged" v-model="filter.class_id" placeholder="选择要查看的班级">
        <el-option label="选择要查看的班级" value="0"></el-option>
        <el-option v-for="(v, k) in classData" :key="k" :label="v.class_name" :value="v.id"></el-option>
      </el-select>
      <el-date-picker
      @change="filterChanged"
      v-model="filter.date"
      align="right"
      type="date"
      value-format="yyyy-MM-dd">
      placeholder="选择日期">
    </el-date-picker>
    </div>
    <div class="data-box">
      <el-card class="data-box">
        <el-table :data="dayReports" border>
          <el-table-column prop="date" label="日期" width="150" :formatter="dateFormat">
          </el-table-column>
          <el-table-column prop="stu_name" label="学生姓名" width="100">
          </el-table-column>
          <el-table-column prop="plan" label="今日学习计划">
          </el-table-column>
          <el-table-column prop="content" label="今日学习总结">
          </el-table-column>
        </el-table>
      </el-card>
    </div>
  </div>
</template>

<script>
export default {
  data () {
    return {
      filter: {
        class_id: '',
        date: ''
      },
      classData: [],
      dayReports: []
    }
  },
  methods: {
    dateFormat: function (row, column) {
      var t = new Date(row.date)
      return t.getFullYear() + '-' + (t.getMonth() + 1) + '-' + t.getDate()
    },
    loadData () {
      // 获取班级数据
      this.$axios.get('/v1/classes').then(res => {
        this.classData = res.d.list
      })
    },
    getDayReportData () {
      // 获取班级数据
      this.$axios.get(`/v1/classes/${this.filter.class_id}/day_reports/${this.filter.date}`).then(res => {
        this.dayReports = res.d
      })
    },
    filterChanged () {
      if (this.filter.class_id !== '' && this.filter.date !== '') {
        this.getDayReportData()
      }
    }
  },
  created () {
    this.loadData()
  }
}
</script>

<style lang="less">
.index {
  .c_info {
    padding: 10px;
    display: inline-block;
    margin-right: 10px;
    color: #909399;
    font-size: 12px;
    border-bottom-style: solid;
    border-bottom-width: 3px;
  }
  .k_txt {
    border-bottom-color: #5bc347;
  }
  .p_txt {
    border-bottom-color: #e9a349;
  }
  .e_txt {
    border-bottom-color: #fb6c6f;
  }
}
</style>
