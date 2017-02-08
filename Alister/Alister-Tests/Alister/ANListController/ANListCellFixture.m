//
//  ANListCellFixture.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 11/14/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANListCellFixture.h"

@implementation ANListCellFixture

- (void)updateWithModel:(id)model
{
    self.wasUpdateCalled = YES;
}

@end
