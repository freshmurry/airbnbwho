ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation

  # Index page configuration
  index do
    selectable_column
    id_column
    column :email
    column :profile_image do |user|
      if user.profile_image.present?
        image_tag user.profile_image.url(:thumb), size: '50x50'
      else
        "No profile image"
      end
    end
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end
  
  form do |f|
    f.inputs 'Admin User Details' do
      f.input :email  
      # Image uploader for profile image
      f.input :profile_image, as: :file, hint: f.object.profile_image.present? ? image_tag(url_for(f.object.profile_image), size: '100x100') : 'No profile image'
      f.input :password, required: false, hint: 'Leave blank if you do not want to change the password'
      f.input :password_confirmation, required: false, hint: 'Leave blank if you do not want to change the password'
    end
    f.actions
  end
  
  show do |user|
    attributes_table do
      row :email
      row :description
      row :profile_image do
        if user.profile_image.present?
          image_tag user.profile_image.url(:thumb), size: '50x50'
        else
          "No profile image"
        end
      end
    end
    active_admin_comments
  end  

  # Controller customization
  controller do
    # Override the update method to handle image uploads and password updates
    def update
      @admin_user = AdminUser.find(params[:id])
  
      if params[:admin_user][:password].present? || params[:admin_user][:password_confirmation].present?
        if params[:admin_user][:current_password].blank?
          flash[:error] = "Current password must be provided to update the password."
          render :edit and return
        end
  
        # Ensure that password and confirmation match
        if params[:admin_user][:password] != params[:admin_user][:password_confirmation]
          flash[:error] = "Password confirmation does not match."
          render :edit and return
        end
      end
  
      # Update only the attributes that are present
      if @admin_user.update(admin_user_params)
        flash[:notice] = "Admin user updated successfully."
        redirect_to admin_admin_user_path(@admin_user)
      else
        render :edit
      end
    end
  
    private

    def admin_user_params
      params.require(:admin_user).permit(:email, :description, :profile_image, :password, :password_confirmation)
    end
  end
end
