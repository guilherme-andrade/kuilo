class Rents::Table::Rent < ReflexComponent
  include Rents::Helpers::Labels
  include DateFormatHelper

  def initialize(rent:)
    @rent = rent
  end
end
