class Properties::IndexComponent < ReflexComponent
  include ApplicationHelper
  include Properties::Helpers::Labels
  include ViewComponentReflex::WithFilters
  include ViewComponentReflex::Layout

  STATUS_LABEL_COLORS = {
    available: 'bg-success',
    occupied: 'bg-danger',
    contract_confirmed: 'bg-warning',
    ooo: 'bg-muted'
  }.with_indifferent_access.freeze

  def before_render
    @properties = PropertiesFinder.find(query.merge(scope: Property.includes(:enterprise, :address))).records
  end

  def properties
    @properties ||= []
  end
end
