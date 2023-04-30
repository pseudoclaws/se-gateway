# frozen_string_literal: true

API_HOST = ENV.fetch('API_HOST', 'https://www.saltedge.com')
SALT_EDGE_APP_ID = Rails.application.credentials.dig(:salt_edge, :app_id)
SALT_EDGE_SECRET = Rails.application.credentials.dig(:salt_edge, :secret)
APP_HOST = ENV.fetch('APP_HOST', "https://se.pseudoclaws.space")
CALLBACK_AUTH_USERNAME = Rails.env.test? ? 'test' : Rails.application.credentials.dig(:salt_edge, :callback_username)
CALLBACK_AUTH_PASSWORD = Rails.env.test? ? 'test' : Rails.application.credentials.dig(:salt_edge, :callback_password)
