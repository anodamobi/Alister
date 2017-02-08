//
//  ANListControllerReusableInterface.h
//  ANStorage
//
//  Created by Oksana Kovalchuk on 2/2/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

@protocol ANListControllerReusableInterface <NSObject>

- (void)registerFooterClass:(Class)viewClass forModelClass:(Class)modelClass;
- (void)registerHeaderClass:(Class)viewClass forModelClass:(Class)modelClass;
- (void)registerCellClass:(Class)cellClass forModelClass:(Class)modelClass;


#pragma mark - UICollectionView

- (void)registerSupplementaryClass:(Class)supplementaryClass forModelClass:(Class)modelClass kind:(NSString*)kind;

@end
