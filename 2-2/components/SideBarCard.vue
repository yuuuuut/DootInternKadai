<template>
  <nuxt-link :to="`/rooms/${room.id}`" @click.native="moveRoom">
    <v-card :class="isCurrentRoom" :elevation="0" outlined tile>
      <v-list-item three-line>
        <v-list-item-avatar>
          <v-avatar size="40">
            <img :src="room.user.icon" />
          </v-avatar>
        </v-list-item-avatar>
        <v-list-item-content>
          <div class="text-h7 mb-2 mt-2">{{ room.user.name }}</div>
          <v-list-item-title class="text-h8 mb-1">{{
            getLastMessage(room.id).message
          }}</v-list-item-title>
          <v-list-item-subtitle class="mb-2">{{
            getLastMessage(room.id).time
          }}</v-list-item-subtitle>
        </v-list-item-content>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-chip
            v-if="getNotCheckMessageCount(room.id)"
            class="ma-2"
            color="green"
            text-color="white"
          >
            {{ getNotCheckMessageCount(room.id) }}
          </v-chip>
        </v-card-actions>
      </v-list-item>
    </v-card>
  </nuxt-link>
</template>

<script>
import { mapState, mapGetters, mapActions } from 'vuex'

export default {
  props: {
    room: {
      type: Object,
      required: true,
    },
  },
  computed: {
    ...mapGetters({
      getLastMessage: 'message/getLastMessage',
      getNotCheckMessageCount: 'message/getNotCheckMessageCount',
    }),
    isCurrentRoom() {
      return {
        'light-blue lighten-5': Number(this.$route.params.id) === this.room.id,
      }
    },
  },
  methods: {
    ...mapActions({
      createMessage: 'message/createMessage',
      updateMessage: 'message/updateMessage',
    }),
    moveRoom() {
      this.updateMessage(Number(this.$route.params.id))
    },
  },
}
</script>

<style lang="scss" scoped></style>
