class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  include DeviseTokenAuth::Concerns::User

  validates :name, presence: true

  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :rooms, through: :entries

  # userとのroomが存在するか確認。
  # 存在した場合は、そのroomIdも返す。
  def user_with_room(user)
    current_user_room_ids = rooms.pluck(:id)
    user_room_ids = user.rooms.pluck(:id)

    room = current_user_room_ids & user_room_ids
    is_room = room.present?
    room_id = is_room ? room[0] : ''

    [room_id, is_room]
  end
end
