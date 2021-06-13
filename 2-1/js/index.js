'use strict'

const sendMessage = () => {
  const val = document.getElementById('input').value
  const input = document.getElementById('input')
  const chatId = document.getElementById('chat')

  if (!val) {
    alert('メッセージを入力してください。')
    return
  }

  const escapeVal = escape(val)
  const messageCode = `<div class="chat__right">
                        <div class="chat__message-right">
                          ${escapeVal}
                        </div>
                        <div class="chat__right-other">
                          <p>送信済</p>
                          <p>その他</p>
                          <p>12:35</p>
                        </div>
                      </div>`

  chatId.insertAdjacentHTML('beforeend', messageCode)
  sendOtherMessage()
  input.value = ''
}

const sendOtherMessage = () => {
  const chatId = document.getElementById('chat')
  const messageCode = `<div class="chat__left">
                        <img src="image/icon.jpg" class="chat__message-icon" />
                        <p class="chat__message-name">総務経理FAQ Cogmo Attend</p>
                        <div class="chat__message-b-col">
                          <div class="chat__message-left">ホゲホゲ</div>
                          <p class="chat__message-left-time">12:35</p>
                        </div>
                      </div>`

  chatId.insertAdjacentHTML('beforeend', messageCode)
}

const escape = (val) => {
  return val
    .replace(/\&/g, '&amp;')
    .replace(/\</g, '&lt;')
    .replace(/\>/g, '&gt;')
    .replace(/\"/g, '&quot;')
    .replace(/\'/g, '&#x27')
}

document.getElementById('btn').onclick = () => {
  sendMessage()
}
