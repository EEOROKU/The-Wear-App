DOCUMENTATION

The Wear App is an app that lets users store clothes and create outfits with their stored clothes. It aims to provide something of a digital closet to users where they can plan outfits on their mobile device without having to rummage through the clothes in their closet. 

Key Features:

-	Storing Clothing Items: The app lets a user take pictures of a cloth either with their phone camera, or from their gallery. Then, it lets the user store their clothes in a closet.
-	Putting Together an Outfit: The app lets a user create an outfit by putting the clothing items in their closet together to form an outfit.
-	Share Outfits with others: The app allows a user share their created outfits with other users of the app
-	Outfit Planning Calendar: Users can plan their outfits for specific dates using the app’s calendar and weather features
-	Wardrobe Organization: The app offers tools for organizing and categorizing clothing items by type, color, season, making it easy to find and access items when needed

Platform:

The Wear App is available for Android devices.

DETAILS

To use the closet app:

•	Sign up/sign in to app.
•	On home page, from bottom navigation bar, press ‘+’ button to add new clothes.
•	Add new clothing item by taking a picture or uploading from gallery.
•	Create new clothing item by specifying details of clothing item.
•	Add as many clothing items as needed.
•	Clothing items are stored in closet.
•	Create outfit idea by putting different clothing items together. 
•	Change username or password from settings sidebar on home page.
BUILD INSTRUCTIONS

DEPENDENCIES
-	Firebase SDK
-	Gson
-	Firestore
-	Mockito
-	Cupertino icons
-	Flutter SDK
-	Flutter SVG

SYTEM REQUIREMENTS
-	Android Version: Minimum Android 14 (API level 21)
-	Android Phone: Minimum Pixel 3a

NETWORK REQUIREMENTS
-	Internet connectivity is required for Firebase services and accessing weather information.


DESIGN AND IMPLEMENTATION CHOICES

Authentication

-	Design Choice: Use firebase authentication with email/password and Google sign-in
-	Implementation: Implement firebase auth UI components for seamless user authentication

Firestore Database

-	Design Choice: Firestore for scalable and flexible data storage
-	Implementation: Design firestore schema for user profiles, posts, and comments. Implement listeners for real-time updates.


Performance Optimization

-	Design Choice: Optimize network calls and backend calls for improved performance.
-	Implementation: Implement lazy loading and controller classes to minimize network usage

Security

-	Design Choice: Enforce security rules to protect sensitive user data.
-	Implementation: Use Firebase Security rules to restrict access and validate data writes

Dependency Management

-	Design Choice: Use Gradle for managing dependencies and versions.
-	Implementation: Update dependencies regularly to leverage new features and security patches

Testing

-	Design Choice: Plan for unit testing, integration testing, and user acceptance testing
-	Implementation: Design unit tests for critical components and perform integration tests using Mockito 

IMPLEMENTATION ISSUES AND KNOWN BUGS

-	Sign in state is not saved, so user must sign in on each start of the app.
-	Poor implementation of null check so processes continue even with null issues.





CONTRIBUTIONS

TOMIWA ADEWUMI
-	Implemented backend of application
-	Developed user and clothes models
-	Set up firebase dependencies
-	Designed closet screen

ERIC OROKU
-	Designed most screens   
-	Connected backend with frontend
-	Created application workflow 
-	Designed mock screens

DANIEL MOSHOOD
-	Implemented settings function
-	Designed username/password screens
-	Implemented location service
-	Set up GitHub repository
-	Wrote documentation 

SHIVAM PRAJAPATI
-	In charge of testing 
-	Implemented weather display function on home screen

FUTURE WORK
-	Share outfits to other users
-	Smart suggestions of outfits based on clothing items
-	Plan outfits days/weeks/months ahead



