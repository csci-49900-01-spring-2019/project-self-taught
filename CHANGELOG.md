<!---
Format:
# Changelog
[Explanation goes here]

## [version] - [YYYY]-[MM]-[DD]
### Added
- [Explanation goes here, exclude if empty]
- [Explanation goes here, exclude if empty]

### Changed
- [Explanation goes here, exclude if empty]
- [Explanation goes here, exclude if empty]

### Removed
- [Explanation goes here, exclude if empty]
- [Explanation goes here, exclude if empty]

## [version] - [YYYY]-[MM]-[DD]
[Repeat]
-->
# Changelog
Self-Taught Application Changelog

## v0.0.4 - 2019-04-05
### Added
- devise gem for Authentication
- UserController
	- recover.html.erb
	- reset_password.html.erb

### Changed
- Fixed navbars variable

## v0.0.3 - 2019-03-30
### Added
- UserController
	- user_controller.rb
	- new.html.erb
	- access.html.erb
- Basic Login and Sign Up structure

## v0.0.2 - 2019-03-30
### Added
- mobile-fu gem for Mobile Device Detection
- material_icons for google material icons
- site footer navbar
- info top navbar
- HomepageController
	- homepage_controller.rb
	- index.html.erb
	- index.mobile.erb
- user_defined.scss
	- user-defined stylesheet

### Changed
- routes.rb
	- routing follows the REST-API structure
- application_controller.rb
	- added line for mobile-fu gem implementation
	- added Navbar Enum-like module

### Removed
- default.scss
	- an unnecessary file

## v0.0.1 - 2019-03-29
### Added
- Basic Ruby on Rails Structure
- Rails 5.2.3
- Ruby 2.6.2
- Bootstrap 4.3
- Forcing SSL for Production