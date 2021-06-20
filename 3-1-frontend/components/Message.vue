<template>
  <div>
    <v-row>
      <v-col md="6">
        <div v-if="message.user_id !== currentUser.id" class="ma-5">
          <div class="d-flex align-end mb-3">
            <v-avatar>
              <img :src="message.user.image" />
            </v-avatar>
            <div class="grey--text text--darken-3 ml-2">
              {{ message.user.name }}
            </div>
          </div>
          <div class="message">
            <div v-text="message.body"></div>
          </div>
        </div>
      </v-col>

      <v-col md="6">
        <div v-if="message.user_id === currentUser.id" class="ma-5">
          <div class="d-flex justify-end">
            <div class="message">
              <div v-text="message.body"></div>
            </div>
          </div>
        </div>
      </v-col>
    </v-row>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  props: {
    message: {
      type: Object,
      required: true
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/currentUser'
    })
  }
}
</script>

<style lang="scss" scoped>
.message {
  background: rgb(141, 228, 123);
  border-radius: 5px;
  display: inline-block;
  max-width: 350px;
  padding: 10px;
  word-break: break-all;
  white-space: pre-wrap;
}
</style>
