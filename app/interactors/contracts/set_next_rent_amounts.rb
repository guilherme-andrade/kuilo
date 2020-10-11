class Contracts::SetNextRentAmounts < ApplicationInteractor
  include DateFormatHelper

  delegate :rent, :contract, :rent_amount, :charges_amount, to: :context
  delegate :incidence_period_start, :incidence_period_end, :incidence_period, to: :rent
  delegate :rent_amount, :rent_charges, :invoicing_frequency, to: :contract, prefix: true

  def call
    assign_rent_attributes
  end

  private

  def assign_rent_attributes
    context.charges_amount = 0
    context.rent_amount = 0

    each_month_between(incidence_period_start, incidence_period_end) do |m, de, dl|
      add_rent_for_month(m, de, dl)
    end

    rent.assign_attributes(amount: rent_amount, charges: charges_amount)
  end

  def add_rent_for_month(month, days_elapsed, days_left)
    return add_a_prorata_rent(month, days_left) if first_month_of_incidence?(month)
    return add_a_prorata_rent(month, days_elapsed) if last_month_of_incidence?(month)

    add_a_monthly_rent
  end

  def add_a_monthly_rent
    context.charges_amount += contract_rent_charges
    context.rent_amount += contract_rent_amount
  end

  def add_a_prorata_rent(month, days)
    context.charges_amount += prorate_amount_for(month, days, contract_rent_charges)
    context.rent_amount += prorate_amount_for(month, days, contract_rent_amount)
  end

  def prorate_amount_for(month, days, amount)
    total_days = Time.days_in_month(month)
    days / total_days * amount
  end

  def first_month_of_incidence?(month)
    month == incidence_period_start.month
  end

  def last_month_of_incidence?(month)
    month == incidence_period_end.month
  end
end
