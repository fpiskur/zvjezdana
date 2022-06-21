class ClientsController < ApplicationController

  def index
    @clients = Client.all.paginate(page: params[:page], per_page: 50)
    @client = Client.new
  end

  def show
    @client = Client.find(params[:id])
    @treatments = @client.treatments.all
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      flash[:success] = "Novi korisnik je dodan!"
      redirect_to client_path(@client)
    else
      flash[:danger] = "Greška prilikom dodavanja novog klijenta!"
      render 'index'
    end
  end

  def edit
    @client = Client.find(params[:id])
  end

  def update
    @client = Client.find(params[:id])

    if @client.update(client_params)
      flash[:success] = "Izmjene su spremljene!"
      redirect_to @client
    else
      render 'edit'
    end
  end

  def destroy
    Client.find(params[:id]).destroy
    flash[:success] = "Klijent je izbrisan!"
    redirect_to root_url
  end

  private

    def client_params
      params.require(:client).permit(:first_name, :last_name, :phone_num,
                                  :comment)
    end
end
