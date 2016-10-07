//
//  ANECustomHeaderViewModel.h
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 10/7/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

@class ANECustomHeaderViewModel;

@protocol ANECustomHeaderViewModelDelegate <NSObject>

- (void)headerViewModelIndexUpdatedTo:(NSUInteger)index onModel:(ANECustomHeaderViewModel*)model;

@end

@interface ANECustomHeaderViewModel : NSObject

@property (nonatomic, weak) id<ANECustomHeaderViewModelDelegate> delegate;

+ (instancetype)viewModelWithSegmentTitles:(NSArray*)segmentTitles;

- (void)itemSelectedWithIndex:(NSUInteger)index;
- (NSArray*)segmentTitles;

@end
