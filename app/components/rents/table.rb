class Rents::Table < ApplicationComponent
  def initialize(query:, rents:)
    @rents = rents
    @query = query
  end
end
