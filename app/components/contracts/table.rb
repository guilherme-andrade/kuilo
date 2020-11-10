class Contracts::Table < ReflexComponent
  def initialize(query:, contracts:)
    @contracts = contracts
    @query = query
  end
end
