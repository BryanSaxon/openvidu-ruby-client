require 'test_helper'

module OpenVidu
  # BaseTest
  class BaseTest < Minitest::Test
    def test_config
      response = OpenVidu::Base.config

      refute response.nil?
      assert defined?(response.version)
    end
  end
end
