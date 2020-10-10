class NextRentCreationJob < ApplicationJob
  queue_as :contracts

  def perform
    Organization.find_each do |org|
      # next if day_of_the_month != org.default_rent_issuing_day
      rent_ids = []

      MultiTenant.with(org) do
        Contract.active.each do |c|
          rent_ids << Contracts::CreateNextRent.call(contract: c).rent.id
        end
      end

      next if rent_ids.empty?

      NextRentsCreatedNotification.with(rent_ids: rent_ids).deliver_later(org.admins)
    end
  end

  def day_of_the_month
    Time.zone.today.day
  end
end
