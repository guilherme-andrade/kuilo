class Rents::Table < ReflexComponent
  def initialize(query:, rents:)
    @rents = rents
    @query = query
  end
end
