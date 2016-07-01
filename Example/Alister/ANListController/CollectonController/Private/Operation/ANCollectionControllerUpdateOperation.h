//
//  ANCollectionControllerUpdateOperation.h
//  ANStorage
//
//  Created by Oksana Kovalchuk on 2/3/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "ANStorageListUpdateOperationInterface.h"

@class ANCollectionControllerConfigurationModel;

@protocol ANCollectionControllerUpdateOperationDelegate <NSObject>

- (UICollectionView*)collectionView;
- (ANCollectionControllerConfigurationModel*)configurationModel;

@end

@interface ANCollectionControllerUpdateOperation : NSOperation <ANStorageListUpdateOperationInterface>

@property (nonatomic, weak) id<ANCollectionControllerUpdateOperationDelegate> delegate;

@end
