//
//  RNShadowButton.h
//  RNButton
//
//  Created by Simon Mitchell on 23/02/2017.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

#if __has_include(<React/RCTShadowView.h>)
#import <React/RCTShadowView.h>
#elif __has_include("RCTShadowView.h")
#import "RCTShadowView.h"
#elif __has_include("React/RCTShadowView.h")
#import "React/RCTShadowView.h"   // Required when used as a Pod in a Swift project
#endif

@interface RNShadowButton : RCTShadowView

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) UIColor *textColor;

@property (nonatomic, copy) RCTBubblingEventBlock onPress;

@property (nonatomic, strong) UIFont *font;

@end
