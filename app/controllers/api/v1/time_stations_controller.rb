class Api::V1::TimeStationsController < ApplicationController

	def register
		user = User.find_by_qr_code(params[:qr_code])
		last_time_station = user.timestations.last
		is_in = true
		if last_time_station.nil? or !last_time_station.out_time.nil?
			TimeStaion.create(user: user, in_time: Time.zone.now)
		else
			last_time_station.out_time = Time.zone.now
			is_in = false
		end
		render :json {status: 200, user: user, is_in: is_in}

	end
end
