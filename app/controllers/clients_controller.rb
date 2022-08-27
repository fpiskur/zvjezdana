class ClientsController < ApplicationController

  before_action :logged_in_user

  def index
    if params[:query].present?
      # Search first and last names or both
      @clients = Client.where("first_name || ' ' || last_name LIKE ?",
                 "%" + Client.sanitize_sql_like(params[:query].upcase) + "%")
    else
      @clients = Client.all
    end
    @clients = @clients.paginate(page: params[:page], per_page: 50)

    @client = Client.new
  end

  def show
    @client = get_client
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      flash[:success] = "Novi korisnik je dodan!"
      redirect_to client_path(@client)
    else
      flash[:danger] = "Greška prilikom dodavanja novog klijenta! - #{@client.errors.full_messages.to_sentence}"
      redirect_to root_url, status: :unprocessable_entity
    end
  end

  def edit
    @client = get_client
  end

  def update
    @client = get_client

    if @client.update(client_params)
      flash[:success] = "Izmjene su spremljene!"
      redirect_to @client
    else
      flash.now[:danger] = "Greška prilikom uređivanja klijenta! - #{@client.errors.full_messages.to_sentence}"
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    get_client.destroy
    flash[:success] = "Klijent je izbrisan!"
    redirect_to root_url
  end

  private

    def get_client
      Client.find(params[:id])
    end

    def client_params
      params.require(:client).permit(:first_name, :last_name, :phone_num,
                                  :comment)
    end
end
