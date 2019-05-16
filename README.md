# Self-Taught Application
## Written Report
CSCI 499

Professor Raffi 

May 16, 2019 

Have you ever wanted all your notebooks, notes and tests all in one convenient place that is easily accessible? This question was the beginning of our journey for this application. As students we know first hand how difficult it is to study and prepare for tests between the many classes we have during a semester. Our solution to this issue was creating Self-Taught, a website and Android application that allows for the storing and viewing of notes with additional features. We decided to initialize our departure with a business plan and so started with the free development that anyone would be able to use. It allows users the ability to create up to 6 notebooks with 40 pages per notebook, as well as create questions and answers that can later be used to make their own custom tests that have the additional feature of adding a time limit if so chosen. This will allow the user to save their notes and study using practice exams, and with everything in one location it makes getting an ‘A’ in all future computer science courses much easier. We achieved making this website and android application by splitting the team into two sub teams. Daniel and Michelle  mainly focused their work on the android application and also the initial creation of the database design, Brandon and Shawn were tasked with creating the website and the REST-API. Using discord to keep in contact about issues, progress , and to stay on the same page. Every class session was used as a scheduled meeting to check the progress and assign tasks to be accomplished throughout the week leading up to the next class. 

At the moment there are a variety of other programs that provide similar functionality such as CourseHero or Quizlet. The reason we decided to make this specific application was because we wanted one site to do everything. This would allow for a convenient place where all students could come together to provide notes, questions, and tests for anyone to view, as long as they allow it. Of course this does not exclude the single users that only wish to store then own notes for their own purposes since the user can choose to display their data for the world or keep it for themselves. This allows students the ability to find notes in classes that they would not otherwise have access to if they were only using their own notes. There is a convenience of use for any current semester that students are in and will also provide a perpetual store of notes to re-look at for the next semester. This is important because in many cases, if not all, the higher level courses and classes are based on the previous years class and we have had personal experience in “misplacing” our notebooks after a course. Now, if a Professor would say “ You should’ve learned this in the previous semester” the users of Self-Taught can access exactly what they should’ve learned. All through either the Self-Taught website or the Android application. 

As mentioned prior there are similar products to ours, but they will not match it’s usability. CourseHero allows for the storage and sharing of notes but as we’ve seen does not have a test mechanic to additionally aid in studies. Quizlet on the other hand provides the testing capability but won’t store your notes to reference within the same site. We hope that this will be provide many students a compact form of studying that can help greatly when used. 



Brandon

**Technical Difficulties**

For the project, I worked on setting up the domain, virtual server, website, and rest-api. IONOS is used as the domain provider because I have prior experience with the service, some decent features are given without any extra cost, and the control panel is simple to use in comparison with other providers. I chose Vultr as the virtual server with Ubuntu as the OS. The website is prepared using Apache2, PhusionPassenger, and Ruby on Rails. The Ruby programming language is quite powerful for web development because of the large quantity of gems, Ruby-based libraries, out there. Bootstrap, Mongoid, Devise, and Devise Token Auth are heavily involved in the project. Bootstrap as the front-end design library. Mongoid as the mongodb database connector. Devise as the main site authentication. Lastly, Devise Token Auth, as the authentication used for the api. The code takes full advantage of features enabled by the Rails framework such as subdomain constraints, sassy css, embedded ruby files, and ruby modules. Complex html designs for the website were made simplistic with the use of these features. The web service requirement is fulfilled by using the subdomain www.api.selftaughtapp.com as the source for api calls. The subdomain redirects to the latest version of the api documentation, that explains in detail, how the api should be used. The multiple client is fulfilled by utilizing the website and the android application as the two clients. The security requirements are fulfilled by enabling HTTPS for the entire website using an SSL Certificate, Email Verification upon sign-up, Cross-Site Reference Forgery protection for the main page, forcing api calls to only be sent to the api subdomain, and password hashing.

A problem that I experience multiple times during the development of the project was attempting to learn different gem libraries and the usage with barely any decent tutorials. The guides I tried following had a trend of expecting the reader to already have prior experience beforehand, meaning the guides were not beginner-friendly. Many days were wasted to get a library to behave the right way. About a month for Mongoid to integrate with other gems. Two weeks for Devise. Two more weeks for Devise Token Auth. For now, I am getting used to the general approach with Rails applications and I’m interested in learning more about it.

Michelle Li

**Technical Difficulties**

I mainly worked on the MongoDB database, the frontend of the Android application, the second presentation PowerPoint and various design discussions with the team. I learned about MongoDB, the MongoDB query language, MongoDB clusters, and MongoDB Compass. I created the database and learned it comprehensively. I created the sequence diagram of the project and the moqups of the Android application. I also worked on the search button, homepage, about us, contact us, user settings, app settings, and the search widget and overflow menu.

Some of the technical difficulties that I faced while developing the app was being completely new to the technologies that we were going to use for the application. I was new to MongoDB. I had to go through the tutorials to learn what MongoDB is, its use cases and creation of database. I also needed to learn how to create, read, update and delete from a database. There were small syntactic issues that I had to learn. There were updates on the query syntax in newer versions, which requires quotations. There was also an issue of learning to connect to our MongoDB cluster.

I was completely new to Java so I had to learn it while using it. There were issues after updating to the newest version of Android Studio. I spent a couple of days resolving conflicts. The new version caused constraint layout issues. It prevented me from being able to load the application. After creating our own menu bar, we found out that there is an action bar that is built into the Android application. Thus, we needed to work around with what we have. There were issues with how the application display on Android Studio was different from what showed up on the physical phone. The buttons and views would overlap but that was resolved after learning about constraints. Lastly, I was having trouble after adding classes and xml files. The new activity did not show up on the screen. It kept crashing the Android application. It took a while to realize that the activity kept reloading. Then it crashed. My phone stopped responded after I typed in my password or used my biometric bypass. Thankfully, a forced reboot fixed the problem. Eventually the bug was resolved after a day for finding the bug, the need for breaks (pun intended) and making changes to the manifest file.

Since the Android design was changed near the end of the semester, we were under time constraints to change the Android application for it to do what we needed. We decided to get an overflow menu and a search bar on the top. I found out after we created the menu bar that there was an action bar. It was already built-in so it was easier to make the overflow menu there. The search widget also took a while to get running. The major issue were the activities that needed to be added for it to open activities.

Daniel and I worked on the Android application. Since we divided our work on the application, it wasn’t that bad when it came to merge conflicts. We did have some trouble with finding commands. I wasn’t able to figure out how to delete branches for a bit. The other thing that I had trouble with was being able to delete branches. The other challenge was making sure that we didn’t overwrite or lose our work.

The security features are handled because you need to login in order to see notes on the Android application. You need to log into the Android application so it’s secured by the API. We  require email verification have encrypted passwords. The website is running on HTTPS/SSL.

Daniel

**Technical Difficulties**

The initial issues that were evident was the planning. I’ve never worked on a project as large as this one was set to be. It was daunting to say the least but after some talking I was able to better understand some of the issues and tasks that we would need to finish. To start I needed to install Android Studio which was a handful of issues in itself. The first was that I had not set my laptop with windows x64 which created many issues for the programs. After solving that issue with a reinstall of windows I learned that I was unable to use the provided emulator for Android Studio and needed to modify my phone slightly to use it as a tester. Hardware aside I was then given the hefty task connecting the application to the api for logins and other calls. Nothing work. Every bit of info, tutorial, and readme did nothing but cause errors. I spent quite a few days only trying to handle to login api call.

Eventually I was able to make GET calls which was a weight off my shoulders. With the succession of the GET call I was able to slowly make my way towards a working POST call. I had then decided to separate the calls into a seperate class that can be called in order to handle the bulk of what might be needed. There were a few issues through changing the location of the successfully running code but these were minor. The major issues I had besides the connection of the API was making some of the app’s activities dynamic so as to look alright when going between phones.

The last two weeks were the most stressful. This, hopefully, being my last semester at Hunter has brought additional stress through other classes and Hunter itself. The tests and projects added extra issues with time management for me and made me lose additional time that I wish I had utilized better. This has lead to a less than ideal application view and functionality. Just as well the completion of all the api calls was not completed until the end and so many of  calls that were required for the application had to be assumed to work until the calls were made.

Shawn

**Technical Difficulties**

I was tasked with working on the website with Brandon. We were able to connect the database and actually see the data stored using the mongodb compass application. We followed the schema that was given to us by our teammates. The way we were able to handle the security requirements was using the devise gem that helped with authentication. Me and Brandon implemented this and we used several different modules that this gem has. We used the email verification to make sure that no bot is using our application. We also made sure that the password the user was hashed and salted to make sure there would be no complication and make sure that if anyone was to breach our database that they would not be able to see the persons login information. We also made sure we had https like you said everyone would have.

Some technical difficulties that I personally faced was learning ruby and the amount of time spent debugging with brandon. We would constantly stay after the class is over to try and implement simple features such as email verification but we were constantly met with bug and errors. We also faced the problem with using mongoDB since most tutorials when they show how to implement the gems or other features they would say they are compatible with the mongoid but not give a tutorial on how to install this. Another difficulty that that was faced was but minor was the creation of the models. While we were given the schema by our partners, we did not know how to implement them. On the mongoDB web page they did not go into great detail on how you would actually implement it in a rails application. A majority of the time for me was spent researching how to implement things and then working on the blank rails project and then on class days me and Brandon would stay later and try to implement them on the site. The design of the website was not too hard considering brandon had the design in his head so we knew what we wanted. Some of the implementation of things we wanted had to be cut due to the lack of time. I would not say that we were overly ambitious on stuff we thought we would be able to add but somethings had to be cut because we just at the time were not knowledgeable enough to add those things.

Even though these were some of the technical difficulties I faced, I definitely learned a lot about rest api and ruby. Ruby on rails is a powerful thing in that creates such a easy way on working on the application. There were not many conflicts when it came to me and brandons code for the website because as said before I would work on it separately and we would implement them together.  Overall this project was a fun learning process and I would happily do it again.

In conclusion we are all satisfied with our final product and plan on continuing working on this application after class is over. During the process of making this application we all ran into struggles and errors that delayed the process of finishing our project. There are other features we plan to incorporate such as messaging and creating a classroom to allow students to share notes in an easy way with other people in the same class as them.  We as a group were able to expand our knowledge on the specific areas we were tasked with working on. Daniel and Michelle in Android Studio. Shawn and Brandon in ruby and ruby on rails. This project really allowed everyone to get a real eye opener how working on large project will be like in the future when we get jobs. Communication with the team was key on making sure that we were all working on something and not overlapping when it comes to the work. Brandon as the project manager did a excellent job at allocating the workload between everyone. 

As for the security requirement for the project, we have email verification, encrypted passwords and HTTPS/SSL.

For future projects, we would like to improve on the technical aspect and the design. We would want it to be designed with a more user features like adding friends and adding a chat system to allow users to add friends. Another feature we would like to implement would be the comment section to allow users to comment. The other feature that would be nice would be to flag spam or any unwanted content that would be on the site.

## Website
* https://selftaughtapp.com

## API Documentation
* https://api.selftaughtapp.com/v1

## Slides
* https://docs.google.com/presentation/d/1D4zDyZ9ZFVdfpCI2JVu2iByrJnUzFK3VWtIxLMtaw2w/edit?usp=sharing

## Technology
* Ruby version 2.6.2

* Rails version 5.2.3

* Services: HTTP Apache2, MongoDB

## Gems
### UI
* bootstrap
	* Web UI Framework
	* [Documentation](https://www.rubydoc.info/gems/bootstrap/4.3.1)

### Website User Authentication
* devise
	* Website User Authentication
	* [Documentation](https://github.com/plataformatec/devise)

### API User Authentication
* devise-token-auth
	* API User Authentication
	* [Documentation](https://github.com/lynndylanhurley/devise_token_auth)

### Database
* mongoid
	* MongoDB Connector
	* [Documentation](https://docs.mongodb.com/mongoid/current/#ruby-mongoid-tutorial)

## Development Instructions
* Deployment Instructions:
	```
	# Webserver Deployment
	sudo git checkout branch-name-goes-here
	sudo git fetch origin
	sudo git pull origin
	sudo bundle update
	sudo bundle exec rake assets:precompile
	sudo passenger-config restart-app
	```