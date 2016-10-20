//
//  ANCustomFooterView.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 10/7/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANECustomFooterView.h"
#import <Masonry/Masonry.h>
#import "ANHelperFunctions.h"

static UIEdgeInsets const kAttributedLabelInsets = {10.0f, 15.f, 10.0f, 15.f};

@interface ANECustomFooterView ()

@property (nonatomic, strong) UILabel* attributedLabel;

@end

@implementation ANECustomFooterView

- (void)updateWithModel:(ANECustomFooterViewModel*)model
{
    self.attributedLabel.attributedText = model.attributedString;
}

- (CGFloat)estimatedHeight
{
    CGFloat contentHeight = 0.f;
    if (!ANIsEmpty(self.attributedLabel.attributedText))
    {
        CGFloat attributedLabelLeftRightOffsets = kAttributedLabelInsets.left + kAttributedLabelInsets.right;
        CGFloat attributedLabelTopBottomOffsets = kAttributedLabelInsets.top + kAttributedLabelInsets.bottom;

        CGFloat width = [UIScreen mainScreen].bounds.size.width - attributedLabelLeftRightOffsets;

        NSAttributedString* currentAttributedString = self.attributedLabel.attributedText;
        CGFloat labelHeight = [currentAttributedString boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                                              options:(NSStringDrawingOptions)(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                                              context:nil].size.height;
        
        contentHeight = labelHeight + attributedLabelTopBottomOffsets * 2;
    }
    
    return contentHeight;
}


#pragma mark - Private

- (UILabel*)attributedLabel
{
    if (!_attributedLabel)
    {
        _attributedLabel = [UILabel new];
        _attributedLabel.numberOfLines = 0;
        [self.contentView addSubview:_attributedLabel];
        
        [_attributedLabel mas_makeConstraints:^(MASConstraintMaker* make) {
            make.edges.equalTo(self.contentView).insets(kAttributedLabelInsets);
        }];
    }
    
    return _attributedLabel;
}

@end
