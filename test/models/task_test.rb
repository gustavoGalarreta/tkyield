require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  test "create new task" do
  	task = Task.new(:name =>"Task 3")
  	assert task.save

  	assert task.name == "Task 3"
  end
end
