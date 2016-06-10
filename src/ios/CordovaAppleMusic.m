#import "CordovaAppleMusic.h"

@implementation CordovaAppleMusic

- (void)isActive:(CDVInvokedUrlCommand*)command
{

    NSString* callbackId = [command callbackId];

    CDVPluginResult* result = [CDVPluginResult
                               resultWithStatus:CDVCommandStatus_OK
                               messageAsBool:NO];

    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}

@end