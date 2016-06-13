#import "CordovaAppleMusic.h"

@import StoreKit;

@implementation CordovaAppleMusic

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

    CDVPluginResult* result = [CDVPluginResult
                               resultWithStatus:callbackStatus
                               messageAsInt:res];

    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}

@end