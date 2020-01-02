# BettyLabs Takehome
---------

**The purpose of this exercise is to give you a practical test of your ability to write some client and server functionality,  
and also testing your ability to understand one of our main pain-points, Push Notifications**

## **So here’s the outline for the exercise:**
- Subscribe an iOS app to multiple Push Notification channels
- Client will also be able to send requests to a webserver to create Push Notifications, which the same Client will in turn receive
- Write a webserver with:
  - an endpoint that emits push notifications on a channel

## **Example App Flow:**
1) Have two UISwitches for channels, “announcements-YOURNAME”, “game-xyz-YOURNAME”.  Toggle “announcements-YOURNAME” ON, and "game-xyz-YOURNAME" OFF
2) In the fields to create a Push Notification, you type “announcements” into the channel field, “Hello” and “World” into the title and body fields
3) Pushing a Send button sends a request to the Webserver
4) Webserver emits Push Notification on channel “announcements-YOURNAME"
5) Client Receives Push Notification
--------
6) Update Channel field to say “game-xyz-YOURNAME” instead of “announcements-YOURNAME”, and send again
7) Webserver emits Push Notifications to the channel “game-xyz-YOURNAME”
8) Client receives nothing, because it’s not subscribed to “game-xyz-YOURNAME"


## **Setup:**
1) Download Repo, the Client Package Manager is CocoaPods, but the packages are being tracked on the repo so you will not need to install
2) Update all instances of "announcements-YOURNAME" and "game-xyz-YOURNAME", so that your notifications won't overlap with other candidates
3) The Server Package Manager is `npm`, so you'll need to `cd` to `./Server`, `npm install`, `npm run build`, `npm run start`
4) In Client, go to APIManager.swift, and update `serviceURL` with your machine's name
5) Run the app, press Send button, and you should see requests coming into your server


## **Accounts:**
- I have added you as a developer in our AppStore Organization so that you can build to a phone, and so the Push Notifications can be registered properly
- I have added you as a collaborator in OneSignal, https://app.onesignal.com/apps/d7d16830-f584-40a7-83c3-ed1eb2932538. 
  - After you've built the client, you should see your phone in All Users; you can add yourself as a Test User so that you can test sending notifications directly to your phone

## **Resources:**
Typescript + Express: https://levelup.gitconnected.com/setup-express-with-typescript-in-3-easy-steps-484772062e01
Publishing Notifications: https://documentation.onesignal.com/reference
# BLTakeHome-Richardson
