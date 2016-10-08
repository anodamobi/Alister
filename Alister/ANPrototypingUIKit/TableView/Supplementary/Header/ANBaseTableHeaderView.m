//
//  ANBaseTableHeaderFooterView.m
//
//  Created by Oksana Kovalchuk on 4/11/14.
//  Copyright (c) 2014 ANODA. All rights reserved.
//

#import "ANBaseTableHeaderView.h"

@interface ANBaseTableHeaderView ()

@end

@implementation ANBaseTableHeaderView

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
    CGRect textRect = [self.titleLabel.text boundingRectWithSize:CGSizeMake(size.width, MAXFLOAT)
                                                        options:NSStringDrawingUsesLineFragmentOrigin
                                                     attributes:attributes
                                                        context:nil];
    
    CGFloat height = textRect.size.height + self.titleInsets.top + self.titleInsets.bottom;
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
        self.titleLabel.text = [model uppercaseString];
    }
}

/*
*  We use custom label, because changing frame of system label will cause -layoutSubviews method
*/
 
#pragma mark - Views

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
