@import UIKit;

#import <React/RCTComponent.h>

@interface RNButton : UIButton

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) UIColor *textColor;

@property (nonatomic, copy) RCTBubblingEventBlock onPress;

@property (nonatomic, strong) UIFont *font;

@end
