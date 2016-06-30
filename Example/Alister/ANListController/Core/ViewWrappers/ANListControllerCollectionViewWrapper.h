//
//  ANListControllerCollectionViewWrapper.h
//  ANStorage
//
//  Created by Oksana Kovalchuk on 2/2/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "ANListControllerWrapperInterface.h"

@protocol ANListControllerCollectionViewWrapperDelegate <NSObject>

- (UICollectionView*)collectionView;

@end

@interface ANListControllerCollectionViewWrapper : NSObject <ANListControllerWrapperInterface>

@property (nonatomic, weak) id<ANListControllerCollectionViewWrapperDelegate> delegate;

+ (instancetype)wrapperWithDelegate:(id<ANListControllerCollectionViewWrapperDelegate>)delegate;

@end
