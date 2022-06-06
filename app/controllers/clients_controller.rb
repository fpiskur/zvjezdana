class ClientsController < ApplicationController

  def index
    @clients = Client.all.paginate(page: params[:page], per_page: 50)
    @client = Client.new
  end

  def show
    @client = Client.find(params[:id])
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      flash[:success] = "Novi korisnik je dodan!"
      redirect_to client_path(@client)
    else
      puts "Nije se sejvao klijent"
    end
  end

  def destroy
    Client.find(params[:id]).destroy
    flash[:success] = "Klijent izbrisan!"
    redirect_to root_url
  end

  private

    def client_params
      params.require(:client).permit(:first_name, :last_name, :phone_num,
                                  :comment)
    end
end
