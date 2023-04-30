# frozen_string_literal: true

namespace :se_gateway do
  task :'connections:refresh' => :environment do
    RefreshConnectionsJob.new.perform
  end
end
