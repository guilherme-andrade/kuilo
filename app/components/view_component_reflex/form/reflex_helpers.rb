module ViewComponentReflex::Form::ReflexHelpers
  def component_controller(&blk)
    super(:form, class: 'fade show') { blk.call }
  end

  def update_field
    name = element.name || element.dataset.name
    value = element.value || element.dataset.value

    @record.assign_attributes(name => value)

    @record.save if element.dataset.save
  end

  def save
    if @record.save
      toast(success: t('alerts.changes_saved_successfully'))
    else
      toast(error: t('alerts.could_not_save_record'))
    end
  end

  def reflex_submit(content = 'Submit', **options)
    if @loading && options[:class]
      options[:class].concat ' loading'
    elsif @loading
      options[:class] = 'loading'
    end

    content_tag :div, class: 'mt-7' do
      [reflex_tag('click->save', :button, content, options), error_tags(@record.errors.full_messages)].join.html_safe
    end
  end

  def reflex_input(attribute, **options)
    raise 'Attribute Invalid' unless @record&.respond_to?(attribute)

    options[:class] = options[:class].to_a
    options[:class] << (@record.errors[attribute].blank? ? 'is-valid' : 'is-invalid') unless @record.send(attribute).blank?

    return _reflex_input_content(attribute, options) if options[:wrapper] == false

    wrapper(options.delete(:wrapper_options) || {}) { _reflex_input_content(attribute, options) }
  end

  def input_reflex_data_attributes(controller: nil)
    reflex_data_attributes('change->update_field').tap do |attributes|
      attributes[:controller] = [attributes[:controller], controller].join(' ') if controller
    end
  end

  # rubocop:disable Metrics/AbcSize
  def _reflex_input_content(attribute, **options)
    input_method = ViewComponentReflex::Form::INPUT_MAPPINGS[attribute_type(attribute, options)]
    nodes = []
    nodes << label(attribute, options.delete(:label), options.delete(:label_options) || {}) if options.dig(:label)
    nodes << send(input_method, attribute, options) if input_method
    nodes << hint(options.delete(:hint)) if options.dig(:hint)
    nodes << error(attribute) if @record.errors[attribute].any?
    nodes.join.html_safe
  end
  # rubocop:enable Metrics/AbcSize
end
