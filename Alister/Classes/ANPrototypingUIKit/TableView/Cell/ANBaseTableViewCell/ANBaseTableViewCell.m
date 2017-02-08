//
//  ANTableViewController.h
//
//  Created by Oksana Kovalchuk on 29/10/14.
//  Copyright (c) 2014 ANODA. All rights reserved.
//

#import "ANBaseTableViewCell.h"

@implementation ANBaseTableViewCell

- (void)updateWithModel:(id)model
{
    if ([model isKindOfClass:[NSString class]])
    {
        self.textLabel.text = model;
    }
}

- (id)model
{
    return nil;
}

- (void)setIsTransparent:(BOOL)isTransparent
{
    if (isTransparent)
    {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        self.backgroundView = [UIView new];
    }
    _isTransparent = isTransparent;
}

- (void)setSelectionColor:(UIColor*)selectionColor
{
    _selectionColor = selectionColor;
    UIView* selection = [UIView new];
    selection.backgroundColor = selectionColor;
    self.selectedBackgroundView = selection;
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
}

@end
