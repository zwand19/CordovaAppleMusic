#import "CordovaAppleMusic.h"

@import NotificationCenter;
@import MediaPlayer;
@import StoreKit;

@implementation CordovaAppleMusic

- (void)init:(CDVInvokedUrlCommand*)command
{
    NSString* callbackId = [command callbackId];
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(handlePlaybackStateChanged:) name:MPMusicPlayerControllerPlaybackStateDidChangeNotification object:[MPMusicPlayerController systemMusicPlayer]];
    
    [[MPMusicPlayerController systemMusicPlayer] beginGeneratingPlaybackNotifications];
    
    CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:YES];
    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}

- (void)getStatus:(CDVInvokedUrlCommand*)command
{
    NSString* callbackId = [command callbackId];
    
    SKCloudServiceAuthorizationStatus status = [SKCloudServiceController authorizationStatus];
    
    int res = -1;
    CDVCommandStatus callbackStatus = CDVCommandStatus_OK;
    
    switch (status){
        case SKCloudServiceAuthorizationStatusNotDetermined: res = 0; break;
        case SKCloudServiceAuthorizationStatusDenied: res = 1; break;
        case SKCloudServiceAuthorizationStatusAuthorized: res = 2; break;
        case SKCloudServiceAuthorizationStatusRestricted: res = 3; break;
        default: callbackStatus = CDVCommandStatus_ERROR;
    }
    
    CDVPluginResult* result = [CDVPluginResult resultWithStatus:callbackStatus messageAsInt:res];
    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}

- (void)requestAuthorization:(CDVInvokedUrlCommand*)command
{
    NSString* callbackId = [command callbackId];
    [SKCloudServiceController requestAuthorization:^(SKCloudServiceAuthorizationStatus status) {
        SKCloudServiceController *cloudServiceController = [[SKCloudServiceController alloc] init];
        [cloudServiceController requestCapabilitiesWithCompletionHandler:^(SKCloudServiceCapability capabilities, NSError * _Nullable error) {
            bool isCapable = (capabilities >= SKCloudServiceCapabilityMusicCatalogPlayback);
            CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:isCapable];
            [self.commandDelegate sendPluginResult:result callbackId:callbackId];
        }];
    }];
}

- (void)playTrack:(CDVInvokedUrlCommand*)command
{
    NSString* callbackId = [command callbackId];
    NSString* productID = [[command arguments] objectAtIndex:0];
    [[MPMediaLibrary defaultMediaLibrary] addItemWithProductID:productID completionHandler:^(NSArray<__kindof MPMediaEntity *> * _Nonnull entities, NSError * _Nullable error)
     {
         NSArray *tracksToPlay = [NSArray arrayWithObject:productID];
         [[MPMusicPlayerController systemMusicPlayer] setQueueWithStoreIDs:tracksToPlay];
         [[MPMusicPlayerController systemMusicPlayer] play];
         
         CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:YES];
         [self.commandDelegate sendPluginResult:result callbackId:callbackId];
     }];
}

- (void)getDuration:(CDVInvokedUrlCommand*)command
{
    NSString* callbackId = [command callbackId];
    
    NSNumber *duration = [[MPMusicPlayerController systemMusicPlayer].nowPlayingItem valueForProperty:MPMediaItemPropertyPlaybackDuration];
    
    CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDouble:[duration doubleValue]];
    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}

- (void)getPosition:(CDVInvokedUrlCommand*)command
{
    NSString* callbackId = [command callbackId];
    
    double position = [MPMusicPlayerController systemMusicPlayer].currentPlaybackTime;
    
    CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDouble: position];
    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}

- (void)resume:(CDVInvokedUrlCommand*)command
{
    NSString* callbackId = [command callbackId];
    
    [[MPMusicPlayerController systemMusicPlayer] play];
    
    CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}

- (void)pause:(CDVInvokedUrlCommand*)command
{
    NSString* callbackId = [command callbackId];
    
    [[MPMusicPlayerController systemMusicPlayer] pause];
    
    CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}

- (void)stop:(CDVInvokedUrlCommand*)command
{
    NSString* callbackId = [command callbackId];
    
    [[MPMusicPlayerController systemMusicPlayer] stop];
    
    CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}

- (void)handlePlaybackStateChanged:(NSNotification*)notification
{
    MPMusicPlaybackState state = [MPMusicPlayerController systemMusicPlayer].playbackState;
    if (state == MPMusicPlaybackStateStopped || state == MPMusicPlaybackStateInterrupted || state == MPMusicPlaybackStatePaused) {
        [self.commandDelegate evalJs:@"window.appleMusicPluginStopped()"];
    } else if (state == MPMusicPlaybackStateSeekingForward || state == MPMusicPlaybackStateSeekingBackward) {
        [self.commandDelegate evalJs:@"window.appleMusicPluginSeeked()"];
    } else if (state == MPMusicPlaybackStatePlaying) {
        [self.commandDelegate evalJs:@"window.appleMusicPluginPlaying()"];
    }
}

@end