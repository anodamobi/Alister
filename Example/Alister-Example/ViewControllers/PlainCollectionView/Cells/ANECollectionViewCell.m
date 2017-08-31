//
//  ANECollectionViewCell.m
//  Alister-Example
//
//  Created by ANODA on 11/18/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANECollectionViewCell.h"

@interface ANECollectionViewCell ()

@property (nonatomic, strong) UILabel* titleLabel;

@end

@implementation ANECollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3f];
    }
    
    return self;
}

- (void)updateWithModel:(NSString*)model
{
    self.titleLabel.text = model;
}

- (void)layoutSubviews
{
    self.titleLabel.frame = self.contentView.frame;
    
    [super layoutSubviews];
}

#pragma mark - Lazy Load

- (UILabel*)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [UILabel new];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

@end
