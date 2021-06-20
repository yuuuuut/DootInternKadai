<template>
  <div v-show="isLoading">
    <v-overlay :value="true">
      <div class="d-flex flex-column align-center">
        <img src="/loading.gif" width="200" />
        <div class="mt-1 text-h5">Loading...</div>
      </div>
    </v-overlay>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  computed: {
    ...mapGetters({
      isLoading: 'loading/isLoading'
    })
  }
}
</script>
