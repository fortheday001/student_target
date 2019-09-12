<template>
  <el-container>
    <el-header>
      <el-menu
        :default-active="$route.path"
        :router="true"
        mode="horizontal"
        background-color="#545c64"
        text-color="#fff"
        active-text-color="#ffd04b">
        <el-menu-item index="/">所有数据</el-menu-item>
        <template v-if="logined">
          <el-menu-item index="/mytargets">我的目标</el-menu-item>
          <template v-if="type=='老师登录'">
            <el-menu-item index="/classes">班级管理</el-menu-item>
            <el-menu-item index="/students">学生管理</el-menu-item>
            <el-menu-item index="/teachers">老师管理</el-menu-item>
            <el-menu-item index="/targets">目标管理</el-menu-item>
            <el-menu-item index="/questions">习题管理</el-menu-item>
          </template>
          <el-menu-item index="/logout" @click="logout">{{username}} 退出</el-menu-item>
        </template>
        <template v-else>
          <el-menu-item index="/login">登录</el-menu-item>
        </template>
      </el-menu>
    </el-header>
    <el-main><router-view /></el-main>
  </el-container>
</template>

<script>
import { mapState, mapMutations, mapActions } from 'vuex'
export default {
  created () {
    this.chkLogin()
  },
  data () {
    return {

    }
  },
  computed: {
    ...mapState([
      'logined',
      'username',
      'type'
    ])
  },
  methods: {
    ...mapMutations([
      'setLogout'
    ]),
    ...mapActions([
      'chkLogin'
    ]),
    logout () {
      this.setLogout()
      localStorage.clear()
    }
  }
}
</script>

<style lang="less">
  html,body {
    margin: 0;
    padding: 0;
  }
  .el-card__header {
    background-color: #E4E7ED;
  }
  .el-breadcrumb {
    margin-bottom: 20px;
  }
  .tool-box {
    margin-bottom: 20px;
    .buttons {
      text-align: right;
    }
  }
  .data-box {
    .footer {
      margin-top: 20px;
    }
    .el-pagination {
      text-align: right;
    }
  }
  .search-box {
    margin-bottom: 20px;
  }
</style>
