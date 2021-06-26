json.users @users do |user|
  json.id    user.id
  json.name  user.name
  json.image user.image || Variable::Default_image
end

json.pagination @pagination