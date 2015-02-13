require 'test_helper'

class TimesheetTest < ActiveSupport::TestCase

	test "create new timesheet" do
		user = users(:one)
		assert user.save

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

		assert timesheet.save

		today_timesheets = user.get_timesheet_per_day Time.now

		assert today_timesheets > 0

	end

	test "get timesheet" do
		timesheets = Timesheet.all
	end

end
