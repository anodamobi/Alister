//
//  ANETableXibSegmentCell.m
//  Alister-Example
//
//  Created by ANODA on 2/15/17.
//  Copyright © 2017 Oksana Kovalchuk. All rights reserved.
//

#import "ANETableXibSegmentCell.h"

@interface ANETableXibSegmentCell ()

@property (weak, nonatomic) IBOutlet UISegmentedControl* segmentControl;
@property (nonatomic, strong) ANETableXibSegmentCellViewModel* model;

@end

@implementation ANETableXibSegmentCell

- (void)updateWithModel:(ANETableXibSegmentCellViewModel*)model
{
    self.model = model;
    self.segmentControl.selectedSegmentIndex = model.type;
}

- (IBAction)segmentStateChanged:(UISegmentedControl*)sender
{
    [self.model segmentStateChanged:(ANESegmentState)sender.selectedSegmentIndex];
}

@end
