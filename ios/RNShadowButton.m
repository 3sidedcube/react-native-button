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

#if __has_include(<React/RCTShadowView+Layout.h>)
#import <React/RCTShadowView+Layout.h>
#elif __has_include("RCTShadowView+Layout.h")
#import "RCTShadowView+Layout.h"
#elif __has_include("React/RCTShadowView+Layout.h")
#import "React/RCTShadowView+Layout.h"   // Required when used as a Pod in a Swift project
#endif

@interface RNShadowButton ()

@end

@implementation RNShadowButton
{
    __weak RCTBridge *_bridge;
}

- (instancetype)initWithBridge:(RCTBridge *)bridge
{
    if ((self = [super init])) {
      
        _bridge = bridge;
        YGNodeSetMeasureFunc(self.yogaNode, RNShadowButtonMeasure);
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

- (BOOL)isYogaLeafNode
{
    return true;
}

- (void)uiManagerWillPerformMounting
{
    NSNumber *tag = self.reactTag;
    
    [_bridge.uiManager addUIBlock:^(RCTUIManager *uiManager, NSDictionary<NSNumber *,UIView *> *viewRegistry) {
        
        RNButton *button = (RNButton *)viewRegistry[tag];
        if (!button) {
            return;
        }
        
        button.title = self.title;
        button.font = self.font;
        button.image = self.image;
        button.titleEdgeInsets = self.titleInsets;
        button.imageEdgeInsets = self.imageInsets;
        button.imageAlignment = self.imageAlignment;
        button.textColor = self.textColor;
    }];
}

static YGSize RNShadowButtonMeasure(YGNodeRef node, float width, YGMeasureMode widthMode, float height, YGMeasureMode heightMode)
{
    CGSize maximumSize = (CGSize){
        widthMode == YGMeasureModeUndefined ? CGFLOAT_MAX : RCTCoreGraphicsFloatFromYogaFloat(width),
        heightMode == YGMeasureModeUndefined ? CGFLOAT_MAX : RCTCoreGraphicsFloatFromYogaFloat(height),
    };
    
    RNShadowButton *shadowButton = (__bridge RNShadowButton *)YGNodeGetContext(node);
    
    NSTextStorage *textStorage = [[NSTextStorage alloc] initWithString: shadowButton.title ? : @"" attributes:@{NSFontAttributeName : shadowButton.font ? : [UIFont systemFontOfSize:17]}];
    
    NSLayoutManager *layoutManager = textStorage.layoutManagers.firstObject;
    NSTextContainer *textContainer = layoutManager.textContainers.firstObject;
    [layoutManager ensureLayoutForTextContainer:textContainer];
    CGSize size = [layoutManager usedRectForTextContainer:textContainer].size;
    
    size = (CGSize){
        MIN(RCTCeilPixelValue(size.width), maximumSize.width),
        MIN(RCTCeilPixelValue(size.height), maximumSize.height)
    };
    
    // Adding epsilon value illuminates problems with converting values from
    // `double` to `float`, and then rounding them to pixel grid in Yoga.
    CGFloat epsilon = 0.001;
    return (YGSize){
        RCTYogaFloatFromCoreGraphicsFloat(size.width + epsilon),
        RCTYogaFloatFromCoreGraphicsFloat(size.height + epsilon)
    };
}

- (void)dirtyLayout
{
    [super dirtyLayout];
}

- (void)contentSizeMultiplierDidChange:(NSNotification *)note
{
    [self dirtyLayout];
}

- (void)setFont:(UIFont *)font
{
    _font = font;
    [self dirtyLayout];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    [self dirtyLayout];
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    [self dirtyLayout];
}

- (void)setImage:(id)image
{
    _image = image;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self dirtyLayout];
    });
}

- (void)setImageInsets:(UIEdgeInsets)imageInsets
{
    _imageInsets = imageInsets;
    [self dirtyLayout];
}

- (void)setTitleInsets:(UIEdgeInsets)titleInsets
{
    _titleInsets = titleInsets;
    [self dirtyLayout];
}

- (void)setImageAlignment:(NSString *)imageAlignment
{
    _imageAlignment = imageAlignment;
    [self dirtyLayout];
}

@end
