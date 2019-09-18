<template>
  <div class="student_target">
    <el-breadcrumb separator="/">
      <el-breadcrumb-item :to="{ path: '/' }">所有数据</el-breadcrumb-item>
      <el-breadcrumb-item>{{student.stu_name}} 的目标掌握情况</el-breadcrumb-item>
    </el-breadcrumb>
    <div class="search-box">
      <el-radio-group @change="typeChanged" v-model="currentType">
        <el-radio-button label="全部"></el-radio-button>
        <el-radio-button label="知识点"></el-radio-button>
        <el-radio-button label="项目"></el-radio-button>
        <el-radio-button label="情商"></el-radio-button>
      </el-radio-group>
      <el-select v-model="filter.step_id">
        <el-option v-for="v in stepData" :key="v.id" :label="v.step_name" :value="v.id"></el-option>
      </el-select>
    </div>
    <div class="data-box">
      <el-card class="box-card">
        <div slot="header">
          <el-row>
            <el-col :span="4">
              <h1>{{student.stu_name}}</h1>
            </el-col>
            <el-col v-for="v in tongji" :key="v.step_id" :span="2">
              <el-progress
              :width="100"
              type="circle"
              :percentage="(Number(v.cc)/v.total*100).toFixed(2)*1">
              </el-progress>
              <p class="tongji_txt">{{v.step_name}}</p>
            </el-col>
          </el-row>
        </div>
        <el-table :data="targetData" border>
          <el-table-column type="index" width="50">
          </el-table-column>
          <el-table-column label="类型" prop="type" width="100">
            <template slot-scope="scope">
              <el-tag v-if="scope.row.type==0">知识点</el-tag>
              <el-tag v-else-if="scope.row.type==1">项目</el-tag>
              <el-tag v-else-if="scope.row.type==2">情商</el-tag>
            </template>
          </el-table-column>
          <el-table-column label="已经掌握" width="100">
            <template slot-scope="scope">
              <el-switch :value="Boolean(scope.row.isok)"></el-switch>
            </template>
          </el-table-column>
          <el-table-column label="已经审核" width="100">
            <template slot-scope="scope">
              <el-switch @change="setChk(scope.row.id, scope.$index)"  :value="Boolean(scope.row.ischk)"></el-switch>
            </template>
          </el-table-column>
          <el-table-column label="分类" prop="category" width="200">
            <template slot-scope="scope">
              <el-tag type="danger">{{scope.row.category}}</el-tag>
            </template>
          </el-table-column>
          <el-table-column label="目标" prop="title">
          </el-table-column>
          <el-table-column width="100">
            <template slot-scope="scope">
              <el-button @click="$router.push(`/targets/${scope.row.id}/questions?type=${currentType}`)" size="mini" type="warning" plain>练习题</el-button>
            </template>
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
      currentType: '全部',
      filter: {
        step_id: 1
      },
      student: {
        stu_name: ''
      },
      targetData: [],
      stepData: [],
      tongji: []
    }
  },
  watch: {
    filter: {
      deep: true,
      handler: function () {
        this.getStudentsTargetsData()
      }
    }
  },
  methods: {
    typeChanged (v) {
      this.getStudentsTargetsData(v)
    },
    getStudentsTargetsData (type = '') {
      let url = `/v1/students/${this.$route.params.id}/targets?step_id=${this.filter.step_id}`
      if (type === '知识点') {
        url += '&type=0'
      } else if (type === '项目') {
        url += '&type=1'
      } else if (type === '情商') {
        url += '&type=2'
      }
      // 获取学生的目标情况
      this.$axios.get(url).then(res => {
        this.targetData = res.d
      })
    },
    loadData () {
      // 查询某个学生的信息
      this.$axios.get(`/v1/students?id=${this.$route.params.id}`).then(res => {
        this.student = res.d
      })

      // 查询某个学生每个阶段的目标完成率
      this.$axios.get(`/v1/students/${this.$route.params.id}/target_tongji`).then(res => {
        this.tongji = res.d
      })

      this.getStudentsTargetsData()

      // 获取阶段数据
      this.$axios.get('/v1/steps').then(res => {
        this.stepData = res.d.list
      })
    },
    setChk (id, k) {
      let data = {
        ok: !this.targetData[k].ischk
      }
      this.$axios.put(`/v1/students/${this.$route.params.id}/targets/${id}`, data).then(res => {
        if (res.data.ok === 1) {
          this.targetData[k].ischk = Number(!this.targetData[k].ischk)
        }
      })
    }
  },
  created () {
    this.loadData()
  }
}
</script>

<style lang="less">
  .search-box {
    margin-bottom: 20px;
  }
  .student_target {
    .el-progress {
      margin-right: 10px;
      background: #fbecd9;
      border-radius: 50%;
    }
    .tongji_txt {
      font-size: 12px;
      color: #909399;
    }
  }
</style>
