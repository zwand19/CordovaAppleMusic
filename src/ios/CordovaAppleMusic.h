#import <Cordova/CDV.h>

@interface CordovaAppleMusic : CDVPlugin

- (void) getStatus:(CDVInvokedUrlCommand*)command;
- (void) requestAuthorization:(CDVInvokedUrlCommand*)command;

@end