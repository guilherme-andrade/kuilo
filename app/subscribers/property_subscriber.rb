class PropertySubscriber < ApplicationSubscriber
  def after_status_change_to_confirmed(property)
    property.update(status: 'unavailable')
  end

  def after_status_change_to_activated(property)
    property.update(
      current_contract_start_date: record.start_date,
      current_contract_end_date: record.end_date
    )
  end

  def after_status_change_to_in_notice(property)
    property.update(status: 'available_soon')
  end

  def after_status_change_to_terminated(property)
    property.update(status: 'available')
  end

  def after_status_change_to_cancelled(property)
    property.update(status: 'available') unless property.current_contract
  end
end
