//
//  RNButtonViewManager.m
//  RNButton
//
//  Created by Simon Mitchell on 11/05/2016.
//  Copyright © 2016 Facebook. All rights reserved.
//

#import "RNButtonManager.h"
#import "RNButton.h"
#import "RCTBridge.h"
#import "RCTEventDispatcher.h"
#import "RCTConvert.h"

@implementation RNButtonManager

RCT_EXPORT_VIEW_PROPERTY(title, NSString *)
RCT_EXPORT_VIEW_PROPERTY(textColor, UIColor *)
RCT_EXPORT_VIEW_PROPERTY(onPress, RCTBubblingEventBlock)

RCT_CUSTOM_VIEW_PROPERTY(fontSize, CGFloat, RNButton)
{
    view.font = [RCTConvert UIFont:view.font withSize:json ?: @(defaultView.font.pointSize)];
}
RCT_CUSTOM_VIEW_PROPERTY(fontWeight, NSString, RNButton)
{
    view.font = [RCTConvert UIFont:view.font withWeight:json]; // defaults to normal
}
RCT_CUSTOM_VIEW_PROPERTY(fontStyle, NSString, RNButton)
{
    view.font = [RCTConvert UIFont:view.font withStyle:json]; // defaults to normal
}
RCT_CUSTOM_VIEW_PROPERTY(fontFamily, NSString, RNButton)
{
    view.font = [RCTConvert UIFont:view.font withFamily:json ?: defaultView.font.familyName];
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

- (void)handleButtonPress:(RNButton *)sender
{
	if (sender.onPress) {
    	sender.onPress(@{});
	}
}

@end
