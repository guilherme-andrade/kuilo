# frozen_string_literal: true

# rubocop:disable Metrics/ModuleLength
## FormHelpers
module ViewComponentReflex::Form::FormHelpers
  def form(options = {}, &blk)
    default_options = { class: 'mb-4 pb-3' }
    title = options.dig(:title) ? content_tag(:h1, options.delete(:title), class: 'h3 mb-2') : ''
    subtitle = options.dig(:subtitle) ? content_tag(:p, options.delete(:subtitle), class: 'lead mb-5') : ''
    form_tag(nil, combine_options(options, default_options)) { [title, subtitle, capture(&blk)].join.html_safe }
  end

  def fieldset(options = {}, &blk)
    default_options = { class: 'mb-4 pb-3 border-bottom' }
    title = options.dig(:title) ? content_tag(:legend, options.delete(:title), class: 'h5 mb-2') : ''
    subtitle = options.dig(:subtitle) ? content_tag(:p, options.delete(:subtitle), class: 'mb-5') : ''
    field_set_tag(nil, combine_options(options, default_options)) { [title, subtitle, capture(&blk)].join.html_safe }
  end

  def input_group(attribute: nil, label: nil, &blk)
    content_tag(:div, class: 'mb-5') do
      template = ''
      template += content_tag(:div, class: 'input-group') do
        template = ''
        template += capture(&blk)
        template.html_safe
      end
      template.html_safe
    end
  end

  def wrapper(**options, &blk)
    default_options = { class: 'mb-5' }

    content_tag(:div, capture(&blk), combine_options(default_options, options))
  end

  def label(attribute, content, **options)
    default_options = { class: 'form-label' }

    content ||= t([_record_name, 'labels', attribute].join('.'))

    label_tag(attribute, content, combine_options(default_options, options))
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
    type_override || @record.class.columns_hash.with_indifferent_access[attribute]&.type || :string
  end

  def _record_name
    @record.class.to_s.underscore
  end

  def _input_name_for(attribute)
    "#{_record_name}[#{attribute}]"
  end

  def _attribute_from_input_name(name)
    name.gsub(_record_name, '')[1...-1]
  end
end
# rubocop:enable Metrics/ModuleLength
