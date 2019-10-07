require 'test_helper'
require 'securerandom'
require 'byebug'

module OpenVidu
  # SessionTest
  class SessionTest < Minitest::Test
    def test_all
      response = OpenVidu::Session.all

      refute response.nil?
      assert defined?(response.numberOfElements)
    end

    def test_create
      id = SecureRandom.hex(5)
      params = create_params(customSessionId: id)
      response = OpenVidu::Session.new(params).create

      refute response.nil?
      refute response&.id&.nil?
      assert response.id.eql?(id)

      OpenVidu::Session.new(sessionId: id).delete
    end

    def test_find
      id = SecureRandom.hex(5)
      OpenVidu::Session.new(create_params(customSessionId: id)).create
      response = OpenVidu::Session.find(id)

      refute response.nil?
      refute response&.sessionId&.nil?
      assert response.sessionId.eql?(id)

      OpenVidu::Session.new(sessionId: id).delete
    end

    def test_delete
      id = SecureRandom.hex(5)
      OpenVidu::Session.new(create_params(customSessionId: id)).create
      response = OpenVidu::Session.new(sessionId: id).delete

      refute response.nil?
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
