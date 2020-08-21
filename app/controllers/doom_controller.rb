class DoomController < ApplicationController

  def create
    doom_meter = DMeter.find(params["doom_meter_id"])
    current_user.dooms.create!(doom_params.merge(d_meter_id: doom_meter.id, level: doom_meter.levels[params["doom"]['level']]))
    redirect_to doom_meter_path(doom_meter.friendly_id)
  end

  def like
    like = current_user.likes.where(doom_id: params['doom_id']).first
    response =
        if like.present?
          like.destroy
          { heart: 'fa-thumbs-o-up', unheart: 'fa-thumbs-up', count: like.doom.likes.count > 0 ? like.doom.likes.count : '' }
        else
          like = current_user.likes.create(doom_id: params['doom_id'])
          { heart: 'fa-thumbs-up', unheart: 'fa-thumbs-o-up', count: like.doom.likes.count }
        end
    render json: response
  end

  private
  def doom_params
    params.require(:doom).permit(:text)
  end
end
