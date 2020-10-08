class Rents::InvoicesController < OrganizationController
  layout 'pdf'

  def show
    @rent = Rent.find(params[:rent_id])
  end
end
