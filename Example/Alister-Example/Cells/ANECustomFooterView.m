//
//  ANCustomFooterView.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 10/7/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANECustomFooterView.h"
#import <Masonry/Masonry.h>

@interface ANECustomFooterView ()

@property (nonatomic, strong) UILabel* attributedLabel;

@end

@implementation ANECustomFooterView

- (void)updateWithModel:(ANECustomFooterViewModel*)model
{
    self.attributedLabel.attributedText = model.attributedString;
}


#pragma mark - Private

- (UILabel*)attributedLabel
{
    if (!_attributedLabel)
    {
        _attributedLabel = [UILabel new];
        [self.contentView addSubview:_attributedLabel];
        
        [_attributedLabel mas_makeConstraints:^(MASConstraintMaker* make) {
            make.left.equalTo(self.contentView).offset(15);
            make.bottom.right.top.equalTo(self.contentView);
        }];
    }
    
    return _attributedLabel;
}

@end
