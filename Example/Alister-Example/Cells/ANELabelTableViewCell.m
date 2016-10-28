//
//  ANExampleTableViewCell.m
//  Alister
//
//  Created by Oksana Kovalchuk on 7/1/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANELabelTableViewCell.h"

@implementation ANELabelTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.textLabel.numberOfLines = 0;
    }
    
    return self;
}

- (void)updateWithModel:(NSString*)model
{
    self.textLabel.text = model;
}

@end
