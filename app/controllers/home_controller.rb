class HomeController < ApplicationController
  def index
    @url = params[:url]
    render 'index'
  end
end
