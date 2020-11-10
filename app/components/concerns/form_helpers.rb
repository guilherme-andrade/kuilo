# frozen_string_literal: true

# rubocop:disable Metrics/ModuleLength
## FormHelpers
module FormHelpers
  INPUT_MAPPINGS = {
    string: :text_input,
    association: :select,
    integer: :number_input,
    color: :color_input,
    boolean: :check_box,
    date: :date_input,
    day: :day_select,
    dropdown: :dropdown_select,
    country: :country_code_select,
    city: :city_select,
    phone_country_code: :phone_country_code_select,
    phone_number: :phone_number_input,
    phone: :phone_input,
    attachments: :file_input,
    email: :email_input
  }.with_indifferent_access.freeze

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

  def select(attribute, **options)
    default_options = { class: ['form-select'], selected: @record.send(attribute), data: input_reflex_data_attributes }
    collection = options.delete(:collection)

    option_tags = if defined?(ActiveRecord::Collection) && collection.is_a?(ActiveRecord::Collection)
                    options_from_collection_for_select collection, :name, :id, @record.send(attribute)
                  else
                    options_for_select collection, @record.send(attribute)
                  end

    select_tag(attribute, option_tags, _opts_merge(default_options, options))
  end

  def day_select(attribute, **options)
    default_options = { class: ['form-select'], data: input_reflex_data_attributes, collection: (1..28) }

    select(attribute, _opts_merge(default_options, options))
  end

  def country_code_select(attribute, **options)
    select_options = {
      include_blank: t('globals.select_a_country'),
      selected: @record.send(attribute)&.upcase
    }.merge(options.delete(:country_select_options) || {})

    default_options = { class: ['form-select'], data: input_reflex_data_attributes }

    country_select('', attribute, select_options, _opts_merge(default_options, options))
  end

  def city_select(attribute, **options)
    if @record.country_code
      default_options = { collection: _city_options }
      select(attribute, _opts_merge(default_options, options))
    else
      text_input(attribute, options)
    end
  end

  def phone_input(attribute, **options)
    input_group(attribute: attribute, label: options.dig(:label)) do
      [
        phone_country_code_select([attribute, :country_code].join('_'), options.merge(style: 'width: 33%; flex-grow: 0;')),
        phone_number_input([attribute, :number].join('_'), options.deeper_merge(style: 'width: auto;', extend_existing_arrays: true))
      ].join.html_safe
    end
  end

  def input_group(attribute: nil, label: nil, &blk)
    content_tag(:div, class: 'mb-5') do
      template = ''
      template += label(attribute, content) if label && attribute
      template += content_tag(:div, class: 'input-group') do
        template = ''
        template += label(attribute, content) if label && attribute
        template += blk.call
        template.html_safe
      end
      template.html_safe
    end
  end

  def phone_country_code_select(attribute, **options)
    default_options = {
      class: ['form-select'],
      data: input_reflex_data_attributes,
      collection: _phone_country_code_options,
      prompt: t('globals.select_one')
    }

    select(attribute, _opts_merge(default_options, options))
  end

  def text_input(attribute, **options)
    default_options = { class: ['form-control'], data: input_reflex_data_attributes }

    text_field_tag(attribute, record.send(attribute), _opts_merge(default_options, options))
  end

  def phone_number_input(attribute, **options)
    default_options = { class: ['form-control'], data: input_reflex_data_attributes }

    phone_field_tag(attribute, record.send(attribute), _opts_merge(default_options, options))
  end

  def number_input(attribute, **options)
    default_options = { class: ['form-control'], data: input_reflex_data_attributes }

    number_field_tag(attribute, record.send(attribute), _opts_merge(default_options, options))
  end

  def check_box(attribute, **options)
    default_options = { class: ['form-control'], data: input_reflex_data_attributes }
    value = options.delete(:value)
    checked = record.send(attribute) == value

    check_box_tag(attribute, record.send(attribute), checked, _opts_merge(default_options, options))
  end

  def color_input(attribute, **options)
    default_options = { class: %w[form-control form-control-color], data: input_reflex_data_attributes }

    color_field_tag(attribute, record.send(attribute), _opts_merge(default_options, options))
  end

  def date_input(attribute, **options)
    default_options = { class: ['form-control'], data: input_reflex_data_attributes(controller: 'flatpickr') }

    date_field_tag(attribute, record.send(attribute), _opts_merge(default_options, options))
  end

  def email_input(attribute, **options)
    default_options = { class: ['form-control'], data: input_reflex_data_attributes }

    email_field_tag(attribute, record.send(attribute), _opts_merge(default_options, options))
  end

  def password_input(attribute, **options)
    default_options = { class: ['form-control'], data: input_reflex_data_attributes }

    password_field_tag(attribute, record.send(attribute), _opts_merge(default_options, options))
  end

  def search_input(attribute, **options)
    default_options = { class: ['form-control'], data: input_reflex_data_attributes }

    search_field_tag(attribute, record.send(attribute), _opts_merge(default_options, options))
  end

  def url_input(attribute, **options)
    default_options = { class: ['form-control'], data: input_reflex_data_attributes }

    url_field_tag(attribute, record.send(attribute), _opts_merge(default_options, options))
  end

  def range_input(attribute, **options)
    default_options = { class: ['form-control'], data: input_reflex_data_attributes }

    range_field_tag(attribute, record.send(attribute), _opts_merge(default_options, options))
  end

  def radio_input(attribute, **options)
    default_options = { class: ['form-control'], data: input_reflex_data_attributes }

    radio_field_tag(attribute, record.send(attribute), _opts_merge(default_options, options))
  end

  def file_input(attribute, **options)
    default_options = {
      data: input_reflex_data_attributes,
      accept: 'image/png,image/gif,image/jpeg'
    }

    if @record.send(attribute).attached?
      base64 = Base64.encode64(URI.open(record.send(attribute).blob.service_url).read)
      options.merge!(value: 'data:image/png;base64,' + base64)
    end

    content_tag :div, class: 'form-control border-dashed' do
      template = []
      template << file_field_tag(attribute, _opts_merge(default_options, options))
      template << image_tag(@record.send(attribute)) if @record.send(attribute).attached?
      template.join.html_safe
    end
  end

  def month_input(attribute, **options)
    default_options = { class: ['form-control'], data: input_reflex_data_attributes }

    month_field_tag(attribute, record.send(attribute), _opts_merge(default_options, options))
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

  def wrapper(**options, &blk)
    default_options = { class: 'mb-5' }

    content_tag(:div, _opts_merge(default_options, options)) do
      blk.call
    end
  end

  def label(attribute, content, **options)
    default_options = { class: 'form-label' }

    label_tag(attribute, content, _opts_merge(default_options, options))
  end

  def hint(content)
    content_tag(:span, content, class: 'd-block small text-muted')
  end

  def error(attribute)
    errors = @record.errors[attribute]
    error_tags(errors)
  end

  def error_tags(errors)
    errors.map do |error_content|
      content_tag(:span, error_content, class: 'd-block small text-danger')
    end
  end

  def attribute_type(attribute, **options)
    type_override = options.delete(:as)

    type_override || @record.class.columns_hash[attribute.to_s].type
  end

  def input_reflex_data_attributes(controller: nil)
    reflex_data_attributes('change->update_field').tap do |attributes|
      attributes[:controller] = [attributes[:controller], controller].join(' ') if controller
    end
  end

  # rubocop:disable Metrics/AbcSize
  def _reflex_input_content(attribute, **options)
    input_method = INPUT_MAPPINGS[attribute_type(attribute, options)]
    nodes = []
    nodes << label(attribute, options.delete(:label), options.delete(:label_options) || {}) if options.dig(:label)
    nodes << send(input_method, attribute, options) if input_method
    nodes << hint(options.delete(:hint)) if options.dig(:hint)
    nodes << error(attribute) if @record.errors[attribute].any?
    nodes.join.html_safe
  end
  # rubocop:enable Metrics/AbcSize

  def _phone_country_code_options
    label_method = ->(country_code) {
      country = ISO3166::Country[country_code]
      country_name = country.translation(I18n.locale.to_s)
      "#{country_name} (+#{country.country_code})"
    }
    ISO3166::Country.translations.keys.map do |country_code|
      code = country_code.downcase
      [code, code, { label: label_method.call(country_code) }]
    end
  end

  def _record_name
    @record.class.to_s.underscore
  end

  def _city_options
    ISO3166::Country[@record.country_code].yield_self do |country|
      country.subdivisions.values.map { |city_hash| city_hash[:name] }
    end
  end

  def _opts_merge(options, opts)
    options.deeper_merge(opts, extend_existing_arrays: true)
  end
end
# rubocop:enable Metrics/ModuleLength
