desc "test job"
task :test_job => :environment do
  TestJob.perform_later(Account.first.id)
end