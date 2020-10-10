require 'jobs/next_rent_creation_job'

namespace :contracts do
  task :create_next_rents do
    NextRentCreationJob.perform_later
  end

  task :perform_status_checks do
    ContractsStatusCheckJob.perform_later
  end
end
