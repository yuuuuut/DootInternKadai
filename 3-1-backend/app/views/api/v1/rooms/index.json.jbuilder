json.rooms @add_information_rooms do |room|
  json.id                   room['id']
  json.unread_message_count room[:unread_message_count]

  json.user do
    json.id    room[:user][:id]
    json.name  room[:user][:name]
    json.image room[:user][:image] || Variable::Default_image
  end

  if room[:last_message].present?
    json.last_message do
      json.body room[:last_message]['body']
    end
  end
end

json.pagination @pagination