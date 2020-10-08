class Contracts::SaveRent < ApplicationInteractor
  include DateHelper

  delegate :rent, :contract, :rent_amount, :charges_amount, to: :context

  def call
    rent.organization = contract.organization unless rent.organization
    rent.save
  end
end
