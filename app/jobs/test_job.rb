class TestJob < ApplicationJob
  queue_as :test_job

  def perform(account_id)
    # does simple update , just for demo purpose
    act = Account.find(account_id)
    act.code = "new"
    act.save!
    # Do something later
  end
end
