//
//  ANTableViewHeaderFooterView.m
//
//  Created by Oksana Kovalchuk on 29/10/14.
//  Copyright (c) 2014 ANODA. All rights reserved.
//

#import "ANBaseTableViewHeaderFooterView.h"

@implementation ANBaseTableViewHeaderFooterView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.titleInsets = UIEdgeInsetsMake(15, 15, 0, 15);
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize size = self.bounds.size;
    
    NSDictionary* attributes = @{NSFontAttributeName: self.titleLabel.font};
    CGRect textRect = [self.titleLabel.text boundingRectWithSize:CGSizeMake(size.width - self.titleInsets.left - self.titleInsets.right, MAXFLOAT)
                                                         options:NSStringDrawingUsesLineFragmentOrigin
                                                      attributes:attributes
                                                         context:nil];
    //TODO: rect methods
    CGFloat height = CGRectGetHeight(textRect) + self.titleInsets.top + self.titleInsets.bottom;
    CGFloat yOffset = (size.height - height) - self.titleInsets.top;
    self.titleLabel.frame = CGRectMake(self.titleInsets.left,
                                       yOffset,
                                       size.width - (self.titleInsets.left + self.titleInsets.right),
                                       height);
}

- (void)updateWithModel:(NSString*)model
{
    if ([model isKindOfClass:[NSString class]])
    {
        self.titleLabel.text = model;
    }
}

- (void)setIsTransparent:(BOOL)isTransparent
{
    if (isTransparent)
    {
        self.backgroundView = [UIView new];
    }
    _isTransparent = isTransparent;
}


#pragma mark - Views

/**
 Custom label used to handle frame adjustments
 */
- (UILabel*)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor colorWithRed:77/255 green:77/255 blue:77/255 alpha:1];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.clipsToBounds = NO;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

@end
