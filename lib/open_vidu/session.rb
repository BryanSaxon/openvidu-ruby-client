module OpenVidu
  # Session
  class Session < Base
    attr_reader :sessionId, :createdAt, :mediaMode, :recordingMode,
                :customSessionId, :defaultOutputMode, :defaultRecordingLayout,
                :defaultCustomLayout, :connections, :recording

    ASSIGNABLE_PARAMS = %w[
      mediaMode recordingMode customSessionId defaultOutputMode
      defaultRecordingLayout defaultCustomLayout
    ].freeze
    GENERATED_PARAMS = %w[sessionId createdAt connections recording].freeze
    ALL_PARAMS = ASSIGNABLE_PARAMS.concat(GENERATED_PARAMS).freeze

    def initialize(params)
      @sessionId = params[:sessionId]
      @createdAt = params[:createdAt]
      @mediaMode = params[:mediaMode]
      @recordingMode = params[:recordingMode]
      @customSessionId = params[:customSessionId]
      @defaultOutputMode = params[:defaultOutputMode]
      @defaultRecordingLayout = params[:defaultRecordingLayout]
      @defaultCustomLayout = params[:defaultCustomLayout]
      @connections = params[:connections]
      @recording = params[:recording]
    end

    class << self
      def all
        request(:get, 'api/sessions')
      end

      def find(id)
        request(:get, "api/sessions/#{id}")
      end
    end

    def create
      self.class.request(:post, 'api/sessions', body: assigned_params)
    end

    def delete
      self.class.request(:delete, "api/sessions/#{sessionId}")
    end

    private

    def assigned_params
      params = instance_variables_hash

      params.map do |key, _|
        params.delete(key) if GENERATED_PARAMS.include?(key)
      end

      params
    end

    def instance_variables_hash
      Hash[
        instance_variables.map do |name|
          [name[1..-1], instance_variable_get(name)]
        end
      ]
    end
  end
end
