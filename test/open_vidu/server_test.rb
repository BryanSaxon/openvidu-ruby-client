require 'test_helper'

class TestOpenViduServer < Minitest::Test
  def test_timeout
    server = OpenVidu::Server.new('https://127.0.0.1:4443?token=MY_SECRET&verify_peer=false&timeout=42')
    assert_equal 42, server.timeout
  end

  def test_default_timeout
    server = OpenVidu::Server.new('https://127.0.0.1:4443?token=MY_SECRET&verify_peer=false')
    assert_equal 10, server.timeout
  end

  private

  def server
    OpenVidu::Server.new('https://127.0.0.1:4443?token=MY_SECRET&verify_peer=false')
  end
end
