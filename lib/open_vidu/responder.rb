module OpenVidu
  # Responder
  class Responder
    attr_reader :object, :response

    def initialize(object, response)
      @object = object
      @response = response
    end

    def execute
      klass = Object.const_get(klass_name)

      return true if record_destroyed?
      return klass.new(mapped_params(response)) if complete_record?
      return klass.find(response['id']) if record_lookup?

      response['content'].map { |hash| klass.new(mapped_params(hash)) }
    end

    private

    def klass_name
      "OpenVidu::#{object.to_s.split('_').map(&:capitalize).join('')}"
    end

    def record_destroyed?
      response.nil?
    end

    def complete_record?
      # Token response.
      (!response['id'].nil? && !response['role'].nil?) ||
        # Session response.
        !response['sessionId'].nil? ||
        # Config response.
        !response['version'].nil?
    end

    def record_lookup?
      !response['id'].nil? && !response['createdAt'].nil?
    end

    def mapped_params(hash)
      Hash[hash.map { |key, value| [key.to_sym, value] }]
    end
  end
end
