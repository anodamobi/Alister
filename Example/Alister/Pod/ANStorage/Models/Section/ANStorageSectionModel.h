//
//  ANStorageSectionModel.h
//  Pods
//
//  Created by Oksana Kovalchuk on 1/28/16.
//
//

#import "ANStorageSectionModelInterface.h"

@interface ANStorageSectionModel : NSObject <ANStorageSectionModelInterface>

@property (nonatomic, strong, readonly, nonnull) NSArray* objects;
@property (nonatomic, strong, readonly, nonnull) NSDictionary* supplementaryObjects;

- (void)addItem:(_Nonnull id)item;
- (void)insertItem:(_Nonnull id)item atIndex:(NSUInteger)index;
- (void)removeItemAtIndex:(NSUInteger)index;
- (void)replaceItemAtIndex:(NSUInteger)index withItem:(_Nonnull id)item;

@end
