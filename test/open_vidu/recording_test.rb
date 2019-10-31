require 'test_helper'

class TestRecording < Minitest::Test
  def test_content_key_returns_items
    assert_equal('items', OpenVidu::Recording.content_key)
  end

  def test_get_all
    stub_request(:get, "#{ENV['OPENVIDU_URL']}/api/recordings")
    OpenVidu::Recording.all
    assert_requested(:get, "#{ENV['OPENVIDU_URL']}/api/recordings", times: 1)
  end

  def test_create
    stub_request(:post, "#{ENV['OPENVIDU_URL']}/api/recordings/start")
    OpenVidu::Recording.create(create_params)
    OpenVidu::Recording.new(create_params).create
    assert_requested(:post, "#{ENV['OPENVIDU_URL']}/api/recordings/start", times: 2, body: create_params)
  end

  def test_find
    stub_request(:get, "#{ENV['OPENVIDU_URL']}/api/recordings/test_id")
    OpenVidu::Recording.find("test_id")
    assert_requested(:get, "#{ENV['OPENVIDU_URL']}/api/recordings/test_id")
  end

  def test_stop
    stub_request(:post, "#{ENV['OPENVIDU_URL']}/api/recordings/stop/ID")
    OpenVidu::Recording.new(create_params(id: "ID")).stop
    assert_requested(:post, "#{ENV['OPENVIDU_URL']}/api/recordings/stop/ID")
  end

  def test_delete
    stub_request(:delete, "#{ENV['OPENVIDU_URL']}/api/recordings/ID")
    OpenVidu::Recording.new(create_params(id: "ID")).delete
    assert_requested(:delete, "#{ENV['OPENVIDU_URL']}/api/recordings/ID")
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
end