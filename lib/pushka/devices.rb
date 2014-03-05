# encoding: UTF-8
module Pushka
	module Devices

		class <<self; end

		def self.platform_known?(platform)
			platform_list = []
			platform_list.push 'Android' if Pushka.configuration.gcm
			platform_list.push 'iOS' if Pushka.configuration.apn
			platform_list.push 'WindowsPhone' if Pushka.configuration.winpush

			platform_list.include? paltform.to_s
		end

		def self.device_model
			Pushka.configuration.device_model
		end

		def self.token_column
			Pushka.configuration.token_column.to_s
		end

		def self.platform_column
			Pushka.configuration.platform_column.to_s
		end

		def self.add_device(token, platform, options)
			if platform_known? platform
				device = device_model.where(options.merge({token_column => token, platform_column => platform})).first_or_create
				if device.nil?
					raise Pushka::DeviceNotAdded
				end
				return device
			else
				raise Pushka::UnknownPlatform
			end
		end

		def self.remove_device(token)
			device = device_model.where(token_column => token).first
			unless device.nil?
				if device.destroy
					return true
				else
					raise Pushka::DeviceNotDestroyed
				end
			else
				raise Pushka::DeviceNotFound
			end
		end

		def self.find_device(options = {})
			device = device_model.where(options).first
			unless device.nil?
				return device
			else
				raise Pushka::DeviceNotFound
			end
		end

		def self.device_token(options = {})
			device = device_model.where(options).first
			unless device.nil?
				return device.send(token_column)
			else
				raise Pushka::DeviceNotFound
			end
		end

	end
end
