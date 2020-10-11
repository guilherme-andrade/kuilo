class Contracts::Table::ContractComponent < ReflexComponent
  include Contracts::Helpers::Labels
  include DateFormatHelper

  def initialize(contract:)
    @contract = contract
  end
end
