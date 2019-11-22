require 'test_helper'

class TestRequestor < Minitest::Test
  def test_execute
    stub_request(:get, "https://127.0.0.1:4443/test").with(body: { 'test_param' => 'A test' }.to_json)
    r = OpenVidu::Requestor.new(server, :get, "test", {
        'test_param' => 'A test'
    })
    r.execute
    assert_requested(:get, "https://127.0.0.1:4443/test", times:1)
  end

  private

  def server
    OpenVidu::Server.new('https://127.0.0.1:4443?token=MY_SECRET&verify_peer=false')
  end
end
