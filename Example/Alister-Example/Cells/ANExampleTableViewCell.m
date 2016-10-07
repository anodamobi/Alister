//
//  ANExampleTableViewCell.m
//  Alister
//
//  Created by Oksana Kovalchuk on 7/1/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANExampleTableViewCell.h"

@implementation ANExampleTableViewCell

- (void)updateWithModel:(NSString*)model
{
    self.textLabel.text = model;
}

@end
