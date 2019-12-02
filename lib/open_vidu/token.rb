module OpenVidu
  # Token
  class Token < Base
    ASSIGNABLE_PARAMS = %w[session role data kurentoOptions].freeze
    GENERATED_PARAMS = %w[id token].freeze
    ALL_PARAMS = (ASSIGNABLE_PARAMS + GENERATED_PARAMS).freeze

    def create
      OpenVidu::Command.new(
        :token, :post, 'api/tokens', create_params, options: { server: server }
      ).execute
    end
  end
end
