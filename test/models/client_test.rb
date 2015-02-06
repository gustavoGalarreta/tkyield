require 'test_helper'

class ClientTest < ActiveSupport::TestCase

  test "create new client" do
  	client = Client.new(:name =>"Client 3")
  	assert client.save

  	assert client.name == "Task 3"
  end


end
