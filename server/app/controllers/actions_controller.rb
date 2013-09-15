class ActionsController < ApplicationController
  def create
    Action.append(params[:action])
  end

  def pattern
    render :json => params.to_json
  end
end
