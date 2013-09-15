class DevicesController < ApplicationController
  def index
    @devices = Device.all
    respond_to do |format|
      format.html
      format.json { render :json => @devices }
    end
  end
end
