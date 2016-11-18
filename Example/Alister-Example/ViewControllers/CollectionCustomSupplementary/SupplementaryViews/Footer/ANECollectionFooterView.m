//
//  ANECollectionFooterView.m
//  Alister-Example
//
//  Created by ANODA on 11/18/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANECollectionFooterView.h"
#import "Masonry.h"

@interface ANECollectionFooterView ()

@property (nonatomic, strong) UILabel* titleLabel;

@end

@implementation ANECollectionFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor greenColor];
    }
    return self;
}

- (void)updateWithModel:(NSString*)model
{
    self.titleLabel.text = model;
}


#pragma mark - Lazy Load

- (UILabel*)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [UILabel new];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont boldSystemFontOfSize:20];
        [self addSubview:_titleLabel];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.right.equalTo(self).offset(-10);
            make.top.bottom.equalTo(self);
        }];
    }
    return _titleLabel;
}

@end
