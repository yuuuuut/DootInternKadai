export const state = () => {
  return {
    messages: [
      {
        check: true,
        message: 'ヤッホー',
        time: '2021/6/13 22:35:59',
        roomId: 1,
        user: {
          id: 2,
          type: 'Other',
          name: 'ホゲホゲ君',
          icon: 'https://cdn.vuetifyjs.com/images/john.jpg',
        },
      },
      {
        check: false,
        message: '元気？',
        time: '2021/6/13 22:35:59',
        roomId: 2,
        user: {
          id: 3,
          type: 'Other',
          name: 'フガフガ君',
          icon: 'https://avatars0.githubusercontent.com/u/9064066?v=4&s=460',
        },
      },
    ],
  }
}

export const mutations = {
  setMessages(state, messages) {
    state.messages = messages
  },
  create(state, message) {
    state.messages.push({ ...message, check: false, time: this.$getNowDate() })
  },
  update(state, roomId) {
    state.messages.map((m) => {
      if (m.roomId === roomId && !m.check) {
        m.check = true
      }
    })
  },
}

export const getters = {
  getMessages: (state) => {
    return state.messages
  },
  getRoomMessages: (state, getters, rootState, rootGetters) => (roomId) => {
    return state.messages.filter((m) => m.roomId === roomId)
  },
  getLastMessage: (state, getters) => (roomId) => {
    return getters.getRoomMessages(roomId).slice(-1)[0]
  },
  getNotCheckMessageCount: (state, getters) => (roomId) => {
    return getters
      .getRoomMessages(roomId)
      .filter((m) => !m.check && m.user.id !== 1).length
  },
}

export const actions = {
  createMessage({ commit }, message) {
    commit('create', message)
  },
  updateMessage({ commit }, roomId) {
    commit('update', roomId)
  },
}
