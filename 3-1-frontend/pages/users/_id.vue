<template>
  <v-container>
    <v-row no-gutters>
      <v-col lg="12">
        <div v-if="!loading">
          <div class="d-flex flex-column align-center">
            <v-avatar size="100">
              <img :src="user.image" />
            </v-avatar>
            <div class="text-h4 grey--text text--darken-2 my-7">
              {{ user.name }}
            </div>
            <div v-if="currentUser.id !== user.id">
              <div v-if="user.isRoom">
                <nuxt-link :to="`/rooms/${user.roomId}`">
                  <v-btn color="primary">
                    Roomへ移動
                  </v-btn>
                </nuxt-link>
              </div>
              <div v-else>
                <v-btn color="success" @click="createRoom(user.id)">
                  Roomを作成
                </v-btn>
              </div>
            </div>
          </div>
        </div>
        <div v-else>
          <p>Loading...</p>
        </div>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  data() {
    return {
      user: null,
      loading: false
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/currentUser'
    })
  },
  created() {
    this.getUser()
  },
  methods: {
    async getUser() {
      this.loading = true
      const userId = this.$route.params.id

      const response = await this.$axios.get(`/api/v1/users/${userId}`)

      this.user = response.data.user
      this.loading = false
    },
    async createRoom(userId) {
      const response = await this.$axios.post(
        `/api/v1/users/${userId}/rooms`,
        {}
      )

      const roomId = response.data.room.id
      if (!roomId) return

      this.$router.push(`/rooms/${roomId}`)
    }
  }
}
</script>

<style></style>
