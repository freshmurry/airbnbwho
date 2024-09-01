class ResetUserIdSequence < ActiveRecord::Migration[5.0]
  def up
    case ActiveRecord::Base.connection.adapter_name
    when 'PostgreSQL'
      # PostgreSQL-specific code to reset the sequence
      execute <<-SQL
        SELECT setval(pg_get_serial_sequence('users', 'id'), coalesce(max(id), 1), false)
        FROM users;
      SQL
    when 'SQLite'
      # SQLite-specific code to reset the sequence
      # SQLite sequence handling
      execute <<-SQL
        UPDATE sqlite_sequence SET seq = 1 WHERE name = 'users';
      SQL
    else
      raise "Unsupported database adapter: #{ActiveRecord::Base.connection.adapter_name}"
    end
  end

  def down
    # Define how to reverse the migration if needed
    # For resetting sequences, it's often not necessary to provide a rollback action
  end
end
