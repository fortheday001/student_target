import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    logined: false,
    username: '',
    type: ''
  },
  mutations: {
    setLogin (state, data) {
      state.logined = true
      state.username = data.username
      state.type = data.type
    },
    setLogout (state) {
      state.logined = false
      state.username = ''
      state.type = ''
    }
  },
  actions: {
    chkLogin (context) {
      let username = localStorage.getItem('username')
      let type = localStorage.getItem('type')
      if (username) {
        context.commit('setLogin', {
          username,
          type
        })
      }
    }
  }
})
