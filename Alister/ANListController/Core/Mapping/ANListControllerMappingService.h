//
//  ANListControllerMappingService.h
//  ANStorage
//
//  Created by Oksana Kovalchuk on 2/2/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "ANListControllerMappingModel.h"

@interface ANListControllerMappingService : NSObject

NS_ASSUME_NONNULL_BEGIN

- (NSString*)identifierForViewModelClass:(Class)keyClass;
- (NSString*)identifierForViewModelClass:(Class)viewModelClass kind:(NSString*)kind;



- (ANListControllerMappingModel*)mappingForViewModelClass:(Class)viewModelClass
                                                     kind:(NSString*)kind
                                                 isSystem:(BOOL)isSystem;

- (ANListControllerMappingModel*)cellMappingForViewModelClass:(Class)viewModelClass isSystem:(BOOL)isSystem;

- (void)addMapping:(ANListControllerMappingModel*)model;;

- (ANListControllerMappingModel*)findCellMappingForViewModel:(id)viewModel;
- (ANListControllerMappingModel*)findSupplementaryMappingForViewModel:(id)viewModel kind:(NSString*)kind;

NS_ASSUME_NONNULL_END

@end
