module Contracts::Helpers::Labels
  STATUS_LABEL_COLORS = {
    in_negotiation: 'bg-highlight',
    signed: 'bg-info',
    confirmed: 'bg-primary',
    activated: 'bg-success',
    in_notice: 'bg-warning',
    terminated: 'bg-danger',
    cancelled: 'bg-muted'
  }.with_indifferent_access.freeze

  def status_label_class(status)
    STATUS_LABEL_COLORS[status]
  end

  def status_label(rent)
    class_name = status_label_class(rent.status)
    text = I18n.t(['contracts.status_labels.', rent.status].join)

    return content_tag(:span, text, class: ['badge', class_name])
  end
end
