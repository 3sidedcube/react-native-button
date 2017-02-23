//
//  RNShadowButton.m
//  RNButton
//
//  Created by Simon Mitchell on 23/02/2017.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "RNShadowButton.h"
#import "RNButton.h"

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

@interface RNShadowButton ()

@property (nonatomic, strong) RNButton *button;

@end

@implementation RNShadowButton

- (instancetype)init
{
    if ((self = [super init])) {
        
        self.button = [RNButton new];
        self.button.textColor = [UIColor blackColor];
        self.button.font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
        YGNodeSetMeasureFunc(self.cssNode, RCTMeasure);
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

- (BOOL)isCSSLeafNode
{
    return true;
}

static YGSize RCTMeasure(YGNodeRef node, float width, YGMeasureMode widthMode, float height, YGMeasureMode heightMode)
{
    RNShadowButton *shadowButton = (__bridge RNShadowButton *)YGNodeGetContext(node);
    
    [shadowButton.button sizeToFit];
    
    CGSize computedSize = shadowButton.button.frame.size;
    
    YGSize result;
    result.width = RCTCeilPixelValue(computedSize.width);
    result.height = RCTCeilPixelValue(computedSize.height);
    
    return result;
}

- (void)contentSizeMultiplierDidChange:(NSNotification *)note
{
    YGNodeMarkDirty(self.cssNode);
    [self.button setNeedsLayout];
}

- (NSDictionary<NSString *,id> *)processUpdatedProperties:(NSMutableSet<RCTApplierBlock> *)applierBlocks parentProperties:(NSDictionary<NSString *,id> *)parentProperties
{
    parentProperties = [super processUpdatedProperties:applierBlocks parentProperties:parentProperties];
    
    __weak typeof(self) welf = self;
    
    UIEdgeInsets padding = self.paddingAsInsets;
    
    [applierBlocks addObject:^(NSDictionary<NSNumber *, UIView *> *viewRegistry) {
        
        RNButton *button = (RNButton *)viewRegistry[self.reactTag];
        button.onPress = self.onPress;
        if (welf.font) {
            button.font = self.font;
        }
        if (welf.textColor) {
            button.textColor = self.textColor;
        }
        if (welf.title) {
            button.title = self.title;
        }
    }];
    
    return parentProperties;
}

- (void)setFont:(UIFont *)font
{
    _font = font;
    [self.button setFont:font];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    [self.button setTitle:title];
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    [self.button setTextColor:textColor];
}

- (void)setOnPress:(RCTBubblingEventBlock)onPress
{
    _onPress = onPress;
    [self.button setOnPress:onPress];
}

@end
