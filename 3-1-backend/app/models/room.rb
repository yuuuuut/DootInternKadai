class Room < ApplicationRecord
  before_create :generate_uuid

  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :users, through: :entries

  # Roomを作成する際にidをuuidにする。
  def generate_uuid
    self.id = loop do
      uuid = SecureRandom.uuid
      break uuid unless self.class.exists?(id: uuid)
    end
  end

  # RoomとそのRoomに関連するUserとでEntryを作成する。
  # いずれかの処理に失敗した場合はRollbackする。
  def self.room_with_entry_create(current_user_id, user_id)
    ActiveRecord::Base.transaction do
      room = create

      Entry.create_entries(room.id, current_user_id, user_id)

      room
    end
  end

  # roomに必要な情報を付与する。
  def self.room_add_necessary_information(rooms, current_user)
    rooms.map do |r|
      room = r.attributes
      room[:user] = r.users.find { |u| u.id != current_user.id }
      room[:last_message] = r.messages.last
      room[:unread_message_count] = r.messages.select { |m| !m.check && m.user_id != current_user.id }.length

      room
    end
  end
end
