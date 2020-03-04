require 'httparty'
require 'json'

module OpenVidu
  # Requestor
  class Requestor
    attr_reader :server, :method, :endpoint, :params

    def initialize(server, method, endpoint, params = {})
      @server = server
      @method = method
      @endpoint = endpoint
      @params = params
    end

    def execute
      HTTParty.send(method, url, options)
    end

    private

    def url
      "#{server.scheme}://#{server.host}:#{server.port || 4443}/#{endpoint}"
    end

    def options
      {
        headers: {
          'Authorization' => "Basic #{Base64.strict_encode64(server.token)}",
          'Content-Type' => 'application/json'
        },
        verify: server.verify_peer?,
        timeout: server.timeout,
        body: params.to_json
      }
    end
  end
end
