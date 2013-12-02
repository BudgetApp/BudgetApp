FAYE_ADDRESS = Rails.env.production? ? "http://localhost:9292/friends/feed/faye" : "http://localhost:9292/friends/feed/faye"
FAYE_CHANNEL = "/friends/feed/faye"