class AddAdminUsersToNotebooks < ActiveRecord::Migration
  def change
    rename_column :notebooks, :user_id, :owner_id

    create_table :notebooks_users do |t|
      t.belongs_to :notebook
      t.belongs_to :user
    end
  end
end
