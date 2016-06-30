//
//  ANStorage.h
//  Pods
//
//  Created by Oksana Kovalchuk on 1/28/16.
//
//

#import "ANStorageUpdatableInterface.h"
#import "ANStorageUpdatingInterface.h"
#import "ANStorageRetrivingInterface.h"
#import "ANStorageSectionModel.h"

typedef void(^ANDataStorageUpdateBlock)(id<ANStorageUpdatableInterface> storageController);
typedef NSPredicate*(^ANStorageSearchPredicate)(NSString* searchString, NSInteger scope);

@interface ANStorage : NSObject <ANStorageRetrivingInterface>

@property (nonatomic, weak) id<ANStorageUpdatingInterface> listController;
@property (nonatomic, copy) ANStorageSearchPredicate storagePredicateBlock;

@property (nonatomic, strong, readonly) NSString* identifier;

- (void)updateWithBlock:(ANDataStorageUpdateBlock)block;
- (void)updateWithoutAnimationWithBlock:(ANDataStorageUpdateBlock)block;

- (instancetype)searchingStorageForSearchString:(NSString*)searchString
                                  inSearchScope:(NSInteger)searchScope;


- (void)reloadStorageWithAnimation:(BOOL)isAnimatable;

+ (instancetype)customStorage;

@end
