require 'test_helper'

# OpenViduTest
class OpenViduTest < Minitest::Test
  def test_it_has_a_version_number
    refute_nil ::OpenVidu::VERSION
  end
end
