<template>
  <v-container>
    <v-row no-gutters>
      <v-col sm="4">
        <div class="d-none d-md-block overflow-y-auto sidebar">
          <v-toolbar dense class="sidebar__toolbar">
            <nuxt-link :to="`/`">
              <v-icon> mdi-chevron-left </v-icon>
            </nuxt-link>
          </v-toolbar>
          <SideBarCard v-for="room in rooms" :key="room.id" :room="room" />
        </div>
      </v-col>

      <v-col md="8">
        <v-row class="chat__container" ref="chatContainer" no-gutters>
          <v-col md="8">
            <Message
              v-for="(message, i) in roomMessages(
                Number(this.$route.params.id)
              )"
              :key="i"
              :message="message"
            />
          </v-col>
        </v-row>

        <v-row class="form__container" no-gutters>
          <v-col cols="10">
            <div class="d-flex align-center">
              <v-textarea
                label="メッセージ"
                no-resize
                rows="2"
                v-model="message"
              ></v-textarea>
              <v-btn
                @click="sendMessage"
                :disabled="!this.message"
                class="ml-3"
                depressed
                color="primary"
              >
                送信
              </v-btn>
            </div>
          </v-col>
        </v-row>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'

import SideBarCard from '../../components/SideBarCard.vue'
import Message from '../../components/Message.vue'

export default {
  components: {
    SideBarCard,
    Message,
  },
  data() {
    return {
      message: '',
    }
  },
  mounted() {
    this.scrollToBottom()
  },
  computed: {
    ...mapGetters({
      rooms: 'room/getRooms',
      getRoom: 'room/getRoom',
      messages: 'message/getMessages',
      roomMessages: 'message/getRoomMessages',
    }),
  },
  methods: {
    ...mapActions({
      createMessage: 'message/createMessage',
      updateMessage: 'message/updateMessage',
    }),
    sendMessage() {
      const data = {
        message: this.message,
        roomId: Number(this.$route.params.id),
        user: {
          id: 1,
          name: 'YUT',
          type: 'Current',
        },
      }

      this.createMessage(data)
      this.scrollToBottom()
      this.sendOtherMessage()
      this.message = ''
    },
    sendOtherMessage() {
      const room = this.getRoom(Number(this.$route.params.id))

      const data = {
        message:
          '自動返信です！自動返信です！自動返信です！自動返信です！自動返信です！',
        roomId: room.id,
        user: room.user,
      }

      this.$sleep(2000).then(() => {
        this.createMessage(data)
        this.scrollToBottom()
      })
    },
    scrollToBottom() {
      this.$sleep(1).then(() => {
        const ref = this.$refs.chatContainer
        if (ref) {
          ref.scrollTop = ref.scrollHeight
        }
      })
    },
  },
  watch: {
    messages() {
      this.updateMessage(Number(this.$route.params.id))
    },
  },
}
</script>

<style lang="scss" scoped>
.container {
  max-width: 100vw;
  padding: 0px;
}

.sidebar {
  border-right: 1px solid rgb(215, 208, 208);
  height: 100vh;

  &__toolbar {
    position: sticky;
    top: 0;
    z-index: 2;
  }
}

.chat__container {
  width: 100vw;
  height: 80vh;
  overflow: scroll;
}

.form__container {
  border-top: 1px solid rgb(215, 208, 208);
  height: 20vh;
  display: flex;
  justify-content: center;
  align-items: center;
}
</style>
