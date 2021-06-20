export const state = () => ({
  user: null
})

export const getters = {
  isLogin: (state) => !!state.user,
  currentUser: (state) => (state.user ? state.user : null)
}

export const mutations = {
  setUser(state, user) {
    state.user = user
  }
}

export const actions = {
  async register(context, data) {
    try {
      const response = await this.$axios.post('/api/v1/auth', data)
      if (response.data.data) context.commit('setUser', response.data.data)
    } catch (e) {
      return e.response.data.errors.full_messages
    }
  },
  async login(context, data) {
    try {
      const response = await this.$axios.post('/api/v1/auth/sign_in', data)
      if (response.data.data) context.commit('setUser', response.data.data)
    } catch (e) {
      return e.response.data.errors
    }
  },
  async logout(context) {
    await this.$axios.delete('/api/v1/auth/sign_out')

    localStorage.removeItem('access-token')
    localStorage.removeItem('client')
    localStorage.removeItem('uid')

    context.commit('setUser', null)
  },
  async currentUser(context) {
    const response = await this.$axios.get('/api/v1/auth/sessions')

    const user = response.data || null
    context.commit('setUser', user)
  }
}
