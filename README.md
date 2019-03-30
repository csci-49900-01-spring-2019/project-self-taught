# Self-Taught Application
## Technology
* Ruby version 2.6.2

* Rails version 5.2.3

* UI Gems: bootstrap

* Database Gems: mongoid

* Services: HTTP Apache2, MongoDB

## Instructions
* Deployment Instructions:
	```
	#Webserver Deployment
	sudo git fetch origin
	sudo git pull origin
	sudo git checkout branch-name-goes-here
	sudo bundle install
	sudo passenger-config restart-app
	```