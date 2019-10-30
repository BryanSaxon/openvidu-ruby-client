require 'open_vidu/requestor'
require 'open_vidu/responder'
require 'open_vidu/exceptions'

module OpenVidu
  # Command
  class Command
    attr_reader :object, :method, :endpoint, :params

    def initialize(object, method, endpoint, params = {})
      @object = object
      @method = method
      @endpoint = endpoint
      @params = params
    end

    def execute
      response = OpenVidu::Requestor.new(method, endpoint, params).execute
      raise OpenVidu::ResponseError.new(response) unless valid?(response)
      OpenVidu::Responder.new(object, response.parsed_response).execute
    end

    private

    def valid?(response)
      response.success?
    end
  end
end
