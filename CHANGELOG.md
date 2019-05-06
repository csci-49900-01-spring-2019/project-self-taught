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

## v0.1.1 - 2019-05-06
### Added
- Added user control panel sidebar

### Changed
- More Navigation Bar Re-Design

### Removed
- material-icons gem, unnecessary

## v0.1.0 - 2019-05-05
### Added
- Mini App Logo
- A few royalty-free OpenType fonts
- font awesome gem for logos of different online brands

### Changed
- Homepage Re-Design
- Navigation Bar Re-Design
- CSS Files

### Removed
- Temporary removal of website behavior

## v0.0.9 - 2019-04-15
### Added
- Sign out button

## v0.0.8 - 2019-04-11
### Added
- Implemented the devise gem

## v0.0.7 - 2019-04-08
### Changed
- Refactored the html code of the navigation bar to use more ruby code.
- user_defined.scss
	- Utilized @extend more.

## v0.0.6 - 2019-04-07
### Added
- Basic design of a notebook.

### Changed
- Refactored some html code of the site.
- Changed the names for several html pages for better readability.
- Changed the navbar structure to be more business-oriented.
- application_helper.rb
	- added some helper methods for rendering the notebook.
- user_define.scss
	- now stores color styling variables.
	- defined several more custom css classes.

### Removed
- Temporarily removed links to some web pages.

## v0.0.5 - 2019-04-05
### Added
- NotebooksController
	- user.html.erb
- UsersController
	- signup_complete.html.erb

## v0.0.4 - 2019-04-05
### Added
- devise gem for Authentication
- UsersController
	- recover.html.erb
	- reset_password.html.erb

### Changed
- Fixed navbars variable

## v0.0.3 - 2019-03-30
### Added
- UsersController
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