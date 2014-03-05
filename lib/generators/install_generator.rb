require 'rails/generator'

module Pushka
	class InstallGenerator < Rails::Generators::Base
		desc 'Install gem "Pushka" to your Rails application'
		source_root File.expand_path("../templates/", __FILE__)

		def create_initializer_file
			copy_file "pushka_config.rb", Rails.root.join("config", "initializers", "pushka_config.rb")
			copy_file "pushka_controller.rb", Rails.root.join("script", "pushka_controller.rb")
			copy_file "pushka_daemon.rb", Rails.root.join("lib", "pushka_daemon.rb")
		end
	end
end
