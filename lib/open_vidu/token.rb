module OpenVidu
  # Token
  class Token < Base
    ASSIGNABLE_PARAMS = %w[session role data kurentoOptions].freeze
    GENERATED_PARAMS = %w[id token].freeze
    ALL_PARAMS = (ASSIGNABLE_PARAMS + GENERATED_PARAMS).freeze

    def self.create(params)
      new(params).create
    end

    def create
      OpenVidu::Command.new(
        :token, :post, 'api/tokens', create_params
      ).execute
    end
  end
end
