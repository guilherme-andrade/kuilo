class Properties::IndexComponent < PageComponent
  include ApplicationHelper
  include Properties::Helpers::Labels
  include ViewComponentReflex::WithFilters

  STATUS_LABEL_COLORS = {
    available: 'bg-success',
    occupied: 'bg-danger',
    contract_confirmed: 'bg-warning',
    ooo: 'bg-muted'
  }.with_indifferent_access.freeze

  def before_render
    @properties = PropertiesFinder.find(query.merge(scope: Property.includes(:enterprise, :address), pagination: { page: params[:page], per_page: 6 })).records
  end

  def properties
    @properties ||= []
  end

  def reload_properties
    @properties.reload
  end
end
