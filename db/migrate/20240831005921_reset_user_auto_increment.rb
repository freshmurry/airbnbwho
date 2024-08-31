class ResetUserAutoIncrement < ActiveRecord::Migration[5.0]
  def up
    # Find the maximum ID
    max_id = User.maximum(:id)
    
    # Update the sqlite_sequence table
    if max_id
      execute "UPDATE sqlite_sequence SET seq = #{max_id} WHERE name = 'users';"
    end
  end

  def down
    # Optionally handle the down migration if needed
    # This can be a no-op or reset to some default value
  end
end
