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

-(void)getCountryCode:(CDVInvokedUrlCommand*)command
{
    NSString* callbackId = [command callbackId];
    SKCloudServiceController *cloudServiceController = [[SKCloudServiceController alloc] init];
    [cloudServiceController requestStorefrontIdentifierWithCompletionHandler:^(NSString *storefrontIdentifier, NSError *error) {
        NSString* code;
        NSUInteger idLength = 6;
        storefrontIdentifier = [storefrontIdentifier substringToIndex:idLength];
        int storefrontID = storefrontIdentifier.intValue;
        switch (storefrontID) {
            case 143563: code = @"DZ"; break;
            case 143564: code = @"AO"; break;
            case 143538: code = @"AI"; break;
            case 143540: code = @"AG"; break;
            case 143505: code = @"AR"; break;
            case 143524: code = @"AM"; break;
            case 143460: code = @"AU"; break;
            case 143445: code = @"AT"; break;
            case 143568: code = @"AZ"; break;
            case 143559: code = @"BH"; break;
            case 143490: code = @"BD"; break;
            case 143541: code = @"BB"; break;
            case 143565: code = @"BY"; break;
            case 143446: code = @"BE"; break;
            case 143555: code = @"BZ"; break;
            case 143542: code = @"BM"; break;
            case 143556: code = @"BO"; break;
            case 143525: code = @"BW"; break;
            case 143503: code = @"BR"; break;
            case 143543: code = @"VG"; break;
            case 143560: code = @"BN"; break;
            case 143526: code = @"BG"; break;
            case 143455: code = @"CA"; break;
            case 143544: code = @"KY"; break;
            case 143483: code = @"CL"; break;
            case 143465: code = @"CN"; break;
            case 143501: code = @"CO"; break;
            case 143495: code = @"CR"; break;
            case 143527: code = @"CI"; break;
            case 143494: code = @"HR"; break;
            case 143557: code = @"CY"; break;
            case 143489: code = @"CZ"; break;
            case 143458: code = @"DK"; break;
            case 143545: code = @"DM"; break;
            case 143508: code = @"DO"; break;
            case 143509: code = @"EC"; break;
            case 143516: code = @"EG"; break;
            case 143506: code = @"SV"; break;
            case 143518: code = @"EE"; break;
            case 143447: code = @"FI"; break;
            case 143442: code = @"FR"; break;
            case 143443: code = @"DE"; break;
            case 143573: code = @"GH"; break;
            case 143448: code = @"GR"; break;
            case 143546: code = @"GD"; break;
            case 143504: code = @"GT"; break;
            case 143553: code = @"GY"; break;
            case 143510: code = @"HN"; break;
            case 143463: code = @"HK"; break;
            case 143482: code = @"HU"; break;
            case 143558: code = @"IS"; break;
            case 143467: code = @"IN"; break;
            case 143476: code = @"ID"; break;
            case 143449: code = @"IE"; break;
            case 143491: code = @"IL"; break;
            case 143450: code = @"IT"; break;
            case 143511: code = @"JM"; break;
            case 143462: code = @"JP"; break;
            case 143528: code = @"JO"; break;
            case 143517: code = @"KZ"; break;
            case 143529: code = @"KE"; break;
            case 143466: code = @"KR"; break;
            case 143493: code = @"KW"; break;
            case 143519: code = @"LV"; break;
            case 143497: code = @"LB"; break;
            case 143522: code = @"LI"; break;
            case 143520: code = @"LT"; break;
            case 143451: code = @"LU"; break;
            case 143515: code = @"MO"; break;
            case 143530: code = @"MK"; break;
            case 143531: code = @"MG"; break;
            case 143473: code = @"MY"; break;
            case 143488: code = @"MV"; break;
            case 143532: code = @"ML"; break;
            case 143521: code = @"MT"; break;
            case 143533: code = @"MU"; break;
            case 143468: code = @"MX"; break;
            case 143523: code = @"MD"; break;
            case 143547: code = @"MS"; break;
            case 143484: code = @"NP"; break;
            case 143452: code = @"NL"; break;
            case 143461: code = @"NZ"; break;
            case 143512: code = @"NI"; break;
            case 143534: code = @"NE"; break;
            case 143561: code = @"NG"; break;
            case 143457: code = @"NO"; break;
            case 143562: code = @"OM"; break;
            case 143477: code = @"PK"; break;
            case 143485: code = @"PA"; break;
            case 143513: code = @"PY"; break;
            case 143507: code = @"PE"; break;
            case 143474: code = @"PH"; break;
            case 143478: code = @"PL"; break;
            case 143453: code = @"PT"; break;
            case 143498: code = @"QA"; break;
            case 143487: code = @"RO"; break;
            case 143469: code = @"RU"; break;
            case 143479: code = @"SA"; break;
            case 143535: code = @"SN"; break;
            case 143500: code = @"RS"; break;
            case 143464: code = @"SG"; break;
            case 143496: code = @"SK"; break;
            case 143499: code = @"SI"; break;
            case 143472: code = @"ZA"; break;
            case 143454: code = @"ES"; break;
            case 143486: code = @"LK"; break;
            case 143548: code = @"KN"; break;
            case 143549: code = @"LC"; break;
            case 143550: code = @"VC"; break;
            case 143554: code = @"SR"; break;
            case 143456: code = @"SE"; break;
            case 143459: code = @"CH"; break;
            case 143470: code = @"TW"; break;
            case 143572: code = @"TZ"; break;
            case 143475: code = @"TH"; break;
            case 143539: code = @"BS"; break;
            case 143551: code = @"TT"; break;
            case 143536: code = @"TN"; break;
            case 143480: code = @"TR"; break;
            case 143552: code = @"TC"; break;
            case 143537: code = @"UG"; break;
            case 143444: code = @"GB"; break;
            case 143492: code = @"UA"; break;
            case 143481: code = @"AE"; break;
            case 143514: code = @"UY"; break;
            case 143441: code = @"US"; break;
            case 143566: code = @"UZ"; break;
            case 143502: code = @"VE"; break;
            case 143471: code = @"VN"; break;
            case 143571: code = @"YE"; break;
            default: {
                CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:NO];
                [self.commandDelegate sendPluginResult:result callbackId:callbackId];
                return;
            }
        }
        CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:code];
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

- (void)seek:(CDVInvokedUrlCommand*)command
{
    NSString* callbackId = [command callbackId];
    
    NSString* seekTime = [[command arguments] objectAtIndex:0];
    
    [[MPMusicPlayerController systemMusicPlayer] setCurrentPlaybackTime: seekTime.doubleValue];
    
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