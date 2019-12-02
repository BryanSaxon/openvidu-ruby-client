module OpenVidu
  # Session
  class Session < Base
    ASSIGNABLE_PARAMS = %w[
      mediaMode recordingMode customSessionId defaultOutputMode
      defaultRecordingLayout defaultCustomLayout
    ].freeze
    GENERATED_PARAMS = %w[sessionId createdAt connections recording].freeze
    ALL_PARAMS = (ASSIGNABLE_PARAMS + GENERATED_PARAMS).freeze

    def all
      OpenVidu::Command.new(
        :session, :get, 'api/sessions', { options: { server: server } }
      ).execute
    end

    def find(id)
      OpenVidu::Command.new(
        :session, :get, "api/sessions/#{id}", { options: { server: server } }
      ).execute
    end

    def exists?(id)
      begin
        OpenVidu::Command.new(
          :session, :get, "api/sessions/#{id}", { options: { server: server } }
        ).execute
        true
      rescue OpenVidu::ResponseError => e
        raise e unless e.response.code == 404
        false
      end
    end

    def create
      OpenVidu::Command.new(
        :session, :post, 'api/sessions', create_params, { options: { server: server } }
      ).execute
    end

    def delete
      OpenVidu::Command.new(
        :session, :delete, "api/sessions/#{customSessionId}", { options: { server: server } }
      ).execute
    end
  end
end
