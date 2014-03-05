module Pushka
	class Push

		def initialize
			@ready = false
			@sound = nil
			@msg = nil
			@message = nil
			@device = nil
			@platform = nil
			@token = nil
			@sended = false
		end

		def sound
			@sound
		end

		def sound=(sound)
			@sound = sound.to_s
		end

		def message
			@msg
		end

		def message=(msg)
			@message = msg.to_s
		end

		def device
			@device
		end

		def device=(dev)
			@device = dev
			@platform = @device.send(Pushka::Devices.platform_column)
			@token = @device.send(Pushka::Devices.token_column)
		end

		def platform
			@platform
		end

		def token
			@token
		end

		def sended?
			@sended
		end

		def save
			@ready = (@ready.present? AND @sound.present? AND @msg.present? AND @platform.present? AND @token.present?)
			@ready
		end

		def to_notification
			if @ready
				case @platform
				when 'Android'
					json = {data: {message: @msg, sound: @sound}}
				when 'iOS'
					json = {device_token: @token, alert: @msg, sound: @sound}
				#when 'WindowsPhone'
				end
			else
				raise Pushka::PushNotReady
			end
		end

		def to_record
			if @ready
				{Pushka::Queue.message_column => @msg,
				 Pushka::Queue.sound_column => @sound,
				 Pushka::Queue.queued_at_column => Time.now,
				 Pushka::Queue.device_embed.to_s => @device,
				 :id => @id
				}
			else
				raise Pushka::PushNotReady
			end
		end

		def from_record!(record)
			@id = record.id
			self.message = record.send(Pushka::Queue.message_column)
			self.sound = record.send(Pushka::Queue.sound_column)
			self.device = record.send(Pushka::Queue.device_embed)
			@sended = record.send(Pushka::Queue.send_at_column).present?
		end

	end
end

