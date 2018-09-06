if Rails.env.development?
 ENV["REDIS_URL"] =  'redis://localhost:6379' if Rails.env.development?
end

Sidekiq.configure_server do |config|
  config.redis = {url: ENV["REDIS_URL"]}
end

Sidekiq.configure_client do |config|
  config.redis = {url: ENV["REDIS_URL"]}
end