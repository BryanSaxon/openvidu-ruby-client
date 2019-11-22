require 'test_helper'

class TestRecording < Minitest::Test
  def test_content_key_returns_items
    assert_equal('items', OpenVidu::Recording.content_key)
  end

  def test_get_all
    stub_request(:get, "https://#{server.host_and_port}/api/recordings")
    OpenVidu::Recording.new(server).all
    assert_requested(:get, "https://#{server.host_and_port}/api/recordings", times: 1)
  end

  def test_create
    stub_request(:post, "https://#{server.host_and_port}/api/recordings/start")
    OpenVidu::Recording.new(server, create_params).create
    assert_requested(:post, "https://#{server.host_and_port}/api/recordings/start", times: 1, body: create_params)
  end

  def test_find
    stub_request(:get, "https://#{server.host_and_port}/api/recordings/test_id")
    OpenVidu::Recording.new(server).find("test_id")
    assert_requested(:get, "https://#{server.host_and_port}/api/recordings/test_id")
  end

  def test_stop
    stub_request(:post, "https://#{server.host_and_port}/api/recordings/stop/ID")
    OpenVidu::Recording.new(server, create_params(id: "ID")).stop
    assert_requested(:post, "https://#{server.host_and_port}/api/recordings/stop/ID")
  end

  def test_delete
    stub_request(:delete, "https://#{server.host_and_port}/api/recordings/ID")
    OpenVidu::Recording.new(server, create_params(id: "ID")).delete
    assert_requested(:delete, "https://#{server.host_and_port}/api/recordings/ID")
  end

  def create_params(params = {})
    {
        session: 'ID',
        name: 'Test Name',
        outputMode: '',
        hasAudio: '',
        hasVideo: '',
        resolution: '',
        recordingLayout: '',
        customLayout: '',
    }.merge(params)
  end

  def server
    OpenVidu::Server.new('https://127.0.0.1:4443?token=MY_SECRET&verify_peer=false')
  end
end
