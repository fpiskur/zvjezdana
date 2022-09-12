class TreatmentsController < ApplicationController

  before_action :logged_in_user, :get_current_client

  def create
    @treatment = @client.treatments.build(treatment_params)
    if @treatment.save
      flash[:success] = "Novi tretman je dodan!"
      redirect_to client_path(@client)
    else
      flash[:danger] = "Nije moguće dodati novi tretman! - #{@treatment.errors.full_messages.to_sentence}"
      redirect_to client_path(@client)
    end
  end

  def edit
    @treatment = get_treatment
  end

  def update
    @treatment = get_treatment

    if @treatment.update(treatment_params)
      flash[:success] = "Izmjene su spremljene!"
      redirect_to client_url(@client)
    else
      flash.now[:danger] = "Nije moguće urediti novi tretman! - #{@treatment.errors.full_messages.to_sentence}"
      render "edit", status: :unprocessable_entity
    end
  end

  def destroy
    get_treatment.destroy
    flash[:success] = "Tretman je izbrisan!"
    redirect_to request.referrer, status: :see_other
  end

  private

    def get_treatment
      @client.treatments.find(params[:id])
    end

    def get_current_client
      @client = Client.find(params[:client_id])
    end

    def treatment_params
      params.require(:treatment).permit(:date, :description)
    end
    
end
