module Rents::Helpers::Labels
  STATUS_LABEL_COLORS = {
    paid: 'bg-success',
    unpaid: 'bg-danger'
  }.with_indifferent_access.freeze

  def status_label_class(status)
    STATUS_LABEL_COLORS[status]
  end

  def status_label(rent)
    class_name = status_label_class(rent.status)
    text = I18n.t(['rents.status_labels.', rent.status].join)

    return content_tag(:span, text, class: ['badge', class_name])
  end
end
