class CreateQuickMods < ActiveRecord::Migration
  def change
    create_table :quickmods do |t|
      t.string :uid, unique: true
      t.string :name
      t.text :description
      t.string :tags, array: true
      t.string :categories, array: true

      t.timestamps
    end
  end
end
