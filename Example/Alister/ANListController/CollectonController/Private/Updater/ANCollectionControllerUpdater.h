//
//  ANCollectionControllerUpdateManager.h
//  ANStorage
//
//  Created by Oksana Kovalchuk on 2/3/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "ANListControllerQueueProcessor.h"

@protocol ANCollectionControllerUpdaterDelegate <ANListControllerQueueProcessorDelegate>

- (UICollectionView*)collectionView;

@end

@interface ANCollectionControllerUpdater : ANListControllerQueueProcessor

@property (nonatomic, weak) id<ANCollectionControllerUpdaterDelegate> delegate;

@end
