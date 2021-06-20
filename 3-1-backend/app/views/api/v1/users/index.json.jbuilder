json.users @users do |user|
  json.id    user.id
  json.name  user.name
  json.image user.image || 'https://cdn.vuetifyjs.com/images/john.jpg'
end
