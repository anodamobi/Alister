//
//  Header.h
//  Pods
//
//  Created by Oksana Kovalchuk on 11/1/16.
//
//

@protocol ANListControllerMappingServiceInterface <NSObject>

NS_ASSUME_NONNULL_BEGIN

- (NSString*)registerViewModelClass:(Class)viewModelClass;
- (NSString*)registerViewModelClass:(Class)viewModelClass kind:(NSString*)kind;
- (NSString*)registerViewModelClass:(Class)viewModelClass
                               kind:(NSString*)kind
                        withNibName:(NSString*)nibName
                           inBundle:(NSBundle*)bundle;

- (NSString*)identifierForViewModelClass:(Class)keyClass;
- (NSString*)identifierForViewModelClass:(Class)viewModelClass kind:(NSString*)kind;

NS_ASSUME_NONNULL_END

@end
