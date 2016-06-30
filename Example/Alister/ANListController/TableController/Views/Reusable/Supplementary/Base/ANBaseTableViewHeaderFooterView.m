//
//  ANTableViewHeaderFooterView.m
//
//  Created by Oksana Kovalchuk on 29/10/14.
//  Copyright (c) 2014 ANODA. All rights reserved.
//

#import "ANBaseTableViewHeaderFooterView.h"

@implementation ANBaseTableViewHeaderFooterView

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
        self.backgroundView = [UIView new];
    }
    _isTransparent = isTransparent;
}

@end
