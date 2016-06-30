//
//  ANCollectionControllerReloadOperation.h
//  ANODA
//
//  Created by Oksana Kovalchuk on 3/4/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

@class ANListControllerConfigurationModel;

@protocol ANCollectionControllerReloadOperationDelegate <NSObject>

- (UICollectionView*)collectionView;
- (ANListControllerConfigurationModel*)configurationModel;

@end

@interface ANCollectionControllerReloadOperation : NSOperation

@property (nonatomic, weak) id<ANCollectionControllerReloadOperationDelegate> delegate;

+ (instancetype)reloadOperationWithAnimation:(BOOL)shouldAnimate;

@end

