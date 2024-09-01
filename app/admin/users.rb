ActiveAdmin.register User do
  permit_params :email, :fullname, :phone_number, :address, :description, :image

  filter :image
  filter :fullname
  filter :email
  filter :last_sign_in_at # Add filter for last sign-in time
  filter :created_at
  
  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs "User Details" do
      f.input :email
      f.input :fullname
      f.input :phone_number
      f.input :address
      f.input :description
      f.input :image, as: :file, hint: image_tag(f.object.image.url(:thumb))
    end
    f.actions
  end

  show do
    attributes_table do
      row :image do
        image_tag user.image.url(:medium) if user.image.present?
      end
      row :fullname
      row :email
      row :phone_number
      row :address
      row :last_sign_in_at # Display last sign-in time
      row :created_at
      row :updated_at
    end
    active_admin_comments

  controller do
    def create
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
      super
    end

    def update
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
      super
    end

    panel "Actions" do
      link_to "List a Room", new_admin_room_path(user_id: user.id)
    end
  end
end
end
