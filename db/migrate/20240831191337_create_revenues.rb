class CreateRevenues < ActiveRecord::Migration[5.0]
  def change
    create_table :revenues do |t|
      t.integer :total
      t.references :room, foreign_key: true

      t.timestamps
    end
  end
end
