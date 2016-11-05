//
//  ANListControllerItemsHandlerSpec.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 10/28/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANListControllerItemsHandler.h"

SpecBegin(ANListControllerItemsHandler)

__block ANListControllerItemsHandler* handler = nil;

beforeEach(^{
    handler = [[ANListControllerItemsHandler alloc] initWithMappingService:nil];
});


describe(@"registerFooterClass: forModelClass:", ^{
    
});


SpecEnd


//- (void)registerFooterClass:(Class)viewClass forModelClass:(Class)modelClass;
//- (void)registerHeaderClass:(Class)viewClass forModelClass:(Class)modelClass;
//- (void)registerCellClass:(Class)cellClass forModelClass:(Class)modelClass;
//
//
//#pragma mark - UICollectionView
//
//- (void)registerSupplementaryClass:(Class)supplementaryClass forModelClass:(Class)modelClass kind:(NSString*)kind;

//- (id<ANListControllerUpdateViewInterface>)cellForModel:(id)viewModel atIndexPath:(NSIndexPath*)indexPath;
//
//- (id<ANListControllerUpdateViewInterface>)supplementaryViewForModel:(id)viewModel
//kind:(NSString*)kind
//forIndexPath:(NSIndexPath*)indexPath;
