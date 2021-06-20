json.user do
  json.id     @user.id
  json.name   @user.name
  json.image  @user.image || 'https://cdn.vuetifyjs.com/images/john.jpg'

  if current_user.id != @user.id
    json.isRoom @is_room
    json.roomId @room_id
  end
end
