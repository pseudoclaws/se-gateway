namespace :se_gateway do
  task :'customers:recreate' => :environment do
    FailedCustomersJob.new.perform
  end
end
