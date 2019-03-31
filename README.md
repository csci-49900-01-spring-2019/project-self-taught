# Self-Taught Application
## Technology
* Ruby version 2.6.2

* Rails version 5.2.3

* Services: HTTP Apache2, MongoDB

## Gems
### UI
* bootstrap
	* Web UI Framework
	* [Documentation](https://www.rubydoc.info/gems/bootstrap/4.3.1)
* material_icons
	* Easy access to Google Material Icons
	* [Documentation](https://github.com/Angelmmiguel/material_icons/blob/master/README.md)

### Mobile
* mobile-fu
	* Mobile Device Detection
	* [Documentation](https://www.rubydoc.info/gems/mobile-fu/1.4.0)

### Database
* mongoid
	* MongoDB Connector
	* [Documentation](https://docs.mongodb.com/mongoid/current/#ruby-mongoid-tutorial)

## Development Instructions
* Deployment Instructions:
	```
	# Webserver Deployment
	sudo git fetch origin
	sudo git pull origin
	sudo git checkout branch-name-goes-here
	sudo bundle install
	sudo bundle exec rake assets:precompile
	sudo passenger-config restart-app
	```
* Mobile View Testing Instructions:
	```
	# Force Mobile View for Testing
	# Edit application_controller.rb

	class ApplicationController < ActionController::Base
		# Debug: Force Mobile View
		has_mobile_fu
		before_action :force_mobile_format
	end
	```