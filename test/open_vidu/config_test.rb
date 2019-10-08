require 'test_helper'

module OpenVidu
  # ConfigTest
  class ConfigTest < Minitest::Test
    def test_config
      response = OpenVidu::Config.config

      refute response.nil?
      assert defined?(response.version)
    end
  end
end
