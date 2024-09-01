ActiveAdmin.register Room do
  permit_params :home_type, :room_type, :accommodate, :bed_room, :bath_room, :listing_name,
                :summary, :address, :is_kitchen, :is_tv, :is_self_parking, :is_valet_parking,
                :is_garage_parking, :is_air, :is_heating, :is_wifi, :is_handi_accessible,
                :is_bar, :price, :active, :instant, photos_attributes: [:id, :image, :_destroy]

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs "Listing Details" do
      f.input :listing_name
      f.input :home_type, as: :select, collection: [["Apartment", "Apartment"], ["House", "House"], ["Bed & Breakfast", "Bed & Breakfast"]], prompt: "Select...", input_html: { class: "form-control", id: "home_type" }
      f.input :room_type, as: :select, collection: [["Entire", "Entire"], ["Private", "Private"], ["Shared", "Shared"]], prompt: "Select...", input_html: { class: "form-control", id: "room_type" }
      f.input :instant, as: :select, collection: Room.instants.map {|key, value| [key.humanize, key]}, prompt: "Select...", input_html: { class: "form-control", id: "instant" }
      f.input :accommodate, as: :select, collection: [["1", 1], ["2", 2], ["3", 3], ["4+", 4]], prompt: "Select...", input_html: { class: "form-control", id: "accommodate" }
      f.input :bed_room, as: :select, collection: [["1", 1], ["2", 2], ["3", 3], ["4+", 4]], prompt: "Select...", input_html: { class: "form-control", id: "bed_room" }
      f.input :bath_room, as: :select, collection: [["1", 1], ["2", 2], ["3", 3], ["4+", 4]], prompt: "Select...", input_html: { class: "form-control", id: "bath_rooms" }
      f.input :summary
      f.input :address
      f.input :price
    end

    f.inputs "Amenities" do
      f.input :is_kitchen
      f.input :is_tv
      f.input :is_self_parking
      f.input :is_valet_parking
      f.input :is_garage_parking
      f.input :is_air
      f.input :is_heating
      f.input :is_wifi
      f.input :is_handi_accessible
      f.input :is_bar
    end

    f.inputs 'Upload New Photos' do
      f.input :new_photos, as: :file, input_html: { multiple: true }
    end

    f.inputs 'Photos' do
      f.object.photos.each do |photo|
        f.input :photos, as: :file, hint: photo.image.present? ? image_tag(photo.image.url(:thumb)) : "No Photos Yet"
        f.input :_destroy, as: :boolean, label: 'Remove image' if f.object.persisted?
      end
    end

    f.actions
  end

  index do
    selectable_column
    id_column
    column :listing_name
    column :home_type
    column :room_type
    column :price
    column :active
    column :instant
    actions
  end

  show do
    attributes_table do
      row :listing_name
      row :home_type
      row :room_type
      row :accommodate
      row :bed_room
      row :bath_room
      row :summary
      row :address
      row :price
      row :active
      row :instant
    end
    panel "Photos" do
      table_for room.photos do
        column :image do |photo|
          image_tag photo.image.url(:thumb)
        end
      end
    end
  end
end
