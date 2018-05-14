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
#import <React/RCTConvert.h>
#import "RNShadowButton.h"
#import <React/RCTUIManager.h>
#import <React/RCTUIManagerUtils.h>
#import <React/RCTUIManagerObserverCoordinator.h>

@interface RNButtonManager() <RCTUIManagerObserver>

@end

@implementation RNButtonManager {
    NSHashTable<RNShadowButton *> *_shadowViews;
}

RCT_EXPORT_VIEW_PROPERTY(enabled, BOOL)

RCT_EXPORT_SHADOW_PROPERTY(title, NSString *)
RCT_EXPORT_SHADOW_PROPERTY(textColor, UIColor *)
RCT_EXPORT_VIEW_PROPERTY(onPress, RCTBubblingEventBlock)
RCT_EXPORT_SHADOW_PROPERTY(image, id);
RCT_EXPORT_SHADOW_PROPERTY(imageAlignment, NSString *);

RCT_CUSTOM_SHADOW_PROPERTY(imageInsets, UIEdgeInsets, RNShadowButton)
{
    view.imageInsets = [RCTConvert UIEdgeInsets:json];
}
RCT_CUSTOM_SHADOW_PROPERTY(titleInsets, UIEdgeInsets, RNShadowButton)
{
    view.titleInsets = [RCTConvert UIEdgeInsets:json];
}
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
    button.titleLabel.adjustsFontSizeToFitWidth = true;
    return button;
}

- (void)setBridge:(RCTBridge *)bridge
{
    [super setBridge:bridge];
    _shadowViews = [NSHashTable weakObjectsHashTable];
    [bridge.uiManager.observerCoordinator addObserver:self];
}

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

- (RCTShadowView *)shadowView
{
    RNShadowButton *shadowView = [[RNShadowButton alloc] initWithBridge:self.bridge];
    [_shadowViews addObject:shadowView];
    return shadowView;
}

- (void)handleButtonPress:(RNButton *)sender
{
	if (sender.onPress) {
    	sender.onPress(@{});
	}
}

- (void)uiManagerWillPerformMounting:(__unused RCTUIManager *)uiManager
{
    for (RNShadowButton *shadowView in _shadowViews) {
        [shadowView uiManagerWillPerformMounting];
    }
}

@end
