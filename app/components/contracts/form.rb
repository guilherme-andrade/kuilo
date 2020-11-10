class Contracts::Form < ReflexComponent
  def initialize(contract:)
    @contract = contract
    @use_existing_customer = false
    @show_customer_form = !@contract.customer&.persisted?
  end

  def form_path
    @contract.persisted? ? contract_path(@contract) : property_contracts_path(@contract.property)
  end

  def submit_copy
    @contract.persisted? ? 'Salvar mudanças' : 'Adicionar Contrato'
  end

  def toggle_use_existing_customer
    @use_existing_customer = !@use_existing_customer
  end

  def before_render
    if @use_existing_customer
      @contract.customer = nil
    else
      @contract.customer_id = nil
      @contract.build_customer
      @contract.customer.build_contact
      @contract.customer.build_address
    end
  end

  private

  def contract_params
    return {} unless params.key? :contract

    params.require(:contract).permit()
  end
end
