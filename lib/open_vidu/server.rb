require 'addressable'
require 'forwardable'

module OpenVidu
  # Endpoint configuration
  class Server
    extend Forwardable

    InvalidURI = Class.new(StandardError)

    def_delegators :@uri, :host, :port, :scheme, :query_values, :to_s

    # `uri` should take the form of scheme://some-openvidu-host-or-ip:port?token=<your-secret-here>
    # e.g. https://1.2.3.4?token=abcdefghijklmnop
    def initialize(uri)
      @uri = Addressable::URI.parse(uri.to_s)
      raise InvalidURI if @uri.empty?
    end

    def token
      "OPENVIDUAPP:#{query_values.fetch('token')}"
    end

    def host_and_port
      "#{host}:#{port}"
    end

    def verify_peer?
      return false if query_values['verify_peer'].to_s.downcase == 'false'

      true
    end

    def ==(other)
      other.to_s == self.to_s
    end
  end
end

