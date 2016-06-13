#import <Cordova/CDV.h>

@interface CordovaAppleMusic : CDVPlugin

- (void) getStatus:(CDVInvokedUrlCommand*)command;
- (void) requestAuthorization:(CDVInvokedUrlCommand*)command;
- (void) playTrack:(CDVInvokedUrlCommand*)command;
- (void) getStorefrontID:(CDVInvokedUrlCommand*)command;

@end