require 'resque/job_with_status'

Resque.redis = ENV["REDISTOGO_URL"]
Resque::Status.expire_in = (24 * 60 * 60) # 24hrs in seconds