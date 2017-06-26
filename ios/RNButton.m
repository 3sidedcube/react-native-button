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
    [self setAttributedTitle:[[NSAttributedString alloc] initWithString:self.title ? : @"" attributes:@{NSFontAttributeName: self.font ?: [UIFont systemFontOfSize:[UIFont systemFontSize]], NSForegroundColorAttributeName: textColor}] forState:UIControlStateNormal];
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

- (void)setImage:(UIImage *)image
{
    _image = image;
    [self setImage:image forState:UIControlStateNormal];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if ([self.imageAlignment isEqualToString:@"left"]) {
        
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        CGRect availableSpace = UIEdgeInsetsInsetRect(self.bounds, self.contentEdgeInsets);
        CGFloat availableWidth = availableSpace.size.width + self.imageEdgeInsets.right - (self.imageView ? self.imageView.frame.size.width : 0) - (self.titleLabel ? self.titleLabel.frame.size.width : 0);
        self.contentEdgeInsets = self.padding;
        self.titleEdgeInsets = UIEdgeInsetsMake(0, availableWidth/2, 0, 0);
        
    } else {
        
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    }
}

@end
