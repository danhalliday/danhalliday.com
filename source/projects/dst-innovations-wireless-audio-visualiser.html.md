---

client: DST Innovations
title: Wireless Audio Visualiser
date: 2017-06-01

summary: I built an iOS app for DST Innovations to serve as a controller for their prototype multimedia fashion product.

skills:
  - C
  - DSP
  - iOS
  - Swift
  - Audio Units
  - Accelerate
  - Bluetooth
  - Node.js
  - Documentation

image:
  src: https://www.datocms-assets.com/18750/1576834119-audio-visualiser-app.jpg
  alt: Audio visualiser running on mobile device

---

I built an iOS app for [DST Innovations](http://www.dst-innovations.net) to serve as a controller for their prototype multimedia fashion product.

![App running on a mobile device](https://www.datocms-assets.com/18750/1576834119-audio-visualiser-app.jpg)

The product features a wireless peripheral driving a visualiser display, which reacts to live music. The iOS app is a music player which analyses the audio in real time and computes a frequency spectrum, which is sent wirelessly to the peripheral.

The main requirement was that the music and visuals played in lockstep, so I devised a clock synchronisation mechanism. The iOS app uses a very basic approximation to [Network Time Protocol](https://en.wikipedia.org/wiki/Network_Time_Protocol) to establish a common clock with the peripheral — in the order of a few milliseconds’ accuracy. It then delays audio playout by a fixed period for safety, and sends each audio frame with a timestamp against the common clock so the peripheral knows exactly when each frame should be displayed.

![App title detail](https://www.datocms-assets.com/18750/1576835113-audio-visualiser-title-detail.jpg "App title detail")

![App FFT detail](https://www.datocms-assets.com/18750/1576835157-audio-visualiser-fft-detail.jpg "App FFT detail")

![App icon detail](https://www.datocms-assets.com/18750/1576835181-audio-visualiser-icon-detail.jpg "App icon detail")

I worked with iOS’s [Audio Units](https://en.wikipedia.org/wiki/Audio_Units) API to play and capture the audio data, and used a lock free circular buffer to pull samples out, running an FFT analysis on them on a separate thread and queueing them for transmission. Limitations on the data rate for Bluetooth LE meant packing the data fairly tightly, so I designed and documented a binary wire protocol, with a concise layout for _sync_ and _data_ packets.

![Documentation detail](https://www.datocms-assets.com/18750/1576835221-audio-visualiser-documentation.jpg)

To test the system end-to-end, I created a simple Node.js tool running on a desktop computer which prints Bluetooth session lifecycle events and statistics on the incoming packets, and could be left running for long periods. This was especially helpful with the clock synchronisation mechanism, which would have been wildly unstable without some timeout values and other insights pulled from extended real-world use.

![Documentation detail](https://www.datocms-assets.com/18750/1576835243-audio-visualiser-documentation-detail-1.jpg "Documentation detail")

![Documentation detail](https://www.datocms-assets.com/18750/1576835259-audio-visualiser-documentation-detail-2.jpg "Documentation detail")
