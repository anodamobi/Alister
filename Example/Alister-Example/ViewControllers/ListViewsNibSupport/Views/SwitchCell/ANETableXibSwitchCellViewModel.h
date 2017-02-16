//
//  ANETableXibSwitchCellViewModel.h
//  Alister-Example
//
//  Created by ANODA on 2/15/17.
//  Copyright © 2017 Oksana Kovalchuk. All rights reserved.
//

@class ANETableXibSwitchCellViewModel;

@protocol ANETableXibSwitchCellViewModelDelegate <NSObject>

- (void)switchModel:(ANETableXibSwitchCellViewModel*)model switchStateChangeTo:(ANESegmentState)type;

@end

@interface ANETableXibSwitchCellViewModel : NSObject

@property (nonatomic, weak) id <ANETableXibSwitchCellViewModelDelegate> delegate;

- (void)updateWithSegmentState:(ANESegmentState)type;
- (ANESegmentState)type;

- (void)switchStateChangedTo:(ANESegmentState)type;

@end
