---

client: RIMMS TV
title: Multichannel Streaming Server
date: 2016-01-01

summary: I created macOS and iOS apps for RIMMS TV to enable their users to hear custom live audio mixes on set. The macOS server app acts as a live mixer, taking in up to 64 channels from an external sound card in the gallery and providing an unlimited number of separate output mixes fed back to the sound card and recorded using dedicated hardware.

skills:
  - iOS
  - macOS
  - C
  - Audio Units
  - Opus
  - C++
  - Objective-C
  - Swift

image:
  src: https://placehold.it/1200x800/1a1a1a
  alt: Alt text

---

I created macOS and iOS apps for [RIMMS TV](https://www.rimms.tv) to enable their users to hear custom live audio mixes on set.

The macOS server app acts as a live mixer, taking in up to 64 channels from an external sound card in the gallery and providing an unlimited number of separate output mixes fed back to the sound card and recorded using dedicated hardware.

Producers and staff on set carry iPads running the iOS app, which connect to the server and each receive their own live audio mix. Each user can control levels using the iOS app, which talks to the server using a simple [Rest API](https://en.wikipedia.org/wiki/Representational_state_transfer).

I used macOS’s [Audio Units](https://en.wikipedia.org/wiki/Audio_Units) API to implement the matrix mixer, so the server is compatible with a range of audio hardware and can work at any sample rate or buffer format. The audio needed to be streamed from the server to the clients with very low latency (in the tens of milliseconds), so I used a lock free circular buffer to lift samples from the Audio Unit graph and queue them in a separate thread for [Opus](https://en.wikipedia.org/wiki/Opus_(audio_format)) encoding and transmission over TCP.

There were many challenges in making the iOS client app reliable under varying network and battery conditions. I put together a simple wire protocol for the clients to report _heartbeat_ health status messages so the server could adjust its outgoing streams, and did extensive testing using both TCP and UDP approaches to the socket connections.
