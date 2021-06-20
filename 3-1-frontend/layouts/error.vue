<template>
  <v-container>
    <v-row no-gutters>
      <v-col>
        <div class="d-flex flex-column align-center">
          <p class="text-h1 grey--text text--darken-3">
            {{ error.statusCode }}
          </p>
          <p @click="$router.go(-1)">前のページへ戻る</p>
        </div>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
export default {
  props: {
    error: {
      type: Object,
      default: null
    }
  }
}
</script>
