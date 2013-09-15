class ActionsController < ApplicationController
  def create
    if params[:items]
      params[:items].each_pair do |id, value|
        Action.append({
          :id    => id,
          :value => value.to_i
        })
      end
    elsif params[:item]
      Action.append(params[:item])
    else
    end

    if params[:relationships]
      Relationship.update(params[:relationships])
    end

    redirect_to devices_path
  end

  def pattern
    pattern = params[:pattern].to_i

    if pattern == 0
      5.times do |i|
        Action.append({
          :id    => "14:665247461d1c11e395bc73bf3a254a5f:target:#{i+1}",
          :value => 0
        })
      end
    else
      Action.append({
        :id    => "14:665247461d1c11e395bc73bf3a254a5f:target:5",
        :value => params[:pattern].to_i
      })
    end


    render :json => params.to_json, :callback => params[:callback]
  end
end
