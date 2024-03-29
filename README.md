# WeatherApp-iOS
Weather App for iOS powered by https://www.tomorrow.io weather API. 

The User enters a location, and the App will show weather information for that location. 

The App supports adding locations as favorites for easy access.

APIs have been used for Autocompletion of user search queries, Geocoding, and getting Weather Data. The API calls are made through a server built using Node.js and deployed on Google Cloud Platform's AppEngine. 

**Video Demo:** https://angadvirk.github.io/assets/video/weather-video.mp4 (Skip to 0:30).

**Course Credits:** CS571 - Web Technologies - Fall 2021.

## Setup Instructions:
1. Clone repository. 
2. Open **'weather.xcodeproj'**. 
3. In Xcode, go to File > Packages > Update to Latest Package Versions.
4. Once the packages are updated, run the app using a simulator (iPhone 11 preferred) or your connected iOS device.

## What I Learned:
* Built an iOS app using Xcode.
* SwiftUI & the fundamentals of the Model-View-ViewModel Architecture Pattern. 
* CoreLocation to ask for user's location and use it in API Calls. 
* Calling APIs with HTTP Requests using Swift's built-in HTTP API. 
* Adding Swift Package Dependencies to a project. 
* Parsing JSON in Swift.
* Integrating ViewControllers into SwiftUI Views.
