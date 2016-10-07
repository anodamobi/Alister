//
//  ANBaseTableFooterView.m
//
//  Created by Oksana Kovalchuk on 5/11/14.
//  Copyright (c) 2014 ANODA. All rights reserved.
//

#import "ANBaseTableFooterView.h"

@implementation ANBaseTableFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.textLabel.numberOfLines = 0;
    }
    return self;
}

- (void)updateWithModel:(id)model
{
    if ([model isKindOfClass:[NSString class]])
    {
        self.textLabel.text = NSLocalizedString(model, nil);
    }
}

@end
