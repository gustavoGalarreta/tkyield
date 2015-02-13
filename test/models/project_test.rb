require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  
  test "create new project" do
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
  	
  end

end
