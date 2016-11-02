//
//  ANListItemsBuilder.h
//  ANStorage
//
//  Created by Oksana Kovalchuk on 2/2/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "ANListControllerWrapperInterface.h"
#import "ANListControllerReusableInterface.h"
#import "ANListControllerConfigurationModelInterface.h"

@class ANListControllerMappingService;

@protocol ANListControllerItemsHandlerDelegate

- (id<ANListControllerWrapperInterface>)listViewWrapper;
- (id<ANListControllerConfigurationModelInterface>)configurationModel;

@end

@interface ANListControllerItemsHandler : NSObject
<
    ANListControllerReusableInterface
>

@property (nonatomic, weak) id<ANListControllerItemsHandlerDelegate> delegate;

- (instancetype)initWithMappingService:(ANListControllerMappingService*)mappingService;

- (id<ANListControllerUpdateViewInterface>)cellForModel:(id)viewModel atIndexPath:(NSIndexPath*)indexPath;

- (id<ANListControllerUpdateViewInterface>)supplementaryViewForModel:(id)viewModel
                                                                kind:(NSString*)kind
                                                        forIndexPath:(NSIndexPath*)indexPath;
@end
