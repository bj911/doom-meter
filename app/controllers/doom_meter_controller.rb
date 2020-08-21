class DoomMeterController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_doom_meter

  def show
    dooms_info if current_user
    @doom_level = @my_doom&.level || @doom_meter.current_doom_level
  end

  def get_dooms
    if params["doom_type"] == 'general'
      @dooms = @doom_meter.active_dooms.order(created_at: :desc).group_by{ |t| t.created_at.strftime('%B %d, %Y') }
      html = render_to_string(partial: "doom/all_dooms")
    else
      @dooms = @doom_meter.active_dooms.order(created_at: :desc)
      if current_user
        dooms_info
        html = render_to_string(partial: "doom/my_dooms")
      end
    end
    @doom_level = @my_doom&.level || @doom_meter.current_doom_level
    html_doom_meter = render_to_string(partial: "doom_meter/doom_meter")
    render json: { html: html, doom_meter: html_doom_meter }, status: :ok
  end

  def new
    @new_doom_meter = current_user.d_meters.new()
    @doom_level = @doom_meter.current_doom_level
  end

  def create
    new_doom_meter = current_user.d_meters.new(doom_meter_params)
    if new_doom_meter.save
      redirect_to doom_meter_path(new_doom_meter.friendly_id)
    else
      redirect_to new_doom_meter_path(id: @doom_meter.friendly_id)
    end
  end

  private
  def set_doom_meter
    return @doom_meter = DMeter.first if params["id"].blank?
    @doom_meter = DMeter.find(params["id"])
  rescue => error
    redirect_to root_path
  end

  def doom_meter_params
    params.require(:d_meter).permit(:name,
                                   :doom_lvl_0,
                                   :doom_lvl_1,
                                   :doom_lvl_2,
                                   :doom_lvl_3,
                                   :doom_lvl_4,
                                   :doom_lvl_5,
                                   :doom_lvl_6,
                                   :doom_lvl_7,
                                   :doom_lvl_8,
                                   :doom_lvl_9,
                                   :doom_lvl_10,
                                   :doom_lvl_11,
                                   :doom_lvl_12,
                                   :count_days
    )
  end

  def dooms_info
    @doom = current_user.dooms.new()
    @previous_dooms = @doom_meter.active_dooms.where(user_id: current_user.id).order(created_at: :desc)
    @my_doom = @previous_dooms.first if @previous_dooms.first&.created_at&.to_date == Date.today
  end
end
