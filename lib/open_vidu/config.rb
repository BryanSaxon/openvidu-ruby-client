module OpenVidu
  # Config
  class Config < Base
    ASSIGNABLE_PARAMS = %w[].freeze
    GENERATED_PARAMS = %w[
      version openviduPublicurl openviduCdr maxRecvBandwidth minRecvBandwidth
      maxSendBandwidth minSendBandwidth openviduRecording
      openviduRecordingVersion openviduRecordingPath
      openviduRecordingPublicAccess openviduRecordingNotification
      openviduRecordingCustomLayout openviduRecordingAutostopTimeout
      openviduWebhookEndpoint openviduWebhookHeaders openviduWebhookEvents
    ].freeze
    ALL_PARAMS = (ASSIGNABLE_PARAMS + GENERATED_PARAMS).freeze

    def self.config
      OpenVidu::Command.new(:config, :get, 'config').execute
    end
  end
end

