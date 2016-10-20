//
//  ANBaseTableHeaderFooterView.m
//
//  Created by Oksana Kovalchuk on 4/11/14.
//  Copyright (c) 2014 ANODA. All rights reserved.
//

#import "ANBaseTableHeaderView.h"

@implementation ANBaseTableHeaderView

- (void)updateWithModel:(NSString*)model
{
    if ([model isKindOfClass:[NSString class]])
    {
        self.titleLabel.text = [model uppercaseString];
    }
}

@end
