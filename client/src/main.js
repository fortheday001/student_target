import Vue from 'vue'
import App from './App.vue'
import router from './router'
import axios from 'axios'
import ElementUI, { Message } from 'element-ui'
import store from './store'
import 'element-ui/lib/theme-chalk/index.css'
import config from './config'

axios.defaults.baseURL = `http://${config.ip}:7000/api`

axios.interceptors.request.use(function (config) {
  let token = localStorage.getItem('token')
  if (token) {
    config.headers.Authorization = 'Bearer ' + token
  }
  return config
})

// 请求后提示错误信息
axios.interceptors.response.use(function (response) {
  if (response.data.ok !== 1) {
    let errorMessage = response.data.error || '获取数据失败~'
    Message.error(errorMessage)
  } else {
    response.d = response.data.data
  }
  // Do something with response data
  return response
}, function (error) {
  Message.error('服务器连接失败~')
  // Do something with response error
  return Promise.reject(error)
})

Vue.prototype.$axios = axios

Vue.use(ElementUI)

Vue.config.productionTip = false

new Vue({
  store,
  router,
  render: h => h(App)
}).$mount('#app')
