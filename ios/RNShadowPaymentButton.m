//
//  RNShadowButton.m
//  RNButton
//
//  Created by Simon Mitchell on 23/02/2017.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "RNShadowPaymentButton.h"
#import "RNPaymentButton.h"

#if __has_include(<React/RCTUtils.h>)
#import <React/RCTUtils.h>
#elif __has_include("RCTUtils.h")
#import "RCTUtils.h"
#elif __has_include("React/RCTUtils.h")
#import "React/RCTUtils.h"   // Required when used as a Pod in a Swift project
#endif

#if __has_include(<React/RCTUIManager.h>)
#import <React/RCTUIManager.h>
#elif __has_include("RCTUIManager.h")
#import "RCTUIManager.h"
#elif __has_include("React/RCTUIManager.h")
#import "React/RCTUIManager.h"   // Required when used as a Pod in a Swift project
#endif

#if __has_include(<React/RCTShadowView+Layout.h>)
#import <React/RCTShadowView+Layout.h>
#elif __has_include("RCTShadowView+Layout.h")
#import "RCTShadowView+Layout.h"
#elif __has_include("React/RCTShadowView+Layout.h")
#import "React/RCTShadowView+Layout.h"   // Required when used as a Pod in a Swift project
#endif

@interface RNShadowPaymentButton ()

@end

@implementation RNShadowPaymentButton
{
    __weak RCTBridge *_bridge;
    BOOL _needsUpdateView;
}

- (instancetype)initWithBridge:(RCTBridge *)bridge
{
    if ((self = [super init])) {
        
        _bridge = bridge;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(contentSizeMultiplierDidChange:)
                                                     name:RCTUIManagerWillUpdateViewsDueToContentSizeMultiplierChangeNotification
                                                   object:nil];
    }
    
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)dirtyLayout
{
    _needsUpdateView = true;
    [super dirtyLayout];
}

- (BOOL)isYogaLeafNode
{
    return true;
}

- (void)uiManagerWillPerformMounting
{
    if (YGNodeIsDirty(self.yogaNode)) {
        return;
    }
    
    if (!_needsUpdateView) {
        return;
    }
    _needsUpdateView = NO;
    
    NSNumber *tag = self.reactTag;
    
    [_bridge.uiManager addUIBlock:^(RCTUIManager *uiManager, NSDictionary<NSNumber *,UIView *> *viewRegistry) {
        
        RNPaymentButton *button = (RNPaymentButton *)viewRegistry[tag];
        if (!button) {
            return;
        }
        
        button.type = self.type;
        button.style = self.style;
    }];
}

- (void)contentSizeMultiplierDidChange:(NSNotification *)note
{
    [self dirtyLayout];
}

- (void)setType:(PKPaymentButtonType)type
{
    _type = type;
    [self dirtyLayout];
}

- (void)setStyle:(PKPaymentButtonStyle)style
{
    _style = style;
    [self dirtyLayout];
}

@end
