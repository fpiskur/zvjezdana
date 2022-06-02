class ClientsController < ApplicationController

  def index
    @clients = Client.all.paginate(page: params[:page], per_page: 50)
  end

  def show
    @client = Client.find(params[:id])
  end
end
