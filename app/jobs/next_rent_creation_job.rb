class NextRentCreationJob < ApplicationJob
  queue_as :contracts

  def perform
    Organization.find_each do |org|
      next if day_of_the_month != org.default_rent_issuing_day

      MultiTenant.with(org) do
        Contract.active.each do |c|
          Contracts::CreateNextRent.call(contract: c)
        end
      end
    end
  end

  def day_of_the_month
    Time.zone.today.day
  end
end
