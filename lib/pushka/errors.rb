module Pushka

	class Error < StandardError; end
	class UnknownPlatform < Error; end
	class DeviceNotAdded < Error; end
	class DeviceNotDestroyed < Error; end
	class DeviceNotFound < Error; end
	class PushNotReady < Error; end
	class PushNotAdd < Error; end

end
