require 'test_helper'

module OpenVidu
  # TokenTest
  class TokenTest < Minitest::Test
    def setup
      WebMock.disable!
      @id = SecureRandom.hex(5)
      OpenVidu::Session.new(server, customSessionId: @id).create
    end

    def teardown
      OpenVidu::Session.new(server).find(@id).delete
      WebMock.enable!
    end

    def test_create
      params = create_params(session: @id)
      response = OpenVidu::Token.new(server, params).create

      refute response.nil?
      assert response.session == @id
      assert response.token.include?('wss')
      assert response.role == 'PUBLISHER'
    end

    def test_instance_create
      params = create_params(session: @id)
      response = OpenVidu::Token.new(server, params).create

      refute response.nil?
      assert response.session == @id
      assert response.token.include?('wss')
      assert response.role == 'PUBLISHER'
    end

    private

    def create_params(params = {})
      {
        session: 'ID',
        role: 'PUBLISHER',
        data: 'metadata',
        kurentoOptions: nil
      }.merge(params)
    end

    def server
      Addressable::URI.parse('https://127.0.0.1:4443?token=MY_SECRET&verify_peer=false')
    end
  end
end
