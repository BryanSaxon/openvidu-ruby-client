require 'test_helper'

module OpenVidu
  # ConfigTest
  class ConfigTest < Minitest::Test
    def setup
      WebMock.disable!
    end

    def teardown
      WebMock.enable!
    end
    
    def test_config
      response = OpenVidu::Config.config

      refute response.nil?
      assert defined?(response.version)
    end
  end
end
