module OpenVidu
  # Recording
  class Recording < Base
    ASSIGNABLE_PARAMS = %w[
      session name outputMode hasAudio hasVideo recordingLayout customLayout
      resolution
    ].freeze
    GENERATED_PARAMS = %w[
      id sessionId createdAt size duration url status
    ].freeze
    ALL_PARAMS = (ASSIGNABLE_PARAMS + GENERATED_PARAMS).freeze

    def self.content_key
      'items'
    end

    def all
      OpenVidu::Command.new(
        :recording,
        :get,
        'api/recordings',
        { options: { server: server } }
      ).execute
    end

    def find(id)
      OpenVidu::Command.new(
        :recording, :get, "api/recordings/#{id}",
        { options: { server: server } }
      ).execute
    end

    def stop
      OpenVidu::Command.new(
        :recording,
        :post,
        "api/recordings/stop/#{id}",
        { options: { server: server } }
      ).execute
    end

    def delete
      OpenVidu::Command.new(
        :recording,
        :delete,
        "api/recordings/#{id}",
        { options: { server: server } }
      ).execute
    end

    def create
      OpenVidu::Command.new(
        :recording,
        :post,
        'api/recordings/start',
        create_params,
        { options: { server: server } }
      ).execute
    end

    alias_method :start, :create
  end
end
