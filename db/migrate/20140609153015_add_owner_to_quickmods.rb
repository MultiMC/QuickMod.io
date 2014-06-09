class AddOwnerToQuickMods < ActiveRecord::Migration
	def change
		add_reference :quickmods, :owner, index: true
	end
end

