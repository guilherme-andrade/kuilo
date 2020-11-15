class Contracts::Table::ContractComponent < ApplicationComponent
  include Contracts::Helpers::Labels
  include DateFormatHelper

  def initialize(contract:)
    @contract = contract
  end
end
