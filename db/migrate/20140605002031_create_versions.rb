class CreateVersions < ActiveRecord::Migration
  def change
    create_table :versions do |t|
      t.references :quickmod, index: true
      t.string :name
      t.string :version
      t.string :version_type
      t.string :install_type
      t.string :sha1

      t.timestamps
    end
    
    create_table :references do |t|
      t.references :version
      t.string :uid, index: true, unique: true
      t.string :version, index: true
      t.string :reference_type
    end
    
    create_table :downloadurls do |t|
      t.references :version
      t.string :url
      t.string :download_type
    end
  end
end
