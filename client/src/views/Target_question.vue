<template>
  <div class="target_question">
    <el-breadcrumb separator="/">
      <el-breadcrumb-item :to="{ path: '/' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>目标的练习题</el-breadcrumb-item>
    </el-breadcrumb>
    <div class="search-box">
      <el-select @change="targetChanged" v-model="currentTarget">
        <el-option label="所有目标" value=""></el-option>
        <el-option v-for="v in targetData" :key="v.id" :label="v.title" :value="v.id"></el-option>
      </el-select>
    </div>
    <div class="data-box">
      <el-card class="box-card">
        <el-table :data="questionData" border>
          <el-table-column type="expand" width="50">
            <template slot-scope="scope">
              <el-tag>答案：{{scope.row.answer}}</el-tag>
            </template>
          </el-table-column>
          <el-table-column type="index" width="50">
          </el-table-column>
          <el-table-column label="问题" prop="question">
          </el-table-column>
          <el-table-column label="提示" prop="options">
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
      currentType: this.$route.query.type,
      currentTarget: Number(this.$route.params.id),
      targetData: [],
      questionData: []
    }
  },
  computed: {
    currentTypeValue: function () {
      let ret = ''
      if (this.currentType === '知识点') ret = 0
      else if (this.currentType === '项目') ret = 1
      else if (this.currentType === '情商') ret = 2
      return ret
    }
  },
  methods: {
    getQuestionData (targetId) {
      // 获取某个目标的练习题
      this.$axios.get(`/v1/questions?target_id=${targetId}`).then(res => {
        this.questionData = res.d.list
      })
    },
    loadData () {
      // 获取所有的目标
      this.$axios.get('/v1/targets?type=' + this.currentTypeValue).then(res => {
        this.targetData = res.d.list
      })
      // 获取某个目标的练习题
      this.getQuestionData(this.currentTarget)
    },
    targetChanged (v) {
      this.getQuestionData(v)
    }
  },
  created () {
    this.loadData()
  }
}
</script>
