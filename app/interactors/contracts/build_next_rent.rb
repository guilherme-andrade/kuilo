class Contracts::BuildNextRent < ApplicationOrganizer
  organize Contracts::SetNextRentDates,
           Contracts::SetNextRentAmounts
end
