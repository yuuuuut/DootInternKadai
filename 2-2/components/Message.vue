<template>
  <div>
    <v-row>
      <v-col md="6">
        <div v-if="message.user.type === 'Other'" class="ma-5">
          <div class="d-flex align-end mb-3">
            <v-avatar>
              <img :src="message.user.icon" />
            </v-avatar>
            <div class="grey--text text--darken-3 ml-2">
              {{ message.user.name }}
            </div>
          </div>
          <div class="message">
            <div v-text="message.message"></div>
          </div>
          <div class="grey--text text--darken-1">{{ message.time }}</div>
        </div>
      </v-col>

      <v-col md="6">
        <div v-if="message.user.type === 'Current'" class="ma-5">
          <div class="d-flex justify-end">
            <div class="message">
              <div v-text="message.message"></div>
            </div>
          </div>
        </div>
      </v-col>
    </v-row>
  </div>
</template>

<script>
export default {
  props: {
    message: {
      type: Object,
      required: true,
    },
  },
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
