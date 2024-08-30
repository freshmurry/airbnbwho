# Be sure to restart your server when you modify this file.

Rails.application.config.session_store :cookie_store, key: '_airbnbwho_session'

# Rails.application.config.session_store :active_record_store, key: '_airbnbwho_session', secure: Rails.env.production?

Rails.application.config.session_store :cookie_store, key: '_airbnbwho_session', domain: :all, tld_length: 2