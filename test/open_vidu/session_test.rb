require 'test_helper'

class TestSession < Minitest::Test
  def test_find
    id = 'test_id'
    stub_request(:get, "https://#{server.host_and_port}/api/sessions/#{id}")
    OpenVidu::Session.new(server).find(id)

    assert_requested(:get, "https://#{server.host_and_port}/api/sessions/#{id}", times: 1)
  end

  def test_find_raises_on_404
    id = 'test_id'
    stub_request(:get, "https://#{server.host_and_port}/api/sessions/#{id}").to_return(status: 404)
    assert_raises(OpenVidu::ResponseError) {
      OpenVidu::Session.new(server).find(id)
    }

    assert_requested(:get, "https://#{server.host_and_port}/api/sessions/#{id}", times: 1)
  end

  def test_exists
    stub_request(:get, "https://#{server.host_and_port}/api/sessions/test_id")
    assert_equal(true, OpenVidu::Session.new(server).exists?("test_id"))
  end

  # exists? shoudln't raise on an ResponseError as long as the code is 404
  def test_exists_ok_on_404
    stub_request(:get, "https://#{server.host_and_port}/api/sessions/test_id").to_return(status: 404)
    assert_equal(false, OpenVidu::Session.new(server).exists?("test_id"))
  end

  def test_create
    stub_request(:post, "https://#{server.host_and_port}/api/sessions")
    OpenVidu::Session.new(server, create_params).create
    assert_requested(:post, "https://#{server.host_and_port}/api/sessions", times: 1, body: {
        "mediaMode":"ROUTED",
        "recordingMode":"MANUAL",
        "customSessionId":"ID",
        "defaultOutputMode":"COMPOSED",
        "defaultRecordingLayout":"BEST_FIT",
        "defaultCustomLayout":nil
    }, headers: {
        'Authorization'=>'Basic T1BFTlZJRFVBUFA6TVlfU0VDUkVU', 'Content-Type'=>'application/json'
    })
  end

  def test_delete
    stub_request(:delete, "https://#{server.host_and_port}/api/sessions/ID")
    s = OpenVidu::Session.new(server, create_params).delete
    assert_requested(:delete, "https://#{server.host_and_port}/api/sessions/ID")
  end

  def test_get_all
    stub_request(:get, "https://#{server.host_and_port}/api/sessions")
    OpenVidu::Session.new(server).all
    assert_requested(:get, "https://#{server.host_and_port}/api/sessions", times: 1)
  end

  def create_params(params = {})
    {
        mediaMode: 'ROUTED',
        recordingMode: 'MANUAL',
        customSessionId: 'ID',
        defaultOutputMode: 'COMPOSED',
        defaultRecordingLayout: 'BEST_FIT'
    }.merge(params)
  end

  def server
    OpenVidu::Server.new('https://127.0.0.1:4443?token=MY_SECRET&verify_peer=false')
  end
end
