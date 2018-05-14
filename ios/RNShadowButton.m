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

@property (nonatomic, strong) RNButton *button;

@end

@implementation RNShadowButton

- (instancetype)init
{
    if ((self = [super init])) {
        
        self.button = [RNButton new];
        self.button.textColor = [UIColor blackColor];
        self.button.font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
        YGNodeSetMeasureFunc(self.yogaNode, RCTMeasure);
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
    YGNodeMarkDirty(self.yogaNode);
    [self.button setNeedsLayout];
}

- (void)setFont:(UIFont *)font
{
    _font = font;
    [self.button setFont:font];
    [self dirtyLayout];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    [self.button setTitle:title];
    [self dirtyLayout];
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    [self.button setTextColor:textColor];
    [self dirtyLayout];
}

- (void)setOnPress:(RCTBubblingEventBlock)onPress
{
    _onPress = onPress;
    [self.button setOnPress:onPress];
    [self dirtyLayout];
}

- (void)setImage:(id)image
{
    _image = image;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.button.image = [RCTConvert UIImage:image];
        YGNodeMarkDirty(self.yogaNode);
        [self.button setNeedsLayout];
        [self dirtyLayout];
    });
}

- (void)setImageInsets:(UIEdgeInsets)imageInsets
{
    _imageInsets = imageInsets;
    self.button.imageEdgeInsets = imageInsets;
    [self dirtyLayout];
}

- (void)setTitleInsets:(UIEdgeInsets)titleInsets
{
    _titleInsets = titleInsets;
    self.button.titleEdgeInsets = titleInsets;
    [self dirtyLayout];
}

- (void)setImageAlignment:(NSString *)imageAlignment
{
    _imageAlignment = imageAlignment;
    self.button.imageAlignment = imageAlignment;
    [self dirtyLayout];
}

@end
