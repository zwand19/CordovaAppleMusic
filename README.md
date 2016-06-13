# Cordova Apple Music Plugin

Allows applications to determine whether or not the phone has a registered Apple Music account. If it does, allows queueing up songs to be played in Apple Music.

### Install the plugin

    $ cordova plugin add https://github.com/zwand19/CordovaAppleMusic.git

### API
```
appleMusicPlugin.getStatus(function(statusCode){}, failureFunction)
```
0 - SKCloudServiceAuthorizationStatusNotDetermined
1 - SKCloudServiceAuthorizationStatusDenied
2 - SKCloudServiceAuthorizationStatusAuthorized
3 - SKCloudServiceAuthorizationStatusRestricted
[enum documentation](https://developer.apple.com/library/ios/documentation/StoreKit/Reference/SKCloudServiceController_Class/#//apple_ref/c/tdef/SKCloudServiceAuthorizationStatus)

```
appleMusicPlugin.requestAuthorization(function(isAuthorized){}, failureFunction)
```
This will prompt the user asking if the application can have access to the user's music library. Calling this multiple times will not show the prompt more than once, if the user does not
permit access the first time. Users must go into Settings -> Your App in order to grant access after the first prompt. Returns whether or not the phone will be app will be capable
of queueing songs for playback.

```
appleMusicPlugin.playTrack(trackId, successFunction, failureFunction)
```
Queues a track, by id, to be played. Example id: https://itunes.apple.com/fr/album/unstoppable/id984653860?i=<b>984653861</b>