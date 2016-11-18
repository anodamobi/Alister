//
//  ANEXibCell.m
//  Alister-Example
//
//  Created by ANODA on 11/18/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANEXibCell.h"

@implementation ANEXibCell

- (void)updateWithModel:(ANEXibCellViewModel*)model
{
    self.titleLabel.text = model.username;
    self.switchControl.on = model.activeState;
}

@end
