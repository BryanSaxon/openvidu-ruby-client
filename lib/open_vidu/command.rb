require 'open_vidu/requestor'
require 'open_vidu/responder'
require 'open_vidu/exceptions'

module OpenVidu
  # Command
  class Command
    attr_reader :object, :method, :endpoint, :params, :requestor, :responder

    def initialize(object, method, endpoint, params = {}, options: {})
      @object = object
      @method = method
      @endpoint = endpoint
      @params = params

      @requestor = options[:requestor] || OpenVidu::Requestor.new(method, endpoint, params)
      @responder = options[:responder] || OpenVidu::Responder.new
    end

    def execute
      response = requestor.execute
      raise OpenVidu::ResponseError.new(response) unless valid?(response)
      responder.execute(object, response.parsed_response)
    end

    private

    def valid?(response)
      response.success?
    end
  end
end
