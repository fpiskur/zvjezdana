class TreatmentsController < ApplicationController

  def create
    puts "###### Paramseters: #{params}"
    client = Client.find(params[:id])
    @treatment = client.treatments.build(treatment_params)
    if @treatment.save
      flash[:success] = "Novi tretman je dodan!"
      redirect_to client_path(client)
    else
      flash[:danger] = "Nije moguće dodati novi tretman!"
      redirect_to client_path(client)
    end
  end

  def edit
    # @treatment = Treatment.find(params[:id])
  end

  def update
  end

  private

    def treatment_params
      params.require(:treatment).permit(:date, :description)
    end
end
