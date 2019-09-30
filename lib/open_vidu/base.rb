require 'dotenv/load'
require 'httparty'

module OpenVidu
  # Base
  class Base
    class << self
      def config
        request(:get, 'config')
      end

      private

      def request(method, endpoint, options = { query: nil, body: nil })
        OpenStruct.new(
          HTTParty.send(
            method,
            "#{ENV['OPENVIDU_URL']}/#{endpoint}",
            headers: { Authorization: "Basic #{auth}" },
            verify: false,
            query: options[:query],
            body: options[:body]
          )&.parsed_response
        )
      end

      def auth
        Base64.strict_encode64(
          "#{ENV['OPENVIDU_USERNAME']}:#{ENV['OPENVIDU_PASSWORD']}"
        )
      end
    end
  end
end
