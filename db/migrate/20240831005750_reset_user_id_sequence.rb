class ResetUserIdSequence < ActiveRecord::Migration[5.0]
  def up
    if ActiveRecord::Base.connection.adapter_name == 'PostgreSQL'
      # PostgreSQL-specific code
      execute <<-SQL
        SELECT setval(pg_get_serial_sequence('users', 'id'), coalesce(max(id), 1), false)
        FROM users;
      SQL
    elsif ActiveRecord::Base.connection.adapter_name == 'SQLite'
      # SQLite-specific code
      execute <<-SQL
        UPDATE sqlite_sequence SET seq = 1 WHERE name = 'users';
      SQL
    else
      raise "Unsupported database adapter: #{ActiveRecord::Base.connection.adapter_name}"
    end
  end

  def down
    # Optionally implement rollback logic if necessary
  end
end
