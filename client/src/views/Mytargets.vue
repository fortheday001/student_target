<template>
  <div class="student_target">
    <div class="search-box">
      <el-radio-group @change="typeChanged" v-model="currentType">
        <el-radio-button label="全部"></el-radio-button>
        <el-radio-button label="知识点"></el-radio-button>
        <el-radio-button label="项目"></el-radio-button>
        <el-radio-button label="情商"></el-radio-button>
      </el-radio-group>
    </div>
    <div class="data-box">
      <el-card class="box-card">
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
              <el-switch @change="setOk(scope.row.id, scope.$index)" :value="Boolean(scope.row.isok)"></el-switch>
            </template>
          </el-table-column>
          <el-table-column label="已经审核" width="100">
            <template slot-scope="scope">
              <el-switch :value="Boolean(scope.row.ischk)"></el-switch>
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
      targetData: []
    }
  },
  methods: {
    typeChanged (v) {
      this.getStudentsTargetsData(v)
    },
    getStudentsTargetsData (type = '') {
      let url = `/v1/mytargets`
      if (type === '知识点') {
        url += '?type=0'
      } else if (type === '项目') {
        url += '?type=1'
      } else if (type === '情商') {
        url += '?type=2'
      }
      // 获取学生的目标情况
      this.$axios.get(url).then(res => {
        this.targetData = res.d
      })
    },
    loadData () {
      this.getStudentsTargetsData()
    },
    setOk (id, k) {
      let data = {
        ok: !this.targetData[k].isok
      }
      this.$axios.put(`/v1/mytargets/${id}`, data).then(res => {
        if (res.data.ok === 1) {
          this.targetData[k].isok = Number(!this.targetData[k].isok)
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
</style>
