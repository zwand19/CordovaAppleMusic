#import "CordovaAppleMusic.h"

@implementation CordovaAppleMusic

- (void)isActive:(CDVInvokedUrlCommand*)command
{

    NSString* callbackId = [command callbackId];

    CDVPluginResult* result = [CDVPluginResult
                               resultWithStatus:CDVCommandStatus_OK
                               NSNumber numberWithBool:NO];

    [self success:result callbackId:callbackId];
}

@end