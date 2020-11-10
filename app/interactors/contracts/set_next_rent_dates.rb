class Contracts::SetNextRentDates < ApplicationInteractor
  include DateFormatHelper

  delegate :contract, to: :context
  delegate :rents, :invoicing_frequency, :rent_due_day, :last_rent_issued, to: :contract
  delegate :not_active?, :start_date, :end_date, to: :contract, prefix: true

  def call
    context.fail! message: 'contract_not_active' if contract_not_active?
    context.fail! message: 'next_rent_issued' if next_month_rent_issued?

    build_rent_with_dates
  end

  private

  def next_month_rent_issued?
    return unless rents.any?

    last_rent_issued.incidence_period_end > end_of_next_month
  end

  def build_rent_with_dates
    context.rent = contract.rents.build(
      incidence_period_start: incidence_period_start,
      incidence_period_end: incidence_period_end,
      issue_date: today,
      due_date: due_date
    )
  end

  def due_date
    incidence_period_start.beginning_of_month + rent_due_day.days
  end

  def incidence_period_start
    if contract_start_date < today && !last_rent_issued
      today.beginning_of_month
    else
      [contract_start_date, beginning_of_next_month].max
    end
  end

  def incidence_period_end
    [contract_end_date, incidence_period_end_of_month].min
  end

  def incidence_period_end_of_month
    (incidence_period_start + invoicing_frequency).prev_month.end_of_month
  end
end
