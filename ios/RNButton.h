@import UIKit;

#import <React/RCTComponent.h>

@interface RNButton : UIButton

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) UIColor *textColor;

@property (nonatomic, copy) RCTBubblingEventBlock onPress;

@property (nonatomic, strong) UIFont *font;

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, copy) NSString *imageAlignment;

@property (nonatomic, assign) UIEdgeInsets padding;

@end
