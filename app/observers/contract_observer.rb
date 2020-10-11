class ContractObserver < ApplicationObserver
  delegate :property, to: :record

  def after_commit(record)
    super

    run_status_change_callbacks
    run_dates_callbacks
  end

  private

  def on_start_date_change
    property.rents.for(record.start_date..record.start_date.end_of_month)
  end

  def on_status_change_to_confirmed
    property.update(status: 'unavailable')
    property.contracts.where.not(id: record.id).update(status: :cancelled)
    Contracts::CreateNextRent.call(contract: record)
  end

  def on_status_change_to_activated
    property.update(
      current_contract_start_date: record.start_date,
      current_contract_end_date: record.end_date
    )
  end

  def on_status_change_to_in_notice
    property.update(status: 'available_soon')
  end

  def on_status_change_to_terminated
    property.update(status: 'available')
  end

  def on_status_change_to_cancelled
    property.update(status: 'available') unless property.current_contract
  end

  def run_dates_callbacks
    on_start_date_change if record.saved_change_to_start_date?
    on_end_date_change if record.saved_change_to_end_date?
  end
end
