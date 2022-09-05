import Vue from "vue";
import Vuex from "vuex";

import api from "./api";

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    tackleBoxItems: [],
    user: JSON.parse(localStorage.getItem("user"))
  },
  getters: {
    tackleBoxItemCount: state => state.tackleBoxItems.length,
    isAuthenticated: state => !!state.user
  },
  mutations: {
    setTackleBoxItems(state, items) {
      state.tackleBoxItems = items;
    },
    addTackleBoxItem(state, item) {
      state.tackleBoxItems.push(item);
    },
    setUser(state, user) {
      state.user = user;
      localStorage.setItem("user", JSON.stringify(user));
    },
    clearUser(state) {
      state.user = null;
      localStorage.removeItem("user");
      state.tackleBoxItems = [];
    }
  },
  actions: {
    getTackleBoxItems({ commit }) {
      if (this.getters.isAuthenticated) {
        api.getTackleBoxItems().then(response => {
          commit("setTackleBoxItems", response.data);
        });
      }
    },
    createTackleBoxItem({ commit }, baitId) {
      api.createTackleBoxItem(baitId).then(response => {
        commit("addTackleBoxItem", response.data);
      });
    },
    signIn({ commit }, { username, password }) {
      // The Promise used for router redirect in Signin.vue
      return new Promise((resolve, reject) => {
        api
          .createSession(username, password)
          .then(response => {
            commit("setUser", response.data);
            this.dispatch("getTackleBoxItems");
            resolve();
          })
          .catch(error => {
            // if the request fails, clear user
            commit("clearUser");
            reject(error.response.data.error);
          });
      });
    },
    signUp({ commit }, { username, password }) {
      // The Promise used for router redirect in Signup.vue
      return new Promise((resolve, reject) => {
        api
          .createUser(username, password)
          .then(response => {
            commit("setUser", response.data);
            this.dispatch("getTackleBoxItems");
            resolve();
          })
          .catch(error => {
            commit("clearUser");
            reject(error.response.data.errors);
          });
      });
    },
    signOut({ commit }) {
      // The Promise used for router redirect in Header.vue
      return new Promise(resolve => {
        api.deleteSession().then(() => {
          commit("clearUser");
          resolve();
        });
      });
    }
  }
});
