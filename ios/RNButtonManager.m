//
//  RNButtonViewManager.m
//  RNButton
//
//  Created by Simon Mitchell on 11/05/2016.
//  Copyright © 2016 Facebook. All rights reserved.
//

#import "RNButtonManager.h"
#import "RNButton.h"
#import <React/RCTBridge.h>
#import <React/RCTEventDispatcher.h>
#import <React/RCTFont.h>
#import "RNShadowButton.h"

@implementation RNButtonManager

RCT_EXPORT_VIEW_PROPERTY(enabled, BOOL)

RCT_EXPORT_SHADOW_PROPERTY(title, NSString *)
RCT_EXPORT_SHADOW_PROPERTY(textColor, UIColor *)
RCT_EXPORT_SHADOW_PROPERTY(onPress, RCTBubblingEventBlock)

RCT_CUSTOM_SHADOW_PROPERTY(fontSize, CGFloat, RNShadowButton)
{
    view.font = [RCTFont updateFont:view.font withSize:json ?: @([UIFont systemFontSize])];
}
RCT_CUSTOM_SHADOW_PROPERTY(fontWeight, NSString, RNShadowButton)
{
    view.font = [RCTFont updateFont:view.font withWeight:json]; // defaults to normal
}
RCT_CUSTOM_SHADOW_PROPERTY(fontStyle, NSString, RNShadowButton)
{
    view.font = [RCTFont updateFont:view.font withStyle:json]; // defaults to normal
}
RCT_CUSTOM_SHADOW_PROPERTY(fontFamily, NSString, RNShadowButton)
{
    view.font = [RCTFont updateFont:view.font withFamily:json ?: [UIFont systemFontOfSize:[UIFont systemFontSize]].familyName];
}

RCT_EXPORT_MODULE()
- (UIView *)view
{
    RNButton *button = [RNButton new];
    button.textColor = [UIColor blackColor];
    button.font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    [button addTarget:self action:@selector(handleButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (RCTShadowView *)shadowView
{
    return [RNShadowButton new];
}

- (void)handleButtonPress:(RNButton *)sender
{
	if (sender.onPress) {
    	sender.onPress(@{});
	}
}

@end
