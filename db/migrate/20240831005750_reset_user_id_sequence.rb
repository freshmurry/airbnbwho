class ResetUserIdSequence < ActiveRecord::Migration[5.0]
  def up
    # Replace `users` with the name of your table if different
    execute("DELETE FROM sqlite_sequence WHERE name = 'users'")
  end

  def down
    # No need to define anything here
  end
end
