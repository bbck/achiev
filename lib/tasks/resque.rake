require 'resque/tasks'

task "resque:setup" => :environment do
  Resque.before_fork = Proc.new { ActiveRecord::Base.establish_connection }
  ActiveRecord::Base.send(:subclasses).each { |klass|  klass.columns }
end
