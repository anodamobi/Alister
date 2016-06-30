//
//  ANCollectionControllerUpdateManager.h
//  ANStorage
//
//  Created by Oksana Kovalchuk on 2/3/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "ANStorageUpdatingInterface.h"

@class ANCollectionControllerConfigurationModel;

@protocol ANCollectionControllerUpdaterDelegate <NSObject>

- (ANCollectionControllerConfigurationModel*)configurationModel;
- (UICollectionView*)collectionView;

@end

@interface ANCollectionControllerUpdater : NSObject <ANStorageUpdatingInterface>

@property (nonatomic, weak) id<ANCollectionControllerUpdaterDelegate> delegate;

@end
