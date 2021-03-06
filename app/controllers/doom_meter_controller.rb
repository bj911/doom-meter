class DoomMeterController < ApplicationController
  before_action :authenticate_user!, except: [:show, :send_invite]
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

  def destroy
    @doom_meter.destroy
    flash['notice'] = "Doom Meter #{@doom_meter.name} deleted succeffuly!"
    redirect_to root_path
  end

  def send_invite
    invite = Invite.new(email: params[:email], d_meter_id: @doom_meter.id, uid: SecureRandom.uuid)
    if invite.save
      UserMailer.send_invite(invite.uid, invite.email).deliver_now
      render json: {message: 'Invitation was sent successfully.'}, status: :ok
    else
      errors = ''
      invite.errors.full_messages.each { |error| errors += "<p><strong>#{error}</strong></p>" }
      render json: {message: errors}, status: :unprocessable_entity
    end
  end

  def apply_invite
    invite = Invite.where(uid: params[:uid]).first
    invite.update(active: true)
    redirect_to doom_meter_path(invite.d_meter)
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
                                   :count_days,
                                   :public
    )
  end

  def dooms_info
    @doom = current_user.dooms.new()
    @previous_dooms = @doom_meter.active_dooms.where(user_id: current_user.id).order(created_at: :desc)
    @my_doom = @previous_dooms.first if @previous_dooms.first&.created_at&.to_date == Date.today
  end
end
