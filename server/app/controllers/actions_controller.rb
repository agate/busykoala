class ActionsController < ApplicationController
  def create
    Action.append(params[:action])
  end
end
