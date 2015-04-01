json.success 			@success
if @user
	json.user 				@user.full_name
	json.team				@user.team.name
	json.is_in				@is_in
	json.total_time			@total_time
	json.in_time			@in_time
	json.out_time			@out_time
else
	json.message			"User not found"
end

