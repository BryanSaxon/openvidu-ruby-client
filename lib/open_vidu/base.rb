require 'open_vidu/command'

module OpenVidu
  # Base
  class Base
    ASSIGNABLE_PARAMS = %w[].freeze
    GENERATED_PARAMS = %w[].freeze
    ALL_PARAMS = (ASSIGNABLE_PARAMS + GENERATED_PARAMS).freeze

    def self.content_key
      'content'
    end

    def initialize(params = {})
      self.class::ALL_PARAMS.each do |param|
        instance_variable_set("@#{param}", params[param.to_sym])
        self.class.send(:attr_accessor, param.to_sym)
      end
    end

    def create_params
      Hash[
        self.class::ASSIGNABLE_PARAMS.map do |param|
          [param, instance_variable_get("@#{param}")]
        end
      ]
    end
  end
end
