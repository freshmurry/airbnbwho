ActiveAdmin.register Calendar do
  permit_params :day, :price, :status, :room_id

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs "Calendar Details" do
      f.input :room
      f.input :day, as: :datepicker
      f.input :price
      f.input :status, as: :select, collection: ["Available", "Booked"]
    end
    f.actions
  end
end
