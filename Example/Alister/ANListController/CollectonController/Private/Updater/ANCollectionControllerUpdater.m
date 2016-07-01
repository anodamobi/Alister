//
//  ANCollectionControllerUpdateManager.m
//  ANStorage
//
//  Created by Oksana Kovalchuk on 2/3/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "ANCollectionControllerUpdater.h"
#import "ANStorageUpdateOperation.h"
#import "ANCollectionControllerUpdateOperation.h"
#import "ANCollectionControllerConfigurationModel.h"
#import "ANCollectionControllerReloadOperation.h"

@interface ANCollectionControllerUpdater ()
<
    ANCollectionControllerUpdateOperationDelegate,
    ANCollectionControllerReloadOperationDelegate
>

@end

@implementation ANCollectionControllerUpdater

@synthesize delegate = _delegate;

- (UICollectionView*)collectionView
{
    return [self.delegate collectionView];
}

@end
