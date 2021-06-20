<template>
  <v-container>
    <v-row no-gutters>
      <v-col>
        <div v-for="room in rooms" :key="room.id">
          <RoomCard :room="room" />
        </div>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import RoomCard from '../../components/rooms/RoomCard.vue'

export default {
  components: {
    RoomCard
  },
  data() {
    return {
      rooms: []
    }
  },
  mounted() {
    this.getRooms()
  },
  methods: {
    async getRooms() {
      const response = await this.$axios.get(`/api/v1/rooms`)

      this.rooms.push(...response.data.rooms)
    }
  }
}
</script>
