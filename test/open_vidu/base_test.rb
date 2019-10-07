# require 'test_helper'
#
# module OpenVidu
#   # BaseTest
#   class BaseTest < Minitest::Test
#     def test_config
#       response = OpenVidu::Base.config
#
#       refute response.nil?
#       assert defined?(response.version)
#     end
#
#     def test_request_with_incorrect_url
#       OpenVidu::Base.stub :base_url, 'https://example.com' do
#         response = OpenVidu::Base.config
#
#         refute response.nil?
#         assert response.eql?(
#           'Error connecting'
#         )
#       end
#     end
#
#     def test_request_with_incorrect_username
#       OpenVidu::Base.stub :username, 'hello' do
#         response = OpenVidu::Base.config
#
#         refute response.nil?
#         assert response.eql?(
#           'Error connecting'
#         )
#       end
#     end
#
#     def test_request_with_incorrect_password
#       OpenVidu::Base.stub :password, 'password' do
#         response = OpenVidu::Base.config
#
#         refute response.nil?
#         assert response.eql?(
#           'Error connecting'
#         )
#       end
#     end
#   end
# end
