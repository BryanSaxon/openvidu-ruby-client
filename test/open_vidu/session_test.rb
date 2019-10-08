require 'test_helper'

module OpenVidu
  # SessionTest
  class SessionTest < Minitest::Test
    def test_all
      response = OpenVidu::Session.all

      refute response.nil?
      assert response.is_a?(Array)
      assert response.first.is_a?(OpenVidu::Session)
    end

    def test_create
      id = SecureRandom.hex(5)
      params = create_params(customSessionId: id)
      response = OpenVidu::Session.create(params)

      refute response.nil?
      refute response&.sessionId&.nil?
      assert response.sessionId.eql?(id)

      OpenVidu::Session.find(id).delete
    end

    def test_instance_create
      id = SecureRandom.hex(5)
      params = create_params(customSessionId: id)
      response = OpenVidu::Session.new(params).create

      refute response.nil?
      refute response&.sessionId&.nil?
      assert response.sessionId.eql?(id)

      OpenVidu::Session.find(id).delete
    end

    def test_find
      id = SecureRandom.hex(5)
      OpenVidu::Session.new(create_params(customSessionId: id)).create
      response = OpenVidu::Session.find(id)

      refute response.nil?
      refute response&.sessionId&.nil?
      assert response.sessionId.eql?(id)

      OpenVidu::Session.find(id).delete
    end

    def test_delete
      id = SecureRandom.hex(5)
      OpenVidu::Session.new(create_params(customSessionId: id)).create
      response = OpenVidu::Session.find(id).delete

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
  end
end
