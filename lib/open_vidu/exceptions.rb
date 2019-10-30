module OpenVidu
  class ResponseError < StandardError
    attr_reader :response
    def initialize(response)
      @response = response
      super("OpenVidu Response error code: #{response.code}")
    end
  end
end