# frozen_string_literal: true

class ContractsReflex < ApplicationReflex
  def generate_next_rent
    contract = Contract.find(element.dataset.id)
    contract.create_next_rent
  end
end
