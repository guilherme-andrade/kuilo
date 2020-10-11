class RentsController < OrganizationController
  before_action :find_rent, except: [:index, :new, :create]

  def index
    @query = Rent.includes(:contract, :invoice_attachment, :comments).ransack(params[:q])
    @rents = @query.result.paginate(page: params[:page], per_page: 7)
  end

  def show
  end

  def edit
  end

  def update
    if @rent.update_attributes(params[:user])
      flash[:success] = "Rent was successfully updated"
      redirect_to @rent
    else
      flash[:error] = "Something went wrong"
      render 'edit'
    end
  end

  def destroy
    if @rent.destroy
      flash[:success] = "Rent was successfully deleted"
      redirect_to rents_path
    else
      flash[:error] = "Something went wrong"
      redirect_to rents_path
    end
  end

  private

    def find_rent
      @rent = Rent.find(params[:id])
    end

end
