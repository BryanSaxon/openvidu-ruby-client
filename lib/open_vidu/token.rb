module OpenVidu
  # Token
  class Token < Base
    attr_reader :session, :role, :data, :kurento_options

    def initialize(params)
      @session = params[:session]
      @role = params[:role] || ''
      @data = params[:data] || {}
      @kurento_options = params[:kurento_options] || {}
    end

    def create
      # TODO: Raise error if nil session.
      # TODO: Raise error unless role is SUBSCRIBER, PUBLISHER, or MODERATOR.
      self.class.request(:post, 'api/tokens', body: body)
    end

    private

    def body
      {
        session: session,
        role: role,
        data: data,
        kurentoOptions: kurento_options
      }
    end
  end
end
