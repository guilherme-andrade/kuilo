class Rents::Table::RentComponent < ReflexComponent
  include Rents::Helpers::Labels
  include DateFormatHelper

  def initialize(rent:)
    @rent = rent
  end
end
