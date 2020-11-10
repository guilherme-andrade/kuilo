class Properties::Table < ReflexComponent
  def initialize(query:, properties:)
    @properties = properties
    @query = query
  end
end
