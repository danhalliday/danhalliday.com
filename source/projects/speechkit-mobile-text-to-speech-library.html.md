---

client: SpeechKit
title: Mobile Text-to-Speech Library
date: 2017-01-01

summary: I wrote an iOS SDK for SpeechKit to give their customers an easy way to add podcast content to their apps.

skills:
  - iOS
  - Swift
  - CocoaPods
  - API Design
  - Documentation
  - React Native

image:
  src: https://www.datocms-assets.com/18750/1574858651-dsc6317.jpg
  alt: Printed development kit documentation

---

I wrote an iOS [SDK](https://en.wikipedia.org/wiki/Software_development_kit) for [SpeechKit](https://speechkit.io) to give their customers an easy way to add podcast content to their apps. The kit is distributed on [CocoaPods](https://cocoapods.org), and can be added to an app in minutes.

The implementation was relatively straightforward, being a thin front end to a backend service which uses IBM’s [Watson](https://www.ibm.com/watson/) to perform text-to-speech synthesis and intelligently cache articles as apps request them.

The emphasis was really on ease of use and reliability for the developer, so I used iOS’s network and audio frameworks to avoid depending on lots of third party libraries, wrote extensive tests including testing the actual audio playback, and spent time writing readmes, API documentation, and code samples for both Objective-C and Swift.

To demonstrate the kit and help with real-world testing, I put together a [React Native](https://www.reactnative.com) app which lists recent news stories from a range of publications, and features a mini player which reads the stories as a playlist. The app was released on the App Store and its _native bridge_ code added to the documentation to make integration with React apps easier.
