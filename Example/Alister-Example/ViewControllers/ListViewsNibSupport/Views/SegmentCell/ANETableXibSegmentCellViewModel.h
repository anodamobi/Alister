//
//  ANETableXibSegmentCellViewModel.h
//  Alister-Example
//
//  Created by ANODA on 2/15/17.
//  Copyright © 2017 Oksana Kovalchuk. All rights reserved.
//

@class ANETableXibSegmentCellViewModel;

@protocol ANETableXibSegmentCellViewModelDelegate <NSObject>

- (void)switchCell:(ANETableXibSegmentCellViewModel*)cell segmentStateChangedTo

@end

@interface ANETableXibSegmentCellViewModel : NSObject

@end
