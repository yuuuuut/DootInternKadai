class CreateRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :rooms, id: false do |t|
      t.string :id, null: false, primary_key: true
      t.timestamps
    end
  end
end
