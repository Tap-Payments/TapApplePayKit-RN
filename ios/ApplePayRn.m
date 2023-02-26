#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(ApplePayRn, NSObject)

RCT_EXTERN_METHOD(generateApplePayRawToken: (NSDictionary *)arguments
                 withResolver:(RCTPromiseResolveBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(generateTapApplePayToken: (NSDictionary *)arguments
                 withResolver:(RCTPromiseResolveBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject)

+ (BOOL)requiresMainQueueSetup
{
  return YES;
}

- (dispatch_queue_t)methodQueue
{
  return dispatch_get_main_queue();
}

@end
