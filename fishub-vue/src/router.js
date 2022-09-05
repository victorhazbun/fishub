import Vue from "vue";
import Router from "vue-router";

import Signup from "./views/Signup";
import Signin from "./views/Signin";
import Baits from "./views/Baits";
import Activity from "./views/Activity";
import TackleBox from "./views/TackleBox";
import store from "./store";

Vue.use(Router);

export default new Router({
  mode: "history",
  base: process.env.BASE_URL,
  routes: [
    {
      path: "/baits",
      component: Baits
    },
    {
      path: "/tackle-box",
      component: TackleBox,
      beforeEnter: requireAuth
    },
    {
      path: "/activity",
      component: Activity
    },
    {
      path: "/sign-in",
      component: Signin
    },
    {
      path: "/sign-up",
      component: Signup
    },
    {
      path: "/sign-out",
      beforeEnter(to, from, next) {
        store.dispatch("signOut");
        next("sign-in");
      }
    },
    {
      path: "*",
      redirect: "/baits"
    }
  ],
  scrollBehavior(to, from, savedPosition) {
    if (savedPosition) {
      return savedPosition;
    } else {
      return { x: 0, y: 0 };
    }
  }
});

function requireAuth(to, from, next) {
  if (store.getters.isAuthenticated) {
    next();
  } else {
    next({
      path: "/sign-in",
      query: { redirect: to.fullPath }
    });
  }
}
