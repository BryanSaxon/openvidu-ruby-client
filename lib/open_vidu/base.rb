require 'dotenv/load'
require 'httparty'
require 'json'
require 'byebug'

module OpenVidu
  # Base
  class Base
    class << self
      def request(method, endpoint, options = { query: nil, body: nil })
        response = HTTParty.send(
          method,
          "#{base_url}/#{endpoint}",
          headers: headers,
          verify: ENV['MODE'] != 'DEV',
          query: options[:query],
          body: options[:body].to_json
        )

        # TODO: Improve error handling.
        raise StandardError, 'Error connecting' unless response.success?

        formatted_response(response.parsed_response)
      rescue StandardError => e
        e.message
      end

      def config
        request(:get, 'config')
      end

      private

      def base_url
        ENV['OPENVIDU_URL']
      end

      def headers
        {
          'Authorization' => "Basic #{auth}",
          'Content-Type' => 'application/json'
        }

      end

      def auth
        Base64.strict_encode64("#{username}:#{password}")
      end

      def username
        ENV['OPENVIDU_USERNAME']
      end

      def password
        ENV['OPENVIDU_PASSWORD']
      end

      def formatted_response(response)
        # TODO: Convert response keys to snakecase.
        return OpenStruct.new(response) unless response.is_a?(Array)

        response.map do |object|
          OpenStruct.new(object)
        end
      end
    end
  end
end
