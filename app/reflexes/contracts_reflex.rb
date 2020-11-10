# frozen_string_literal: true

class ContractsReflex < ApplicationReflex
  def generate_next_rent
    contract = Contract.find(element.dataset.id)
    result = contract.create_next_rent
    if result.success?
      toast success: I18n.t('alerts.next_rent_created_successfully')
    else
      toast error: I18n.t('alerts.could_not_create_next_rent')
    end
  end
end
