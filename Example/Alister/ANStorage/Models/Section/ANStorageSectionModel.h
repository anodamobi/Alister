//
//  ANStorageSectionModel.h
//  Pods
//
//  Created by Oksana Kovalchuk on 1/28/16.
//
//

#import "ANStorageSectionModelInterface.h"

@interface ANStorageSectionModel : NSObject <ANStorageSectionModelInterface>

@property (nonatomic, strong, readonly) NSArray* objects;
@property (nonatomic, strong, readonly) NSDictionary* supplementaryObjects;

- (void)addItem:(id)item;
- (void)insertItem:(id)item atIndex:(NSUInteger)index;
- (void)removeItemAtIndex:(NSUInteger)index;
- (void)replaceItemAtIndex:(NSUInteger)index withItem:(id)item;

@end
