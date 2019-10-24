# BettyLabs Takehome
---------

**The purpose of this exercise is to give you a practical test of your ability to write some client and server functionality,  
and also testing your ability to understand one of our main pain-points, Push Notifications**

## **So here’s the outline for the exercise:**
- Subscribe an iOS app to multiple Push Notification channels
- Also subscribe to Push Notifications for a specific User
- Client will also be able to send requests to a webserver to create Push Notifications, which the same Client will in turn receive
- Write a webserver with:
  - an endpoint that emits push notifications on a channel
  - an endpoint that emits push notifications to a specific user

## **Example App Flow:**
1) Have two UISwitches for channels, “Global”, “Game_XYZ”.  Toggle “Global” ON, and "Game_XYZ" OFF
2) In the fields to create a Push Notification, you type “Global” into the channel field, “Hello” and “World” into the title and body fields
3) Pushing a Send button sends a request to the Webserver
4) Webserver emits Push Notification on channel “Global"
5) Client Receives Push Notification
--------
6) Update Channel field to say “Game_XYZ” instead of “Global”, and send again
7) Webserver emits Push Notifications to the channel “Game_XYZ”
8) Client receives nothing, because it’s not subscribed to “Game_XYZ"
--------
10) Flip switch to send to User_Hello, send again
11) Webserver emits Push Notification to specific user: User_Hello
12) Client is logged in as User_Hello, so it receives the notification


## **Setup:**
1) Download Repo, the Client Package Manager is CocoaPods, but the packages are being tracked on the repo so you will not need to install
2) The Server Package Manager is `npm`, so you'll need to `cd` to `./Server`, `npm install`, `npm run build`, `npm run start`
3) In Client, go to APIManager.swift, and update `serviceURL` with your machine's name
4) Run the app, press Send button, and you should see requests coming into your server


## **Accounts:**
- I have added you as a developer in our AppStore Organization so that you can build to a phone, and so the Push Notifications can be registered properly
- I have added you as a collaborator in Pusher Beams, https://dash.pusher.com/beams/3501f6a8-dce2-4333-94ac-d32b363d2e7d. 
  - You can go to Debug Console, set Interest as `debug-channel`, and you can test sending Push Notifications to your built client

## **Resources:**
Typescript + Express: https://levelup.gitconnected.com/setup-express-with-typescript-in-3-easy-steps-484772062e01
Publishing Notifications: https://pusher.com/docs/beams/guides/publishing-to-multiple-devices#publish-to-the-device-interest