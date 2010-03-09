# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_logorrhea_session',
  :secret      => 'b17e4ddf7d71384b2a988f861ef667ee15b4d1e1051c6ee2cadbb4557333cbf4b8bc17c8e923dd4bf8008163ffc3de57a091dc306fd5974534a0e6d6ccd2d92b'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
