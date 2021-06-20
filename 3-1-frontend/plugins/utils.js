/**
 * sleep function
 * @param {number} waitTime
 */
const sleep = (waitTime) => {
  return new Promise((resolve) => {
    setTimeout(() => {
      resolve()
    }, waitTime)
  })
}

export default (_, inject) => {
  inject('sleep', sleep)
}
