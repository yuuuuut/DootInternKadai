<template>
  <v-app>
    <header class="mb-7">
      <v-app-bar app dark>
        <nuxt-link to="/">
          <v-toolbar-title>Chat App</v-toolbar-title>
        </nuxt-link>
        <div v-if="isLogin" class="d-flex">
          <nuxt-link to="/users" class="ml-10">users</nuxt-link>
          <nuxt-link to="/rooms" class="ml-5">
            rooms
          </nuxt-link>
        </div>
        <v-spacer></v-spacer>
        <div v-if="isLogin">
          <v-btn color="cyan" @click="clickLogout">
            ログアウト
          </v-btn>
        </div>
        <div v-else>
          <nuxt-link to="/login">
            <v-btn color="cyan">
              ログイン
            </v-btn>
          </nuxt-link>
        </div>
      </v-app-bar>
    </header>
    <v-main>
      <Nuxt />
    </v-main>
  </v-app>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'

export default {
  computed: {
    ...mapGetters({
      isLogin: 'auth/isLogin',
      currentUser: 'auth/currentUser'
    })
  },
  created() {
    this.getCurrentUser()
  },
  methods: {
    ...mapActions({
      logout: 'auth/logout',
      getCurrentUser: 'auth/currentUser'
    }),
    async clickLogout() {
      await this.logout()
      this.$router.push('/')
    }
  }
}
</script>
