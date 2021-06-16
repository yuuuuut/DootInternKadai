export const state = () => {
  return {
    rooms: [
      {
        id: 1,
        user: {
          id: 2,
          type: 'Other',
          name: 'ホゲホゲ君',
          icon: 'https://cdn.vuetifyjs.com/images/john.jpg',
        },
      },
      {
        id: 2,
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

export const getters = {
  getRooms: (state) => {
    return state.rooms
  },
  getRoom: (state) => (roomId) => {
    return state.rooms.find((r) => r.id === roomId)
  },
}
