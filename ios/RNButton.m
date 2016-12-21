#import "RNButton.h"

@implementation RNButton

- (void)setTitle:(NSString *)title
{
    _title = title;
    [self setAttributedTitle:[[NSAttributedString alloc] initWithString:title ? : @"" attributes:@{NSFontAttributeName: self.font ?:[UIFont systemFontOfSize:[UIFont systemFontSize]], NSForegroundColorAttributeName: self.textColor}] forState:UIControlStateNormal];
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    [self setAttributedTitle:[[NSAttributedString alloc] initWithString:self.title ? : @"" attributes:@{NSFontAttributeName: self.font ?: [UIFont systemFontOfSize:[UIFont systemFontSize]], NSForegroundColorAttributeName: self.textColor}] forState:UIControlStateNormal];
}

- (void)setFont:(UIFont *)font
{
    if ([font isKindOfClass:[UIFont class]]) {
        _font = font;
    }
    [self setAttributedTitle:[[NSAttributedString alloc] initWithString:self.title ? : @"" attributes:@{NSFontAttributeName: _font ?: [UIFont systemFontOfSize:[UIFont systemFontSize]], NSForegroundColorAttributeName: self.textColor}] forState:UIControlStateNormal];
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    if (enabled) {
        self.alpha = 1.0;
    } else {
        self.alpha = 0.3;
    }
}

@end
