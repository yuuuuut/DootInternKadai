<template>
  <nuxt-link :to="`/users/${user.id}`">
    <v-card class="d-flex align-center mb-3 pa-5" style="height: 80px">
      <v-avatar>
        <img :src="user.image" />
      </v-avatar>
      <div class="ml-3">{{ user.name }}</div>
    </v-card>
  </nuxt-link>
</template>

<script>
export default {
  props: {
    user: {
      type: Object,
      required: true
    }
  }
}
</script>
