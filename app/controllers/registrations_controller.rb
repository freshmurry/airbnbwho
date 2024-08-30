# class RegistrationsController < Devise::RegistrationsController
#   protected
#     def update_resource(resource, params)
#       resource.update_without_password(params)
#     end
# end

class RegistrationsController < Devise::RegistrationsController
  protected

  def update_resource(resource, params)
    Rails.logger.debug "Updating resource with params: #{params.inspect}"
    resource.update_without_password(params)
  end

  def sign_up_params
    Rails.logger.debug "Sign up params: #{params.inspect}"
    params.require(:user).permit(:fullname, :email, :password, :password_confirmation)
  end

  def account_update_params
    Rails.logger.debug "Account update params: #{params.inspect}"
    params.require(:user).permit(:fullname, :email, :password, :password_confirmation, :current_password)
  end
end