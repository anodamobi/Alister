//
//  ANETableXibSwitchCell.m
//  Alister-Example
//
//  Created by ANODA on 2/15/17.
//  Copyright © 2017 Oksana Kovalchuk. All rights reserved.
//

#import "ANETableXibSwitchCell.h"

@interface ANETableXibSwitchCell ()

@property (weak, nonatomic) IBOutlet UISwitch* switchControl;
@property (nonatomic, strong) ANETableXibSwitchCellViewModel* model;

@end

@implementation ANETableXibSwitchCell

- (void)updateWithModel:(ANETableXibSwitchCellViewModel*)model
{
    self.model = model;
    
    BOOL switchActiveState = self.switchControl.isOn;
    [self.switchControl setOn:model.type animated:YES];
}

- (IBAction)switchStateChanged:(UISwitch*)sender
{
    [self.model switchStateChangedTo:(ANESegmentState)sender.isOn];
}

@end
