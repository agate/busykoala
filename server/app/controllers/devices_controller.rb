class DevicesController < ApplicationController
  def index
    render :json => Device.all
  end
end
