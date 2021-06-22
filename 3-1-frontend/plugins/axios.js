export default function({ $axios, store, redirect, error }) {
  $axios.onRequest((config) => {
    store.commit('loading/setLoading', true)

    if (process.client) {
      config.headers['access-token'] = localStorage.getItem('access-token')
      config.headers.client = localStorage.getItem('client')
      config.headers.uid = localStorage.getItem('uid')
    }
  })

  $axios.onResponse((response) => {
    store.commit('loading/setLoading', false)
    if (
      response.headers.client &&
      response.headers.uid &&
      response.headers['access-token']
    ) {
      localStorage.setItem('access-token', response.headers['access-token'])
      localStorage.setItem('client', response.headers.client)
      localStorage.setItem('uid', response.headers.uid)
    }
  })

  $axios.onError((e) => {
    store.commit('loading/setLoading', false)
    if (e.response) {
      if (e.response.status === 401) {
        redirect('/login')
      } else if (e.response.status === 403) {
        redirect('/')
      } else if (e.response.status === 404) {
        error({ statusCode: 404 })
      }
    }
    return Promise.reject(e)
  })
}
