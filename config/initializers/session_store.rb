# Be sure to restart your server when you modify this file.

Achiev::Application.config.session_store :redis_session_store, { :db => 0, :namespace => "session", :expire_in => 3600 }

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# Achiev::Application.config.session_store :active_record_store
