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
                type="button"
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
      message: '',
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
    this.getMessages({ page: 1 })
    this.updateMessages()

    this.$refs.chatContainer.addEventListener('scroll', this.handleScroll)
  },
  beforeDestroy() {
    this.$refs.chatContainer.removeEventListener('scroll', this.handleScroll)
  },
  methods: {
    async handleScroll() {
      const ref = this.$refs.chatContainer
      if (ref) {
        const beforeHeight = ref.scrollHeight

        if (ref.scrollTop === 0 && this.pagination.next !== null) {
          await this.getMessages({ page: this.pagination.next }, true)

          ref.scrollTop = ref.scrollHeight - beforeHeight
        }
      }
    },
    async getMessages(params, isNext) {
      const response = await this.$axios.get(
        `/api/v1/rooms/${this.$route.params.id}`,
        { params }
      )

      if (isNext) {
        this.messages = response.data.room.messages.concat(this.messages)
      } else {
        this.messages = response.data.room.messages
        this.scrollToBottom()
      }

      this.pagination = response.data.pagination
    },
    async updateMessages() {
      await this.$axios.put(
        `/api/v1/rooms/${this.$route.params.id}/messages`,
        {}
      )
    },
    async sendMessage() {
      const response = await this.$axios.post(
        `/api/v1/rooms/${this.$route.params.id}/messages`,
        {
          body: this.message
        }
      )

      this.messages.push(response.data.message)
      this.message = ''
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
