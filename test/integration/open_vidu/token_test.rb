require 'test_helper'

module OpenVidu
  # TokenTest
  class TokenTest < Minitest::Test
    def setup
      @id = SecureRandom.hex(5)
      OpenVidu::Session.create(customSessionId: @id)
    end

    def teardown
      OpenVidu::Session.find(@id).delete
    end

    def test_create
      params = create_params(session: @id)
      response = OpenVidu::Token.create(params)

      refute response.nil?
      assert response.session == @id
      assert response.token.include?('wss')
      assert response.role == 'PUBLISHER'
    end

    def test_instance_create
      params = create_params(session: @id)
      response = OpenVidu::Token.new(params).create

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
  end
end
