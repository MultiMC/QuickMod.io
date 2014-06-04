class AddSlugToQuickMods < ActiveRecord::Migration
  def change
      add_column :quickmods, :slug, :string, unique: true
      add_index :quickmods, :slug, unique: true

      # Generate slugs
      QuickMod.all.each do |quickmod|
          # Force the QuickMod's slug to be regenerated.
          quickmod.force_regen_slug = true
          quickmod.save!
      end
  end
end
