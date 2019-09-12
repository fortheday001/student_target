import Vue from 'vue'
import Router from 'vue-router'
import Index from './views/Index.vue'

const originalPush = Router.prototype.push
Router.prototype.push = function push (location) {
  return originalPush.call(this, location).catch(err => err)
}

Vue.use(Router)

export default new Router({
  mode: 'history',
  base: process.env.BASE_URL,
  routes: [
    {
      path: '/',
      component: Index
    },
    {
      path: '/logout',
      redirect: '/login'
    },
    {
      path: '/students/:id/targets',
      component: () => import('./views/Student_target.vue')
    },
    {
      path: '/targets/:id/questions',
      component: () => import('./views/Target_question.vue')
    },
    {
      path: '/login',
      component: () => import('./views/Login.vue')
    },
    {
      path: '/students',
      component: () => import('./views/Student.vue')
    },
    {
      path: '/classes',
      component: () => import('./views/Class.vue')
    },
    {
      path: '/teachers',
      component: () => import('./views/Teacher.vue')
    },
    {
      path: '/questions',
      component: () => import('./views/Question.vue')
    },
    {
      path: '/targets',
      component: () => import('./views/Target.vue')
    },
    {
      path: '/mypassword',
      component: () => import('./views/Mypassword.vue')
    },
    {
      path: '/mytargets',
      component: () => import('./views/Mytargets.vue')
    }
  ]
})
