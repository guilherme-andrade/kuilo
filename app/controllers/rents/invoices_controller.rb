class Rents::InvoicesController < TenantController
  layout 'pdf'

  def show
    @rent = Rent.find(params[:rent_id])
  end
end
