class AddLegacyPasswordToSpreeUsers < ActiveRecord::Migration
  def change
    add_column :spree_users, :legacy_password, :boolean
  end
end
