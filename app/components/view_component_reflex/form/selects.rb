module ViewComponentReflex::Form::Selects
  def select(attribute, **options)
    default_options = { class: ['form-select'], selected: @record.send(attribute), data: input_reflex_data_attributes }
    collection = options.delete(:collection)

    option_tags = if defined?(ActiveRecord::Collection) && collection.is_a?(ActiveRecord::Collection)
                    options_from_collection_for_select collection, :name, :id, @record.send(attribute)
                  else
                    options_for_select collection, @record.send(attribute)
                  end

    select_tag(attribute, option_tags, combine_options(default_options, options))
  end

  def dropdown_select(attribute, **options)
    option_tags = dropdown_options(attribute, options)
    id = SecureRandom.hex

    content_tag(:div, class: 'dropdown') do
      content_tag(
        :div,
        record.send(attribute),
        class: ['form-select'], id: id, data: { toggle: 'dropdown' }, aria_expanded: false
      )
      content_tag(:ul, option_tags, class: 'dropdown-menu', aria_labelled_by: id)
    end
  end

  def dropdown_options(attribute, **options)
    collection = options.delete(:collection)
    value_method = options.delete(:value_method)
    label_method = options.delete(:label_method)

    collection.map do |element|
      content_tag(:li, class: 'dropdown-item') do
        item_options = { class: 'dropdown-link', data: { value: element.send(value_method), name: attribute } }
        reflex_tag('change->update_field', :a, element.send(label_method), item_options)
      end
    end
  end

end
