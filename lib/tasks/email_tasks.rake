desc 'send forgot checkout email'
task send_forgot_checkout_email: :environment do
  	User.all_inside.each do |user|	
  	  user.check_out
	  TkYieldMailer.forgot_checkout(user).deliver
	end
end

desc 'send forgot timer email'
task send_forgot_timer_email: :environment do
  	User.all_with_tasks_running.each do |user|
	  TkYieldMailer.forgot_timer(user).deliver
	end
end
