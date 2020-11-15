class Rents::Table::Rent < ApplicationComponent
  include Rents::Helpers::Labels
  include DateFormatHelper

  def initialize(rent:)
    @rent = rent
  end
end
