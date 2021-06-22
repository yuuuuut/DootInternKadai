json.room do
  json.id @room.id

  json.messages @messages do |message|
    json.body    message.body
    json.check   message.check
    json.user_id message.user_id

    json.user do
      json.id    message.user.id
      json.name  message.user.name
      json.image message.user.image || 'https://cdn.vuetifyjs.com/images/john.jpg'
    end
  end
end

json.pagination @pagination
