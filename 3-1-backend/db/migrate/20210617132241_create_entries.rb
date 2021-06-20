class CreateEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :entries do |t|
      t.references :user, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true, type: :string

      t.timestamps
    end
  end
end