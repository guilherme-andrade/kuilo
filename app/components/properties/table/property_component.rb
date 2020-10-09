class Properties::Table::PropertyComponent < ReflexComponent
  include Properties::Helpers::Labels

  def initialize(property:)
    @property = property
  end
end
