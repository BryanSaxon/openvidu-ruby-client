require 'test_helper'

module OpenVidu
  # RequestorTest
  class RequestorTest < Minitest::Test
    def test_with_incorrect_url
      # OpenVidu::Requestor.stub :base_url, 'https://example.com' do
      #   response = OpenVidu::Config.config
      #
      #   refute response.nil?
      #   assert response.eql?(
      #     'Error connecting'
      #   )
      # end
    end

    def test_with_incorrect_username; end

    def test_with_incorrect_password; end
  end
end
