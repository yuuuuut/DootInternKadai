<template>
  <nuxt-link :to="`/rooms/${room.id}`">
    <v-card
      class="d-flex justify-space-between align-center px-5 mb-3"
      style="height: 80px"
    >
      <div class="d-flex align-center">
        <v-avatar>
          <img :src="room.user.image" />
        </v-avatar>
        <div class="ml-3">{{ room.user.name }}</div>
        <v-divider class="mx-2" vertical></v-divider>
        <div v-if="room.last_message" class="ml-1">
          <div class="grey--text text--darken-2">
            {{ room.last_message.body | filterMessage }}
          </div>
        </div>
      </div>
      <v-chip
        v-if="room.unread_message_count"
        class="ma-2"
        color="green"
        text-color="white"
      >
        {{ room.unread_message_count }}
      </v-chip>
    </v-card>
  </nuxt-link>
</template>

<script>
export default {
  filters: {
    filterMessage(message) {
      const maxNum = 30
      return message.length > maxNum ? message.slice(0, maxNum) + '…' : message
    }
  },
  props: {
    room: {
      type: Object,
      required: true
    }
  }
}
</script>
