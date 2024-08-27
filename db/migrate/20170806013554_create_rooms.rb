class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.string :home_type
      t.string :room_type
      t.integer :accommodate
      t.integer :bed_room
      t.integer :bath_room
      t.string :listing_name
      t.text :summary
      t.string :address
      t.boolean :is_kitchen
      t.boolean :is_tv
      t.boolean :is_self_parking
      t.boolean :is_valet_parking
      t.boolean :is_garage_parking
      t.boolean :is_air
      t.boolean :is_heating
      t.boolean :is_wifi
      t.boolean :is_handi_accessible
      t.boolean :is_bar
      t.integer :price
      t.boolean :active
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end