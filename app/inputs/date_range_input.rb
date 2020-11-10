class DateRangeInput < SimpleForm::Inputs::Base
  def input(wrapper_options)
    template.content_tag(:div, wrapper_options.merge(class: 'input-group')) do
      template.concat start_date_input
      template.concat input_connector
      template.concat end_date_input
    end
  end

  def input_connector
    template.content_tag(:span, class: 'input-group-text bg-white') do
      template.inline_svg_pack_tag 'media/icons/arrow-right.svg'
    end
  end

  def start_date_input
    @builder.text_field(
      start_date_input_name,
      class: 'form-control bg-white border-right-0 text-center',
      data: { controller: 'flatpickr' },
      value: input_options.dig(:default_start_date)
    )
  end

  def end_date_input
    @builder.text_field(
      end_date_input_name,
      class: 'form-control bg-white border-left-0 text-center',
      data: { controller: 'flatpickr' },
      value: input_options.dig(:default_end_date)
    )
  end

  def start_date_input_name
    if attribute_name == :date
      [:start, attribute_name].join('_')
    else
      [attribute_name, :start_date].join('_')
    end
  end

  def end_date_input_name
    if attribute_name == :date
      [:end, attribute_name].join('_')
    else
      [attribute_name, :end_date].join('_')
    end
  end
end
