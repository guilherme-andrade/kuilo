class Contracts::Table < ApplicationComponent
  def initialize(query:, contracts:)
    @contracts = contracts
    @query = query
  end
end
