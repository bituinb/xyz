# README

Demo application using Rails 5.2.0.beta2 for rails ticket https://github.com/rails/rails/issues/31766  

PG::ConnectionBad error when executing resque jobs
  
Run the following  task to setup data:

RAILS_ENV=development bundle exec rake  db:migrate

RAILS_ENV=development bundle exec rake  db:seed

RAILS_ENV=development bundle exec rake resque:restart_workers

RAILS_ENV=development bundle exec rake test_job


To access jobs list/failures
http://localhost:3000/admin/resque_web

To access list of accounts
http://localhost:3000

