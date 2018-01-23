require "redis"

redis_config = YAML.load_file(Rails.root.to_s + '/config/resque.yml')[Rails.env]
Resque.logger = Logger.new(Rails.root.join('log', "#{Rails.env}_resque.log"))
Resque.logger.level = Logger::DEBUG
Resque.redis =  redis_config


Resque::Scheduler.configure do |c|
  c.quiet = true
  c.verbose = true
  c.logfile = Rails.root.join('log', "#{Rails.env}_resque_scheduler.log")
  c.logformat = 'text'
end

Resque.before_fork = Proc.new do |job|
  ActiveRecord::Base.connection.disconnect!
end

Resque.after_fork = Proc.new do |job|
  ActiveRecord::Base.establish_connection(
        Rails.application.config.database_configuration[Rails.env]
  )
end