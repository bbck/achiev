require 'resque/failure/hoptoad'
require 'resque/job_with_status'

Resque.redis = ENV["REDISTOGO_URL"]
Resque::Status.expire_in = (4 * 60 * 60) # 4hrs in seconds

Resque::Failure::Hoptoad.configure do |config|
  config.api_key = ENV["HOPTOAD_API_KEY"]
  config.secure = true
end