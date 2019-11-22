require 'test_helper'

module OpenVidu
  # SessionTest
  class SessionTest < Minitest::Test
    def setup
      WebMock.disable!
    end

    def teardown
      WebMock.enable!
    end

    def test_all
      id = SecureRandom.hex(5)
      params = create_params(customSessionId: id)
      OpenVidu::Session.new(server, params).create
      response = OpenVidu::Session.new(server).all

      refute response.nil?
      assert response.is_a?(Array)
      assert response.first.is_a?(OpenVidu::Session)
    end

    def test_create
      id = SecureRandom.hex(5)
      params = create_params(customSessionId: id)
      response = OpenVidu::Session.new(server, params).create

      refute response.nil?
      refute response&.sessionId&.nil?
      assert response.sessionId.eql?(id)

      OpenVidu::Session.new(server).find(id).delete
    end

    def test_instance_create
      id = SecureRandom.hex(5)
      params = create_params(customSessionId: id)
      response = OpenVidu::Session.new(server, params).create

      refute response.nil?
      refute response&.sessionId&.nil?
      assert response.sessionId.eql?(id)

      OpenVidu::Session.new(server).find(id).delete
    end

    def test_find
      id = SecureRandom.hex(5)
      OpenVidu::Session.new(server, create_params(customSessionId: id)).create
      response = OpenVidu::Session.new(server).find(id)

      refute response.nil?
      refute response&.sessionId&.nil?
      assert response.sessionId.eql?(id)

      OpenVidu::Session.new(server).find(id).delete
    end

    def test_delete
      id = SecureRandom.hex(5)
      OpenVidu::Session.new(server, create_params(customSessionId: id)).create
      response = OpenVidu::Session.new(server).find(id).delete

      assert response.eql?(true)
    end

    private

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
      Addressable::URI.parse('https://127.0.0.1:4443?token=MY_SECRET&verify_peer=false')
    end
  end
end
