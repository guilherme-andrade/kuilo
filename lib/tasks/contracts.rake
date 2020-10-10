namespace :contracts do
  task create_next_rents: :environment do
    NextRentCreationJob.perform_later
  end

  task perform_status_checks: :environment do
    ContractsStatusCheckJob.perform_later
  end
end
