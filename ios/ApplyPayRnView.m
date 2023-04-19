//
//  ApplyPayRnView.m
//  tap-payments-apple-pay-rn
//
//  Created by MahmoudShaabanAllam on 25/02/2023.
//

@import Foundation;
@import TapApplePayKit_iOS;

#import <React/RCTViewManager.h>

@interface RCT_EXTERN_MODULE(ApplePayRnViewManager, RCTViewManager)
  RCT_EXPORT_VIEW_PROPERTY(buttonStyle, NSString)
  RCT_EXPORT_VIEW_PROPERTY(buttonType, NSString)
@end


