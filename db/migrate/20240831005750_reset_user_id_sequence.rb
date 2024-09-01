class ResetUserIdSequence < ActiveRecord::Migration[5.0]
  def up
    case ActiveRecord::Base.connection.adapter_name
    when 'PostgreSQL'
      execute("SELECT setval(pg_get_serial_sequence('users', 'id'), coalesce(max(id), 1), false) FROM users;")
    when 'SQLite'
      # SQLite-specific logic, if needed
      # For SQLite, resetting sequences might not be necessary in Rails migrations
    else
      raise "Unsupported database adapter: #{ActiveRecord::Base.connection.adapter_name}"
    end
  end

  def down
    # Define how to reverse the migration if needed
  end
end
