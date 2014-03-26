Pushka.configure do |config|
  
  config.apn = false
  config.gcm = false
  config.winpush = false #for future version, in this time it's useless

  config.time_interval = 60 #Time interval for working

  config.gcm_api_key = 'Google Cloud Message API key'
  config.apn_certificate_path = 'path/to/cert.rem' 

  config.device_model = Device #Model where stored devices
    config.token_column = 'token' #name of column in device model where stored token (column must have a type String)
    config.device_platform_column = 'platform' #name of column in device model where stored platform of device

  config.push_model = Push #model for push queue
    config.message_column = 'message' #name of column in push model where message text stored
    config.sound_column = 'sound' #name of column in push model where sound name stored
    config.send_at_column = 'send_at' #name of column in push model where time of sent stored (DartaTime)
    config.queued_at_column = 'queued_at' #name of column in push model where time of add to queue stored (DataTime)
    config.device_embed = 'device' #name of embed (nested) model in push model contain device
  
end
