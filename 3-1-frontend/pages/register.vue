<template>
  <v-container>
    <v-row no-gutters>
      <v-col lg="12">
        <v-card>
          <form
            class="d-flex flex-column align-center pa-5"
            @submit.prevent="sendForm"
          >
            <div class="text-h3 grey--text text--darken-1">新規登録</div>
            <div v-if="errorMessages">
              <div v-for="(e, i) in errorMessages" :key="i">
                <div class="red--text my-3">{{ e }}</div>
              </div>
            </div>
            <v-col lg="12">
              <v-text-field
                v-model="registerForm.name"
                label="名前"
                outlined
              ></v-text-field>

              <v-text-field
                v-model="registerForm.email"
                type="email"
                label="メールアドレス"
                outlined
              ></v-text-field>

              <v-text-field
                v-model="registerForm.password"
                type="password"
                label="パスワード"
                outlined
              ></v-text-field>

              <v-text-field
                v-model="registerForm.password_confirmation"
                type="password"
                label="パスワード(確認)"
                outlined
              ></v-text-field>
            </v-col>

            <v-btn type="submit" color="primary" depressed>
              登録
            </v-btn>
            <nuxt-link to="/login" class="mt-4 grey--text text--darken-1">
              登録済みの方はこちら
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
      registerForm: {
        email: '',
        password: '',
        password_confirmation: '',
        name: ''
      },
      errorMessages: null
    }
  },
  methods: {
    ...mapActions({
      register: 'auth/register'
    }),
    async sendForm() {
      const isError = await this.register(this.registerForm)

      if (isError) {
        this.errorMessages = isError
        return
      }
      this.$router.push('/')
    }
  }
}
</script>
