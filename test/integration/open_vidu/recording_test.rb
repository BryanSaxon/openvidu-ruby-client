require 'test_helper'

module OpenVidu
  # RecordingTest
  class RecordingTest < Minitest::Test
    def setup
      WebMock.disable!
    end

    def teardown
      WebMock.enable!
    end

    def test_all
      response = OpenVidu::Recording.all

      refute response.nil?
      assert response.is_a?(Array)
    end

    def test_create; end

    def test_instance_create; end

    def test_find; end

    def test_delete; end

    private

    def create_params(params = {})
      {
        session: 'ID',
        name: 'Test Name',
        outputMode: '',
        hasAudio: '',
        hasVideo: '',
        resolution: '',
        recordingLayout: '',
        customLayout: ''
      }.merge(params)
    end
  end
end
