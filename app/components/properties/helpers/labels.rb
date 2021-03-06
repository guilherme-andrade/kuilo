module Properties::Helpers::Labels
  STATUS_LABEL_COLORS = {
    available: 'bg-success',
    occupied: 'bg-danger',
    ooo: 'bg-muted',
    contract_confirmed: 'bg-warning',
  }.with_indifferent_access

  def label_class_for_property(property)
    label_class_for_status(property.status)
  end

  def label_class_for_status(status)
    STATUS_LABEL_COLORS[status]
  end

  def label_for_property(property)
    class_name = label_class_for_property(property)
    text = I18n.t(['properties.status_labels.', property.status].join)

    content_tag(:span, text, class: ['badge', class_name])
  end
end
