<template>
  <v-container>
    <v-row no-gutters>
      <v-col cols="12">
        <div class="header">チャットルーム一覧</div>
      </v-col>
      <v-col cols="12">
        <SideBarCard v-for="room in rooms" :key="room.id" :room="room" />
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { mapGetters } from 'vuex'

import SideBarCard from '../components/SideBarCard.vue'

export default {
  components: {
    SideBarCard,
  },
  computed: {
    ...mapGetters({
      rooms: 'room/getRooms',
    }),
  },
}
</script>

<style lang="scss" scoped>
.container {
  max-width: 100vw;
  height: 100%;
  padding: 0px;
}

.header {
  border-bottom: 1px solid rgb(215, 208, 208);
  font-size: 20px;
  height: 10vh;
  display: flex;
  justify-content: center;
  align-items: center;
}
</style>
