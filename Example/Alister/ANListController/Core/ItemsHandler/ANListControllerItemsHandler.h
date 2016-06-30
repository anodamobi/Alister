//
//  ANListItemsBuilder.h
//  ANStorage
//
//  Created by Oksana Kovalchuk on 2/2/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "ANListControllerWrapperInterface.h"
#import "ANListControllerReusableInterface.h"
#import "ANListControllerReusableLoadInterface.h"
#import "ANListControllerConfigurationModelInterface.h"

@protocol ANListControllerItemsHandlerDelegate

- (id<ANListControllerWrapperInterface>)listViewWrapper;
- (id<ANListControllerConfigurationModelInterface>)configurationModel;

@end

@interface ANListControllerItemsHandler : NSObject
<
    ANListControllerReusableInterface,
    ANListControllerReusableLoadInterface
>

+ (instancetype)handlerWithDelegate:(id<ANListControllerItemsHandlerDelegate>)delegate;

@end
