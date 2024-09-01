ActiveAdmin.register Revenue do
  permit_params :total, :room_id

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs "Revenue Details" do
      f.input :room
      f.input :total
    end
    f.actions
  end
end
