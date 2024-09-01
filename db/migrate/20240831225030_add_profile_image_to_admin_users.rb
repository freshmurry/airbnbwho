class AddProfileImageToAdminUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :admin_users, :profile_image
  end
end
