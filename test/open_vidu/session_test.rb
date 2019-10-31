require 'test_helper'

class TestSession < Minitest::Test
  def test_find
    id = 'test_id'
    stub_request(:get, "#{ENV['OPENVIDU_URL']}/api/sessions/#{id}")
    OpenVidu::Session.find(id)

    assert_requested(:get, "#{ENV['OPENVIDU_URL']}/api/sessions/#{id}", times: 1)
  end

  def test_find_raises_on_404
    id = 'test_id'
    stub_request(:get, "#{ENV['OPENVIDU_URL']}/api/sessions/#{id}").to_return(status: 404)
    assert_raises(OpenVidu::ResponseError) {
      OpenVidu::Session.find(id)
    }

    assert_requested(:get, "#{ENV['OPENVIDU_URL']}/api/sessions/#{id}", times: 1)
  end

  def test_exists
    stub_request(:get, "#{ENV['OPENVIDU_URL']}/api/sessions/test_id")
    assert_equal(true, OpenVidu::Session.exists?("test_id"))
  end

  # exists? shoudln't raise on an ResponseError as long as the code is 404
  def test_exists_ok_on_404
    stub_request(:get, "#{ENV['OPENVIDU_URL']}/api/sessions/test_id").to_return(status: 404)
    assert_equal(false, OpenVidu::Session.exists?("test_id"))
  end

  def test_create
    stub_request(:post, "#{ENV['OPENVIDU_URL']}/api/sessions")
    OpenVidu::Session.new(create_params).create
    OpenVidu::Session.create(create_params)
    assert_requested(:post, "#{ENV['OPENVIDU_URL']}/api/sessions", times: 2, body: {
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
    stub_request(:delete, "#{ENV['OPENVIDU_URL']}/api/sessions/ID")
    s = OpenVidu::Session.new(create_params).delete
    assert_requested(:delete, "#{ENV['OPENVIDU_URL']}/api/sessions/ID")
  end

  def test_get_all
    stub_request(:get, "#{ENV['OPENVIDU_URL']}/api/sessions")
    OpenVidu::Session.all
    assert_requested(:get, "#{ENV['OPENVIDU_URL']}/api/sessions", times: 1)
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
end