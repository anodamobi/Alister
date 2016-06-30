//
//  ANListControllerReusableInterface.h
//  ANStorage
//
//  Created by Oksana Kovalchuk on 2/2/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

@protocol ANListControllerReusableInterface <NSObject>


#pragma mark - Common methods
#pragma mark - Custom ViewModel Class Registration

- (void)registerFooterClass:(Class)viewClass forModelClass:(Class)modelClass;
- (void)registerHeaderClass:(Class)viewClass forModelClass:(Class)modelClass;
- (void)registerCellClass:(Class)cellClass forModelClass:(Class)modelClass;


#pragma mark - System ViewModel Class Registration

- (void)registerFooterClass:(Class)viewClass forSystemClass:(Class)modelClass;
- (void)registerHeaderClass:(Class)viewClass forSystemClass:(Class)modelClass;
- (void)registerCellClass:(Class)cellClass forSystemClass:(Class)modelClass;


#pragma mark - UICollectionView

- (void)registerSupplementaryClass:(Class)supplementaryClass forModelClass:(Class)modelClass kind:(NSString*)kind;
- (void)registerSupplementaryClass:(Class)supplementaryClass forSystemClass:(Class)modelClass kind:(NSString*)kind;

@end