class CreateVersions < ActiveRecord::Migration
  def change
    create_table :versions do |t|
      t.references :quickmod, index: true
      t.string :name
      t.string :version_type
      t.string :mc_compat, array: true
      t.string :forge_compat
      t.integer :download_type, default: 0
      t.integer :install_type, default: 0
      t.string :md5
      t.string :url

      t.timestamps
    end
  end
end
