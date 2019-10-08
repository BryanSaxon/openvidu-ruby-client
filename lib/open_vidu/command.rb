require 'open_vidu/requestor'
require 'open_vidu/responder'

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
      OpenVidu::Responder.new(object, response).execute if valid?(response)
    end

    private

    # TODO: Implement.
    def valid?(response)
      true
    end
  end
end
