//
//  ANListItemsBuilder.h
//  ANStorage
//
//  Created by Oksana Kovalchuk on 2/2/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "ANListControllerReusableInterface.h"

@protocol ANListViewInterface;
@protocol ANListControllerMappingServiceInterface;
@protocol ANListControllerUpdateViewInterface;

@interface ANListControllerItemsHandler : NSObject <ANListControllerReusableInterface>

NS_ASSUME_NONNULL_BEGIN

- (instancetype)initWithListView:(id<ANListViewInterface>)listView
                  mappingService:(nullable id<ANListControllerMappingServiceInterface>)mappingService;

- (nullable id<ANListControllerUpdateViewInterface>)cellForModel:(id)viewModel atIndexPath:(NSIndexPath*)indexPath;

- (nullable id<ANListControllerUpdateViewInterface>)supplementaryViewForModel:(id)viewModel
                                                                kind:(NSString*)kind
                                                        forIndexPath:(NSIndexPath*)indexPath;
NS_ASSUME_NONNULL_END

@end
