<template>
  <v-container>
    <v-row no-gutters>
      <v-col>
        <div v-for="user in users" :key="user.id">
          <UserCard :user="user" />
        </div>
      </v-col>
    </v-row>
    <v-row no-gutters>
      <v-col>
        <div
          v-if="pagination.current < pagination.pages"
          class="d-flex justify-center"
        >
          <v-btn class="ma-2" color="success" @click="nextPage">
            もっと読み込む
          </v-btn>
        </div>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import UserCard from '../../components/users/UserCard.vue'

export default {
  components: {
    UserCard
  },
  data() {
    return {
      users: [],
      page: 1,
      pagination: {
        count: 0,
        current: 0,
        limit_value: 0,
        next: 0,
        pages: 0,
        previous: null
      }
    }
  },
  mounted() {
    this.getUsers({ page: 1 })
  },
  methods: {
    async getUsers(params, isNext) {
      const response = await this.$axios.get('/api/v1/users', { params })

      if (isNext) {
        this.users = this.users.concat(response.data.users)
      } else {
        this.users = response.data.users
      }

      this.pagination = response.data.pagination
    },
    async nextPage() {
      await this.getUsers({ page: this.pagination.next }, true)
    }
  }
}
</script>
