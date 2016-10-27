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

//- (NSString*)registerIdentifierForViewModel:(Class)viewModelClass;
- (NSString*)registerIdentifierForViewModel:(Class)viewModelClass kind:(NSString*)kind;

- (NSString*)identifierForViewModel:(Class)viewModelClass;
- (NSString*)identifierForViewModel:(Class)viewModelClass kind:(NSString*)kind;



//- (NSString*)registerCellClass:(Class)cellClass forViewModelClass:(Class)viewModeClass;
//- (NSString*)registerSupplementaryClass:(Class)supplClass forViewModelClass:(Class)viewModel kind:(NSString*)kind;
//
//- (Class)reuseIndentifierForViewModelClass:(Class)viewModelClass;
//- (Class)reuseIndentifierForViewModelClass:(Class)viewModelClass kind:(NSString*)kind;
//



- (ANListControllerMappingModel*)mappingForViewModelClass:(Class)viewModelClass
                                                     kind:(NSString*)kind
                                                 isSystem:(BOOL)isSystem;

- (ANListControllerMappingModel*)cellMappingForViewModelClass:(Class)viewModelClass isSystem:(BOOL)isSystem;

- (void)addMapping:(ANListControllerMappingModel*)model;;

- (ANListControllerMappingModel*)findCellMappingForViewModel:(id)viewModel;
- (ANListControllerMappingModel*)findSupplementaryMappingForViewModel:(id)viewModel kind:(NSString*)kind;

NS_ASSUME_NONNULL_END

@end
