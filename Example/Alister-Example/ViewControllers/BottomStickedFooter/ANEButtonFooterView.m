//
//  ANEButtonFooterView.m
//  Alister-Example
//
//  Created by ANODA on 10/19/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANEButtonFooterView.h"
#import <Masonry/Masonry.h>

static CGSize const kButtonSizeInsets = {120, 44};

@implementation ANEButtonFooterView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor lightGrayColor];
    }
    
    return self;
}


#pragma mark - Lazy Load

- (UIButton*)actionButton
{
    if (!_actionButton)
    {
        _actionButton = [UIButton new];
        _actionButton.backgroundColor = [UIColor greenColor];
        _actionButton.layer.cornerRadius = kButtonSizeInsets.height / 2;
        _actionButton.titleLabel.font = [UIFont systemFontOfSize:16];
        _actionButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_actionButton setTitle:NSLocalizedString(@"bottom-sticked-view.button.title", nil) forState:UIControlStateNormal];
        [_actionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:_actionButton];
        
        [_actionButton mas_makeConstraints:^(MASConstraintMaker* make) {
            make.center.equalTo(self);
            make.height.equalTo(@(kButtonSizeInsets.height));
            make.width.equalTo(@(kButtonSizeInsets.width));
        }];
    }
    
    return _actionButton;
}

@end
