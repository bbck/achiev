require 'resque/failure/hoptoad'

Resque.redis = ENV["REDISTOGO_URL"]

Resque::Failure::Hoptoad.configure do |config|
  config.api_key = ENV["HOPTOAD_API_KEY"]
  config.secure = true
end