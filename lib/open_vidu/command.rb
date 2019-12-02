require 'open_vidu/requestor'
require 'open_vidu/responder'
require 'open_vidu/exceptions'

module OpenVidu
  # Command
  class Command
    attr_reader :object, :method, :endpoint, :params, :requestor, :responder, :server

    def initialize(object, method, endpoint, params = {}, options: {})
      @object = object
      @method = method
      @endpoint = endpoint
      @params = params

      @server = options.fetch(:server)
      @requestor = options[:requestor] || OpenVidu::Requestor.new(server, method, endpoint, params)
      @responder = options[:responder] || OpenVidu::Responder.new
    end

    def execute
      response = requestor.execute
      raise OpenVidu::ResponseError.new(response) unless valid?(response)
      responder.execute(server, object, response.parsed_response)
    end

    private

    def valid?(response)
      response.success?
    end
  end
end
