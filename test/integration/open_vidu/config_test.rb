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
      response = OpenVidu::Config.new('https://127.0.0.1?token=MY_SECRET&verify_peer=false').config

      refute response.nil?
      assert defined?(response.version)
    end
  end
end
