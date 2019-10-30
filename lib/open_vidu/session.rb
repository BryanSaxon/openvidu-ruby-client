module OpenVidu
  # Session
  class Session < Base
    ASSIGNABLE_PARAMS = %w[
      mediaMode recordingMode customSessionId defaultOutputMode
      defaultRecordingLayout defaultCustomLayout
    ].freeze
    GENERATED_PARAMS = %w[sessionId createdAt connections recording].freeze
    ALL_PARAMS = (ASSIGNABLE_PARAMS + GENERATED_PARAMS).freeze

    def self.all
      OpenVidu::Command.new(
        :session, :get, 'api/sessions'
      ).execute
    end

    def self.create(params)
      new(params).create
    end

    def self.find(id)
      OpenVidu::Command.new(
        :session, :get, "api/sessions/#{id}"
      ).execute
    end

    def self.exists?(id)
      begin
        OpenVidu::Command.new(
            :session, :get, "api/sessions/#{id}"
        ).execute
        true
      rescue OpenVidu::ResponseError => e
        raise e unless e.response.code == 404
        false
      end
    end

    def create
      OpenVidu::Command.new(
        :session, :post, 'api/sessions', create_params
      ).execute
    end

    def delete
      OpenVidu::Command.new(
        :session, :delete, "api/sessions/#{sessionId}"
      ).execute
    end
  end
end
