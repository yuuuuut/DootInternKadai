<template>
  <v-container>
    <v-row no-gutters>
      <v-col>
        <div v-for="user in users" :key="user.id">
          <UserCard :user="user" />
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
      users: []
    }
  },
  mounted() {
    this.getUsers()
  },
  methods: {
    async getUsers() {
      const response = await this.$axios.get('/api/v1/users')

      this.users.push(...response.data.users)
    }
  }
}
</script>
