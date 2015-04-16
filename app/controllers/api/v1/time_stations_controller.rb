class Api::V1::TimeStationsController < Api::ApiV1Controller

  def create
    if current_user
      account = current_user.account
      @user = account.user.find_by(user_params)
      if @user
        @last_time_station = TimeStation.where(user: @user).last
        @in_time = nil
        @out_time = nil
        @total_time = nil
        if @last_time_station.nil? or !@last_time_station.parent_id.nil?
          on_time = TimeStation.create(user_id: @user.id)
          @in_time = on_time.created_at
        elsif @last_time_station.parent_id.nil? 
          on_time = TimeStation.create(user_id: @user.id, parent_id: @last_time_station.id, total_time: Time.zone.now - @last_time_station.created_at )
          @in_time = @last_time_station.created_at
          @out_time = on_time.created_at
          @total_time =  on_time.total_time
        end
      else
        render json: { success: false, error: "Email or password is invalid" }, status: 401
      end
    else
      render json: { success: false, error: "The use account is invalid" }, status: 404
    end
  end
  
  private

  def user_params
    params.permit(:qr_code, :pin_code)
  end

end
