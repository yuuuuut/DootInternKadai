<template>
  <v-container>
    <v-row no-gutters>
      <v-col lg="12">
        <v-card>
          <form
            class="d-flex flex-column align-center pa-5"
            @submit.prevent="sendForm"
          >
            <div class="text-h3 grey--text text--darken-1">ログイン</div>
            <div v-if="errorMessages">
              <div v-for="(e, i) in errorMessages" :key="i">
                <div class="red--text my-3">{{ e }}</div>
              </div>
            </div>
            <v-col lg="12">
              <v-text-field
                v-model="loginForm.email"
                type="email"
                label="メールアドレス"
                outlined
              ></v-text-field>

              <v-text-field
                v-model="loginForm.password"
                type="password"
                label="パスワード"
                outlined
              ></v-text-field>
            </v-col>

            <v-btn type="submit" color="primary" depressed>
              ログイン
            </v-btn>
            <nuxt-link to="/register" class="mt-4 grey--text text--darken-1">
              登録していない方はこちら
            </nuxt-link>
          </form>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { mapActions } from 'vuex'

export default {
  data() {
    return {
      loginForm: {
        email: 'test1@test.com',
        password: 'password'
      },
      errorMessages: null
    }
  },
  methods: {
    ...mapActions({
      login: 'auth/login'
    }),
    async sendForm() {
      const isError = await this.login(this.loginForm)
      if (isError) {
        this.errorMessages = isError
        return
      }
      this.$router.push('/')
    }
  }
}
</script>
