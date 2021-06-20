class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.references :user,  null: false, foreign_key: true
      t.references :room,  null: false, foreign_key: true, type: :string
      t.text       :body,  null: false
      t.boolean    :check, null: false, default: false

      t.timestamps
    end
  end
end
