#import <Cordova/CDV.h>

@interface CordovaAppleMusic : CDVPlugin

- (void) getDuration:(CDVInvokedUrlCommand*)command;
- (void) getPosition:(CDVInvokedUrlCommand*)command;
- (void) getStatus:(CDVInvokedUrlCommand*)command;
- (void) init:(CDVInvokedUrlCommand*)command;
- (void) pause:(CDVInvokedUrlCommand*)command;
- (void) playTrack:(CDVInvokedUrlCommand*)command;
- (void) requestAuthorization:(CDVInvokedUrlCommand*)command;
- (void) resume:(CDVInvokedUrlCommand*)command;
- (void) stop:(CDVInvokedUrlCommand*)command;

@end