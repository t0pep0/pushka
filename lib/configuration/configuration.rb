module Pushka
  
  class <<self; end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration) if block_given?
  end

  class Configuration
    attr_accessor :device_model,
      :token_column, :device_platform_column,
      :push_model, :message_column, :sound_column,
      :send_at_column, :queued_at_column,
      :device_embed, :apn_certificate_path, :gcm_api_key,
      :gcm, :apn, :winpush, :time_interval

    def initialize
      @device_model = Device
        @token_column = 'token'
        @device_platform_column = 'platform'
      @push_model = Push
        @message_column = 'message'
        @sound_column = 'sound'
        @send_at_column = 'send_at'
        @queued_at_column = 'queued_at'
        @device_embed = 'device'
      @apn_certificate_path = 'path/to/cert.pem'
      @gcm_api_key = 'Google Cloud Message API key'
      @gcm = true
      @apn = true
      @winpush = false
      @time_interval = 60 #one minute
    end
  end

end
