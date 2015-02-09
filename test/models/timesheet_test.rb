require 'test_helper'

class TimesheetTest < ActiveSupport::TestCase
	include Devise::TestHelpers

    def login_user
    	before(:each) do
	      @request.env["devise.mapping"] = Devise.mappings[:user]
	      user = FactoryGirl.create(:user)
	      user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
	      sign_in user
    	end
 	end

	test "create new timesheet" do
		self.login_user
		user = users(:one)

		client = Client.new(:name =>"Client 1")
		assert client.save

		clientDb = Client.find(client.id)

		assert (clientDb.name == "Client 1")

		task = Task.new(:name =>"Task 3")
		assert task.save

		taskDb = Task.find(task.id)
		assert (taskDb.name == "Task 3")

		project = Project.new()
		project.client = clientDb
		project.tasks << taskDb 
		project.save
		assert project.save 

		timesheet = Timesheet.new()
		timesheet.user = user
		timesheet.project = project
		timesheet.task = task 

		timesheet.toggle_timer

		timesheet.toggle_timer

		assert timesheet.save

		timesheetsToday = Timesheet.obtaining_total_time_per_day(Time.new)
		assert timesheetsToday >= 1
	end

	test "get timesheet" do
		timesheets = Timesheet.all
		puts "reading timesheets"
		puts timesheets.count
	end

end
