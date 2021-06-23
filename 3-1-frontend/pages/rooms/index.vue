<template>
  <div v-if="!pageLoading">
    <v-container>
      <v-row no-gutters>
        <v-col>
          <div v-if="rooms.length">
            <div v-for="room in rooms" :key="room.id">
              <RoomCard :room="room" />
            </div>
          </div>
          <div v-else class="d-flex flex-column align-center">
            <p>Roomがありません。</p>
            <p>
              <nuxt-link to="/users">こちら</nuxt-link
              >からチャット相手を探しましょう。
            </p>
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
  </div>
</template>

<script>
import RoomCard from '../../components/rooms/RoomCard.vue'

export default {
  components: {
    RoomCard
  },
  data() {
    return {
      rooms: [],
      pageLoading: true,
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
    this.getRooms({ page: 1 })
  },
  methods: {
    async getRooms(params, isNext) {
      const response = await this.$axios.get('/api/v1/rooms', { params })

      if (isNext) {
        this.rooms = this.rooms.concat(response.data.rooms)
      } else {
        this.rooms = response.data.rooms
      }

      this.pagination = response.data.pagination
      this.pageLoading = false
    },
    async nextPage() {
      await this.getRooms({ page: this.pagination.next }, true)
    }
  }
}
</script>
