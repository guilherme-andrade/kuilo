class Contracts::CreateNextRent < ApplicationOrganizer
  organize Contracts::SetNextRentDates,
           Contracts::SetNextRentAmounts,
           Contracts::SaveRent
end
