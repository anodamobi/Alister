//
//  ANCollectionControllerManager.h
//  ANStorage
//
//  Created by Oksana Kovalchuk on 2/3/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "ANStorageUpdatingInterface.h"
#import "ANListControllerWrapperInterface.h"
#import "ANListControllerManagerInterface.h"

@class ANStorage;
@class ANCollectionControllerConfigurationModel;

@protocol ANCollectionControllerManagerDelegate <NSObject>

- (ANStorage*)currentStorage;
- (id<ANListControllerWrapperInterface>)listViewWrapper;
- (UICollectionView*)collectionView;
- (void)allUpdatesWereFinished;

@end

@interface ANCollectionControllerManager : NSObject <ANListControllerManagerInterface>

@property (nonatomic, weak) id<ANCollectionControllerManagerDelegate> delegate;

//- (UICollectionViewCell*)cellForModel:(id)model atIndexPath:(NSIndexPath*)indexPath;
//- (UICollectionReusableView*)supplementaryViewForIndexPath:(NSIndexPath*)indexPath kind:(NSString*)kind;
//
//- (CGSize)referenceSizeForHeaderInSection:(NSUInteger)sectionIndex withLayout:(UICollectionViewFlowLayout*)layout;
//- (CGSize)referenceSizeForFooterInSection:(NSUInteger)sectionIndex withLayout:(UICollectionViewFlowLayout*)layout;

@end
