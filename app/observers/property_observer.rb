class PropertyObserver < ApplicationObserver
  def after_commit(record)
    super

    on_status_change if record.saved_change_to_status?
  end

  private

  def on_change_to_confirmed
    property.update(status: 'unavailable')
  end

  def on_change_to_activated
    property.update(
      current_contract_start_date: record.start_date,
      current_contract_end_date: record.end_date
    )
  end

  def on_change_to_in_notice
    property.update(status: 'available_soon')
  end

  def on_change_to_terminated
    property.update(status: 'available')
  end

  def on_change_to_cancelled
    property.update(status: 'available') unless property.current_contract
  end
end
