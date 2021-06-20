export const state = () => ({
  loading: false
})

export const getters = {
  isLoading: (state) => state.loading
}

export const mutations = {
  setLoading(state, bool) {
    state.loading = bool
  }
}
