require 'test_helper'

class TestCommand < Minitest::Test
  def test_execute
    responder = Minitest::Mock.new
    responder.expect(:execute, nil, [:session, nil])

    stub_request(:get, "#{ENV['OPENVIDU_URL']}/api/sessions").to_return(body: "", status: 200)
    OpenVidu::Command.new(:session, :get, "api/sessions", options: {
        responder: responder
    }).execute

    assert_requested(:get, "#{ENV['OPENVIDU_URL']}/api/sessions", times: 1)
    responder.verify
  end

  def test_execute_raises_on_failure
    stub_request(:get, "#{ENV['OPENVIDU_URL']}/api/sessions").
      to_return(status:404)

    assert_raises(OpenVidu::ResponseError) {
      OpenVidu::Command.new(:session, :get, "api/sessions").execute
    }

    assert_requested(:get, "#{ENV['OPENVIDU_URL']}/api/sessions", times: 1)
  end
end