# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_brio_session',
  :secret      => 'db49a8319b34462663ec2db00137bf4dccc934ce60696fd528704401936e9bc3a5ed958faa5298864d1b2c3945104ae9d0873d15c8f3341b705df24c09686705'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
