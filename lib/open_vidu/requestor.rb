require 'httparty'
require 'json'

module OpenVidu
  # Requestor
  class Requestor
    attr_reader :method, :endpoint, :params

    BASE_URL = ENV['OPENVIDU_URL']
    TOKEN = "#{ENV['OPENVIDU_USERNAME']}:#{ENV['OPENVIDU_PASSWORD']}".freeze
    VERIFY_PEER = ENV['OPENVIDU_VERIFY_PEER']

    def initialize(method, endpoint, params = {})
      @method = method
      @endpoint = endpoint
      @params = params
    end

    def execute
      HTTParty.send(method, url, options)&.parsed_response
    end

    private

    def url
      "#{BASE_URL}/#{endpoint}"
    end

    def options
      {
        headers: {
          'Authorization' => "Basic #{Base64.strict_encode64(TOKEN)}",
          'Content-Type' => 'application/json'
        },
        verify: VERIFY_PEER != 'false',
        body: params.to_json
      }
    end
  end
end
