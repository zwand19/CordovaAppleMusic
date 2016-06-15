# Cordova Apple Music Plugin

Allows applications to determine whether or not the phone has a registered Apple Music account. If it does, allows queueing up songs to be played in Apple Music. Also contains
some methods to manage the currently playing track.

```
cordova plugin add cordova-plugin-apple-music
```

### API

#### Initialize the Plugin
```
appleMusicPlugin.init(successFunction, failureFunction)
```
Only necessary if you want to respond to the plugin's events

#### Get Authorization Status
```
appleMusicPlugin.getStatus(function(statusCode){}, failureFunction)
```
0 - SKCloudServiceAuthorizationStatusNotDetermined

1 - SKCloudServiceAuthorizationStatusDenied

2 - SKCloudServiceAuthorizationStatusAuthorized

3 - SKCloudServiceAuthorizationStatusRestricted

[enum documentation](https://developer.apple.com/library/ios/documentation/StoreKit/Reference/SKCloudServiceController_Class/#//apple_ref/c/tdef/SKCloudServiceAuthorizationStatus)

#### Request Authorization
```
appleMusicPlugin.requestAuthorization(function(isAuthorized){}, failureFunction)
```
This will prompt the user asking if the application can have access to apple music. Calling this multiple times will not show the prompt more than once, if the user does not
permit access the first time. Users must go into Settings -> AppName in order to grant access after the first prompt. Returns whether or not the phone will be app will be capable
of queueing songs for playback.

#### Get Country Code
```
appleMusicPlugin.getCountryCode(successFunction, failureFunction)
```
Returns the country code for the iTunes storefront

#### Play a Track
```
appleMusicPlugin.playTrack(trackId, successFunction, failureFunction)
```
Queues a track by id.

Example id: itunes.apple.com/fr/album/unstoppable/id984653860?i=<b>984653861</b>

#### Get Current Track Duration
```
appleMusicPlugin.getDuration(successFunction, failureFunction)
```
Returns the current track's duration in the callback

#### Get Current Track Position
```
appleMusicPlugin.getPosition(successFunction, failureFunction)
```
Returns the current track's position in the callback

### EVENTS

#### Track stopped playing
```
appleMusicPlugin.onStop(callback)
```
Called whenever an apple music track is stopped, interrupted, or paused.
#### Track seeked
```
appleMusicPlugin.onSeek(callback)
```
Called when the user seeks a new position within a track
#### Track started playing
```
appleMusicPlugin.onPlay(callback)
```
Called whenever an apple music track starts playing