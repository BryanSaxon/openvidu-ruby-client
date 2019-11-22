require 'test_helper'

class TestToken < Minitest::Test
  def setup
    @id = SecureRandom.hex(5)
  end

  def test_class_method_create_calls
    stub_request(:post, "https://#{server.host_and_port}/api/tokens")
    params = create_params(session: @id)
    OpenVidu::Token.new(server, params).create
    assert_requested(:post, "https://#{server.host_and_port}/api/tokens", times:1)
  end

  def test_instance_create_calls
    stub_request(:post, "https://#{server.host_and_port}/api/tokens")
    params = create_params(session: @id)
    OpenVidu::Token.new(server, params).create
    assert_requested(:post, "https://#{server.host_and_port}/api/tokens", times:1)
  end

  def create_params(params = {})
    {
        session: 'ID',
        role: 'PUBLISHER',
        data: 'metadata',
        kurentoOptions: nil
    }.merge(params)
  end

  def server
    OpenVidu::Server.new('https://127.0.0.1:4443?token=MY_SECRET&verify_peer=false')
  end
end
