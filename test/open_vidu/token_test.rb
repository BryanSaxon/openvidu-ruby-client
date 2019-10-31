require 'test_helper'

class TestToken < Minitest::Test
  def setup
    @id = SecureRandom.hex(5)
  end

  def test_class_method_create_calls
    stub_request(:post, "#{ENV['OPENVIDU_URL']}/api/tokens")
    params = create_params(session: @id)
    OpenVidu::Token.create(params)
    assert_requested(:post, "#{ENV['OPENVIDU_URL']}/api/tokens", times:1)
  end

  def test_instance_create_calls
    stub_request(:post, "#{ENV['OPENVIDU_URL']}/api/tokens")
    params = create_params(session: @id)
    OpenVidu::Token.new(params).create
    assert_requested(:post, "#{ENV['OPENVIDU_URL']}/api/tokens", times:1)
  end

  def create_params(params = {})
    {
        session: 'ID',
        role: 'PUBLISHER',
        data: 'metadata',
        kurentoOptions: nil
    }.merge(params)
  end
end