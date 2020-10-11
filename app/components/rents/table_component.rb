class Rents::TableComponent < ReflexComponent
  def initialize(query:, rents:)
    @rents = rents
    @query = query
  end
end
