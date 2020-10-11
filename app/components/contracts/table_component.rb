class Contracts::TableComponent < ReflexComponent
  def initialize(query:, contracts:)
    @contracts = contracts
    @query = query
  end
end
