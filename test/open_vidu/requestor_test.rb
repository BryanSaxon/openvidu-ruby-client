require 'test_helper'

class TestRequestor < Minitest::Test
  def test_execute
    stub_request(:get, "https://localhost:4443/test")
    r = OpenVidu::Requestor.new(:get, "test", {
        test_param: "A test"
    })
    r.execute
    assert_requested(:get, "https://localhost:4443/test", times:1)
  end
end