# frozen_string_literal: true

class ContractsController < PrivateController
  before_action :find_contract, except: %i[index new create]

  def index
    @query = Contract.ransack(params[:q])
    @contracts = @query.result.page(params[:page])
  end

  def show; end

  def edit; end

  def update
    if @contract.update_attributes(contract_params)
      flash[:success] = 'contract was successfully updated'
      redirect_to @contract
    else
      flash[:error] = 'Something went wrong'
      render 'edit'
    end
  end

  def destroy
    if @contract.destroy
      flash[:success] = 'contract was successfully deleted'
    else
      flash[:error] = 'Something went wrong'
    end
    redirect_to @contracts_path
  end

  private

  def find_contract
    @contract = current_organization.contracts.find(params[:id])
  end

  def contract_params
    params.require(:contract).permit(
      :start_date, :end_date, :renegotiation_period_start_date, :renegotiation_period_end_date, :property_id,
      :deposit_paid, :deposit_rent_multiplier, :rent_amount_cents, :rent_amount_currency, :rent_charges_currency, :rent_charges_amouont,
      customer_attributes: [
        :name,
        address_attributes: %i[street door floor city country zip_code],
        contact_attributes: %i[name vat_number government_id email phone_number phone_country_code]
      ]
    )
  end
end
