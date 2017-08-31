//
//  ANETableXibSegmentCellViewModel.h
//  Alister-Example
//
//  Created by ANODA on 2/15/17.
//  Copyright © 2017 Oksana Kovalchuk. All rights reserved.
//

@class ANETableXibSegmentCellViewModel;

@protocol ANETableXibSegmentCellViewModelDelegate <NSObject>

- (void)segmentModel:(ANETableXibSegmentCellViewModel*)cell segmentStateChangedTo:(ANESegmentState)type;

@end

@interface ANETableXibSegmentCellViewModel : NSObject

@property (nonatomic, weak) id <ANETableXibSegmentCellViewModelDelegate> delegate;

- (void)updateWithSegmentState:(ANESegmentState)type;
- (ANESegmentState)type;

- (void)segmentStateChanged:(ANESegmentState)type;

@end
