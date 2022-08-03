class ClientsController < ApplicationController

  before_action :logged_in_user

  def index

    if params[:query].present?
      @clients = Client.where("last_name LIKE ?", "%#{params[:query].upcase}%").paginate(page: params[:page], per_page: 50)
    else
      @clients = Client.all.paginate(page: params[:page], per_page: 50)
    end

    @client = Client.new
  end

  def show
    @client = Client.find(params[:id])
    @treatment = @client.treatments.build
    @treatments = @client.treatments.all
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      flash[:success] = "Novi korisnik je dodan!"
      redirect_to client_path(@client)
    else
      if @client.errors.any?
        flash[:danger] = "Greška prilikom dodavanja novog klijenta! - #{@client.errors.full_messages.to_sentence}"
      else
        flash[:danger] = "Greška prilikom dodavanja novog klijenta!"
      end
      # render 'index', status: :unprocessable_entity
      redirect_to root_url, status: :unprocessable_entity
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
      if @client.errors.any?
        flash.now[:danger] = "Greška prilikom uređivanja klijenta! - #{@client.errors.full_messages.to_sentence}"
      else
        flash.now[:danger] = "Greška prilikom uređivanja klijenta!"
      end
      render 'edit', status: :unprocessable_entity
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
