module Pushka
	module Queue
		class <<self; end

			def self.push_model
				Pushka.configuration.push_model.to_s
			end

			def self.message_column
				Pushka.configuration.message_column.to_s
			end

			def self.sound_column
				Pushka.configuration.sound_column.to_s
			end	

			def self.send_at_column
				Pushka.configuration.send_at_column.to_s
			end

			def self.queued_at_column
				Pushka.configuration.queued_at_column.to_s
			end

			def self.device_embed
				Pushka.configuration.device_embed.to_s
			end

			def self.add_push(push)
				push_model.new(push.to_record)
				if push.save
					return true
				else
					raise Pushka::PushNotAdd
				end
			end

			def self.get_unsended_push
				pushs = []
				push_model.where(send_at_column => nil).odrer(queued_at_column => :asc).find_each do |record|
					push = Pushka::Push.new
					push.from_record! record
				end
				return pushs
			end

			def self.mark_push(push)
				record = push_model.where(push.to_notification).first
				record.update_attributes(send_at => Time.now)
				record.save
			end

	end
end
