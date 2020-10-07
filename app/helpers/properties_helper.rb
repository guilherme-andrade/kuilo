module PropertiesHelper
  def property_types_collection
    Property::TYPES.map do |type|
      [type, ['Properties', type].join('::')]
    end
  end

  def property_typology_options_for_select(query)
    options_for_select(property_typologies_collection, selected: query.typology_eq)
  end

  def property_typologies_collection
    @property_class.typologies.map { |k, v| [k, v] }
  end

  def property_typologies
    @property_class.typologies
  end

  def property_statuses
    Property.statuses
  end
end
