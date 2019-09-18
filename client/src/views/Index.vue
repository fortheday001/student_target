<template>
  <div class="index">
    <div class="search-box">
      <el-row>
        <el-col :span="4">
          <el-select @change="classChanged" v-model="currentClass" placeholder="选择要查看的班级">
            <el-option label="选择要查看的班级" value="0"></el-option>
            <el-option v-for="(v, k) in classData" :key="k" :label="v.class_name" :value="v.id"></el-option>
          </el-select>
        </el-col>
        <el-col :span="20">
          <span class="c_info k_txt">知识点</span>
          <span class="c_info p_txt">项目</span>
          <span class="c_info e_txt">情商</span>
        </el-col>
      </el-row>
    </div>
    <div class="data-box">
      <el-card class="data-box">
        <el-table :data="studentTargets" border>
          <el-table-column type="index" width="50">
          </el-table-column>
          <el-table-column prop="stu_name" label="学生姓名" width="150">
          </el-table-column>
          <el-table-column label="目标完成情况">
            <template slot-scope="scope">
              <el-progress :percentage="scope.row.type0/(targetTotalCount.type0_total||1)*100" color="#67C23A"></el-progress>
              <el-progress :percentage="scope.row.type1/(targetTotalCount.type1_total||1)*100" color="#E6A23C"></el-progress>
              <el-progress :percentage="scope.row.type2/(targetTotalCount.type2_total||1)*100" color="#F56C6C"></el-progress>
            </template>
          </el-table-column>
          <el-table-column prop="day1" label="近 1 天掌握" width="100">
          </el-table-column>
          <el-table-column prop="day2" label="近 2 天掌握" width="100">
          </el-table-column>
          <el-table-column prop="day3" label="近 3 天掌握" width="100">
          </el-table-column>
          <el-table-column width="80">
            <template slot-scope="scope">
              <el-button size="mini" @click="$router.push(`/students/${scope.row.stu_id}/targets`)">详情</el-button>
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
      currentClass: '0',
      classData: [],
      studentTargets: [],
      targetTotalCount: {
        type0_total: 0,
        type1_total: 0,
        type2_total: 0
      }
    }
  },
  methods: {
    loadData () {
      // 获取班级数据
      this.$axios.get('/v1/classes').then(res => {
        this.classData = res.d.list
      })
    },
    classChanged (v) {
      if (v === 0) {
        this.studentTargets = []
      } else {
        this.$axios.get(`/v1/classes/${v}/targets`).then(res => {
          this.studentTargets = res.d.list
          this.targetTotalCount = {
            type0_total: res.d.type0_total,
            type1_total: res.d.type1_total,
            type2_total: res.d.type2_total
          }
        })
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
