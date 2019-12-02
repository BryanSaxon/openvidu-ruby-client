require 'test_helper'

class TestCommand < Minitest::Test
  def test_execute
    responder = Minitest::Mock.new
    responder.expect(:execute, nil, [server, :session, nil])

    stub_request(:get, "https://#{server.host_and_port}/api/sessions").to_return(body: "", status: 200)
    OpenVidu::Command.new(:session, :get, "api/sessions", options: {
        responder: responder,
        server: server
    }).execute

    assert_requested(:get, "https://#{server.host_and_port}/api/sessions", times: 1)
    responder.verify
  end

  def test_execute_raises_on_failure
    stub_request(:get, "https://#{server.host_and_port}/api/sessions").
      to_return(status:404)

    assert_raises(OpenVidu::ResponseError) {
      OpenVidu::Command.new(:session, :get, "api/sessions", { options: { server: server } }).execute
    }

    assert_requested(:get, "https://#{server.host_and_port}/api/sessions", times: 1)
  end

  private

  def server
    OpenVidu::Server.new('https://127.0.0.1:4443?token=MY_SECRET&verify_peer=false')
  end
end
