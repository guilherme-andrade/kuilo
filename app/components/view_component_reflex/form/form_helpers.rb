# frozen_string_literal: true

# rubocop:disable Metrics/ModuleLength
## FormHelpers
module ViewComponentReflex::Form::FormHelpers
  def input_group(attribute: nil, label: nil, &blk)
    content_tag(:div, class: 'mb-5') do
      template = ''
      template += label(attribute, content) if label && attribute
      template += content_tag(:div, class: 'input-group') do
        template = ''
        template += label(attribute, content) if label && attribute
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

    type_override || @record.class.columns_hash[attribute.to_s].type
  end

  def _record_name
    @record.class.to_s.underscore
  end
end
# rubocop:enable Metrics/ModuleLength
