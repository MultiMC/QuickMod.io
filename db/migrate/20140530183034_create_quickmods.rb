class CreateQuickMods < ActiveRecord::Migration
  def change
    create_table :quickmods do |t|
      t.string :uid
      t.string :repo
      t.string :name
      t.string :mod_id
      t.text :description
      t.text :license
      t.string :tags
      t.string :categories

      t.timestamps
    end
    
    create_table :authors do |t|
      t.references :quickmod
      t.string :role
      t.string :author
      
      t.timestamps
    end
    
    create_table :urls do |t|
      t.references :quickmod
      t.string :type
      t.string :url
      
      t.timestamps
    end
    
    create_table :tags do |t|
      t.references :quickmod
      t.string :tag
    end
    
    create_table :categories do |t|
      t.references :quickmod
      t.string :category
    end
    
    add_index :quickmods, :uid
    add_index :quickmods, :repo
  end
end
