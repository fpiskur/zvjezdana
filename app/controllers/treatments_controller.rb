class TreatmentsController < ApplicationController

  before_action :logged_in_user

  def create
    client = Client.find(params[:id])
    @treatment = client.treatments.build(treatment_params)
    if @treatment.save
      flash[:success] = "Novi tretman je dodan!"
      redirect_to client_path(client)
    else
      if @treatment.errors.any?
        flash[:danger] = "Nije moguće dodati novi tretman! - #{@treatment.errors.full_messages.to_sentence}"
      else
        flash[:danger] = "Nije moguće dodati novi tretman!"
      end
      redirect_to client_path(client)
    end
  end

  def edit
    @treatment = Treatment.find(params[:id])
  end

  def update
    @treatment = Treatment.find(params[:id])

    if @treatment.update(treatment_params)
      flash[:success] = "Izmjene su spremljene!"
      redirect_to client_url(@treatment.client)
    else
      if @treatment.errors.any?
        flash.now[:danger] = "Nije moguće urediti novi tretman! - #{@treatment.errors.full_messages.to_sentence}"
      else
        flash.now[:danger] = "Nije moguće urediti novi tretman!"
      end
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    Treatment.find(params[:id]).destroy
    flash[:success] = "Tretman je izbrisan!"
    redirect_to request.referrer, status: :see_other
  end

  private

    def treatment_params
      params.require(:treatment).permit(:date, :description)
    end
end
