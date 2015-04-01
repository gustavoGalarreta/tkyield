class Api::V1::TimeStationsController < Api::ApiV1Controller

	def create
		@user = User.find_by(user_params)
		@last_time_station = TimeStation.where(user: @user).last
	    @is_in = true
	    @out_time = nil
	    @in_time = nil
	    @total_time = nil
	    @success = true
	    if @user
			if @last_time_station.nil? or !@last_time_station.parent_id.nil?
				a = TimeStation.create(user_id: @user.id)
				@in_time = a.created_at
			elsif @last_time_station.parent_id.nil? 
				a = TimeStation.create(user_id: @user.id, parent_id: @last_time_station.id, total_time: Time.zone.now - @last_time_station.created_at )
				@in_time = @last_time_station.created_at
				@out_time = a.created_at
				@total_time =  a.total_time
				@is_in = false
			end
		else
	    	@success = false
	    end
	end

  private
  	def user_params
		params.permit(:qr_code, :pin_code)
	end

end
