class ContractSubscriber < ApplicationSubscriber
  delegate :property, to: :record

  def after_commit(record)
    @record = record

    run_dates_callbacks
  end

  def after_status_change_to_confirmed(record)
    @record = record

    property.update(status: :contract_confirmed)
    property.contracts.where.not(id: record.id).update(status: :cancelled)
    Contracts::CreateNextRent.call(contract: record)
  end

  def after_status_change_to_activated(record)
    @record = record

    property.update(
      status: :occupied,
      current_contract_start_date: record.start_date,
      current_contract_end_date: record.end_date
    )
  end

  def after_status_change_to_in_notice(record)
    @record = record

    property.update(status: :available_soon)
  end

  def after_status_change_to_terminated(record)
    @record = record

    property.update(status: :available)
  end

  def after_status_change_to_cancelled(record)
    @record = record

    property.update(status: :available) unless property.current_contract
  end

  private

  def on_start_date_change
    property.rents.for(record.start_date..record.start_date.end_of_month)
  end

  def run_dates_callbacks
    on_start_date_change if record.saved_change_to_start_date?
    on_end_date_change if record.saved_change_to_end_date?
  end
end
