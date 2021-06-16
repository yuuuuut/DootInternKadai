/**
 * 現在の日付をフォーマットして返します。
 * @return {string} - YYYY/MM/DD HH:MM:SS
 */
const getNowDate = () => {
  const date = new Date()
  return date.toLocaleString()
}

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

export default ({}, inject) => {
  inject('getNowDate', getNowDate)
  inject('sleep', sleep)
}
