//
//  ANListControllerMappingService.h
//  ANStorage
//
//  Created by Oksana Kovalchuk on 2/2/16.
//  Copyright © 2016 ANODA. All rights reserved.
//


@interface ANListControllerMappingService : NSObject

NS_ASSUME_NONNULL_BEGIN

- (NSString*)identifierForViewModelClass:(Class)keyClass;
- (NSString*)identifierForViewModelClass:(Class)viewModelClass kind:(NSString*)kind;

NS_ASSUME_NONNULL_END

@end
