class PropertiesFinder < ApplicationFinder
  default_sort :trending
  sortable_attributes :created_at, :market_value_cents, :default_rent_cents, :code

  def search_condition(term)
    where('properties.code ilike ?', "%#{term}%")
  end

  def status_condition(status)
    where(status: status)
  end

  def typology_condition(typology)
    where(typology: typology)
  end

  def type_condition(type)
    return if type == 'Property'

    where(type: type)
  end

  def enterprise_id_condition(enterprise_id)
    where(enterprise_id: enterprise_id)
  end
end
