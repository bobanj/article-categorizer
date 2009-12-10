# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_article_categorizer_mk_session',
  :secret      => '885c78362920f697b147ba4b4e3a13285caed52f430cc87953d5d5513e00856568f342625169a55fccc510feae719a08b7fcbbd76296c5f8ed60f8a9c8f21d9c'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
