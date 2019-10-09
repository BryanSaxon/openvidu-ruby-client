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

    def self.all
      OpenVidu::Command.new(
        :recording, :get, 'api/recordings'
      ).execute
    end

    def self.create(params)
      new(params).create
    end

    def self.find(id)
      OpenVidu::Command.new(
        :recording, :get, "api/recordings/#{id}"
      ).execute
    end

    def delete
      OpenVidu::Command.new(
        :recording,
        :delete,
        "api/recordings/stop/#{id}"
      ).execute
    end

    alias_method :stop, :delete

    def create
      OpenVidu::Command.new(
        :recording, :post, 'api/recordings/start', create_params
      ).execute
    end

    alias_method :start, :create
  end
end
