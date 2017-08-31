//
//  ANStorageSectionModel.h
//  Pods
//
//  Created by Oksana Kovalchuk on 1/28/16.
//
//

#import "ANStorageSectionModelInterface.h"

NS_ASSUME_NONNULL_BEGIN

/**
 Private class to store section objects in memory.
 You should not call this call directly.
 */
@interface ANStorageSectionModel : NSObject <ANStorageSectionModelInterface>


/**
 Array of all objects in this section
 */
@property (nonatomic, strong, readonly) NSArray* objects;


/**
 Dictionary with supplementaries (headers, footers) models and kinds
 */
@property (nonatomic, strong, readonly) NSDictionary* supplementaryObjects;


/**
 Adds new item in the end of objects array

 @param item to add. If item will be nil no expection will be generated.
 */
- (void)addItem:(id)item;


/**
 Inserts item at the specified index. If index is out of bounds or item is nil operation will skipped.

 @param item  item to add in storage
 @param index for item in the existing objects array
 */
- (void)insertItem:(id)item atIndex:(NSInteger)index;


/**
 Removes item at specified index. If section not exist n

 @param index section index to remove
 */
- (void)removeItemAtIndex:(NSInteger)index;


/**
 Replaces item at specified index on a new item. 
 If item at specified index not esists or new item is nil operation will be skipped.

 @param index index for item to replace
 @param item  new item to insert
 */
- (void)replaceItemAtIndex:(NSInteger)index withItem:(id)item;

- (void)replaceSupplementaryKind:(NSString*)kind onKind:(NSString*)newKind;

@end

NS_ASSUME_NONNULL_END
