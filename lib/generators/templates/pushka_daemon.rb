require File.dirname(__FILE__) + '/../config/boot'
require File.dirname(__FILE__) + '/../config/environment'

logger = RAILS_DEFAULT_LOGGER

@ios_pusher = Grocer.pusher(certificate: Pushka.configuration.apn_certificate_path) if Pushka.configuration.apn # Read https://github.com/grocer/grocer for more details
@android_pusher = GCM.new(Pushka.configuration.gcm_api_key) if Pushka.configuration.gcm #Read https://github.com/spacialdb/gcm for more details

loop do
	pushs = Pushka::Queue.get_unsended_push
	pushs.each do |push|
		case push.platform
		when 'Android'
			@android_pusher.send_notification(push.token, push.to_notification)
		when 'iOS'
			notify = Grocer::Notification.new(push.to_notification)
			@ios_pusher.push(notify)
		end
		Pushka::Queue.mark_push
	end
	sleep(Pushka.configuration.time_interval)
end

