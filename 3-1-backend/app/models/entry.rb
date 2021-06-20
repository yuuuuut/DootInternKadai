class Entry < ApplicationRecord
  belongs_to :user
  belongs_to :room

  # Entryを一括作成する。
  def self.create_entries(room_id, current_user_id, user_id)
    create(room_id: room_id, user_id: current_user_id)
    create(room_id: room_id, user_id: user_id)
  end
end
