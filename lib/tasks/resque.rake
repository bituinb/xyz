require 'resque/scheduler/tasks'
require 'resque/tasks'

def run_worker(queue, count = 1)
  ops = {:pgroup => true, :err => [(Rails.root + "log/#{Rails.env}_resque_err.log").to_s, "a"], 
                          :out => [(Rails.root + "log/#{Rails.env}_resque_stdout.log").to_s, "a"]}
  if queue.is_a?(Array)
    puts "Starting #{count} worker(s) with QUEUE: #{queue.join(",")}"
    env_vars = {"VVERBOSE" => "1", "QUEUES" => queue.join(",")}
  else
    puts "Starting #{count} worker(s) with QUEUE: #{queue}"
    env_vars = {"VVERBOSE" => "1", "QUEUES" => queue.to_s}
  end                         
  
  count.times {
    ## Using Kernel.spawn and Process.detach because regular system() call would
    ## cause the processes to quit when capistrano finishes
    pid = spawn(env_vars, "rake resque:work", ops)
    Process.detach(pid)
  }
end

# RAILS_ENV=development bundle exec rake resque:scheduler BACKGROUND=yes DYNAMIC_SCHEDULE=true VERBOSE=true QUIET=true

namespace :resque do
  task :setup => :environment do
    require 'resque'
    require 'resque-scheduler'
    ENV['QUEUE'] = '*'
  end

  desc "Restart running workers"
  task :restart_workers => :environment do
    Rake::Task['resque:setup'].invoke
    Rake::Task['resque:stop_workers'].invoke
    Rake::Task['resque:start_workers'].invoke
  end
  
  desc "Quit running workers"
  task :stop_workers => :environment do
    Resque.workers.each do |worker|
      if worker.to_s.match(/#{Rails.env}.new-lms-test.test_job/)
        syscmd = "kill -s QUIT #{worker.pid}"
        puts "Stopping Worker: #{worker.to_s};  Running syscmd: #{syscmd}"
        system(syscmd)
      end
    end
  end
  
  desc "Start workers"
  task :start_workers => :environment do
    run_worker("#{Rails.env}.new-lms-test.test_job", 1)
  end
end
