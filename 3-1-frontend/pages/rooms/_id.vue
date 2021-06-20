<template>
  <v-container>
    <v-row no-gutters>
      <v-col>
        <v-row ref="chatContainer" class="chat__container" no-gutters>
          <v-col>
            <Message v-for="(m, i) in messages" :key="i" :message="m" />
          </v-col>
        </v-row>

        <v-row class="form__container" no-gutters>
          <v-col cols="10">
            <div class="d-flex align-center">
              <v-textarea
                v-model="message"
                label="メッセージ"
                no-resize
                rows="2"
              ></v-textarea>
              <v-btn
                :disabled="!message"
                class="ml-3"
                depressed
                color="primary"
                @click="sendMessage"
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
import Message from '../../components/Message.vue'

export default {
  components: {
    Message
  },
  data() {
    return {
      messages: [],
      message: ''
    }
  },
  mounted() {
    this.getMessages()
    this.updateMessages()
  },
  methods: {
    async updateMessages() {
      const roomId = this.$route.params.id

      await this.$axios.put(`/api/v1/rooms/${roomId}/messages`, {})
    },
    async getMessages() {
      const roomId = this.$route.params.id

      const response = await this.$axios.get(`/api/v1/rooms/${roomId}`)

      this.messages.push(...response.data.room.messages)
      this.scrollToBottom()
    },
    async sendMessage() {
      const roomId = this.$route.params.id

      const response = await this.$axios.post(
        `/api/v1/rooms/${roomId}/messages`,
        {
          body: this.message
        }
      )

      this.messages.push(response.data.message)
      this.scrollToBottom()
    },
    scrollToBottom() {
      this.$sleep(1).then(() => {
        const ref = this.$refs.chatContainer
        if (ref) {
          ref.scrollTop = ref.scrollHeight
        }
      })
    }
  }
}
</script>

<style lang="scss" scoped>
.container {
  max-width: 100vw;
  height: 500px;
  padding: 0px;
}

.chat__container {
  width: 100vw;
  height: 65vh;
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
