module FailedHooks
  def on_failure(e, *args)
    if e.code == 503
      Resque.enqueue self, *args
      puts "API limit reached. Will retry in 30 minutes..."
      sleep 1800
    end
  end
end
