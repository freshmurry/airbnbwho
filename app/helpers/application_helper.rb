require 'net/http'

module ApplicationHelper
  def image(user)
    if user.email.present?
      gravatar_id = Digest::MD5.hexdigest(user.email).downcase
      gravatar_url = "https://www.gravatar.com/avatar/#{gravatar_id}.jpg?d=404&s=150"

      if gravatar_exists?(gravatar_url)
        gravatar_url
      elsif user.image.present?
        user.image.url
      else
        'guest.png'
      end
    else
      'guest.png'
    end
  end

  private

  def gravatar_exists?(gravatar_url)
    response = Net::HTTP.get_response(URI.parse(gravatar_url))
    response.code == "200"
  rescue StandardError => e
    Rails.logger.error "Gravatar check failed: #{e.message}"
    false
  end
  
  def stripe_express_path
  # ----- TEST -----
  # "https://connect.stripe.com/express/oauth/authorize?redirect_uri=https://connect.stripe.com/connect/default/oauth/test&client_id=ca_HmZdg9VWvpwEchu1nuuzlCBFWTzegwfV&state={STATE_VALUE}"
  # "https://connect.stripe.com/express/oauth/authorize?redirect_uri=http://localhost:3000/auth/stripe_connect/callback&client_id=ca_Bz12s2Z5ijkGknATCnWx9EmDZIvGMf0e&state={STATE_VALUE}"

  # ---- LIVE ----
  "https://connect.stripe.com/express/oauth/authorize?redirect_uri=https://abnbwho.herokuapp.com/auth/stripe_connect/callback&client_id={CONNECTED_STRIPE_ACCOUNT_ID}&state={STATE_VALUE}"
  end
end