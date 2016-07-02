//
//  ANTestTableCellTableViewCell.m
//  Alister
//
//  Created by Oksana Kovalchuk on 7/2/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANTestTableCell.h"

@implementation ANTestTableCell

- (void)updateWithModel:(id)model
{
    self.model = model;
    self.textLabel.text = [NSString stringWithFormat:@"%@", model ? : @""];
}

@end
