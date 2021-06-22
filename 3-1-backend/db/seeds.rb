user1 = User.create!(
  name: 'TestUser1',
  email: 'Test1@Test.com',
  password: 'password'
)

user2 = User.create!(
  name: 'TestUser2',
  email: 'Test2@Test.com',
  password: 'password'
)

user3 = User.create!(
  name: 'TestUser3',
  email: 'Test3@Test.com',
  password: 'password'
)


room = Room.create!

Entry.create!(
  user_id: user1.id,
  room_id: room.id
)

Entry.create!(
  user_id: user2.id,
  room_id: room.id
)

20.times do |n|
  Message.create!(
    user_id: user2.id,
    room_id: room.id,
    body: "#{n + 1}"
  )
end