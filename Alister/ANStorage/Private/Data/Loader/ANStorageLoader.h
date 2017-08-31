//
//  ANStorageLoader.h
//  Pods
//
//  Created by Oksana Kovalchuk on 1/28/16.
//
//

@class ANStorageModel;
@class ANStorageSectionModel;

/**
 
 This is a private class. You shouldn't use it directly in your code.
 ANStorageLoader returns necessary items such as view models and their NSIndexPath.
 Also it handles all possible invalid arguments situations like nil values,
 or NSNotFound indexes to avoid crash and freezes.
 
 */

@interface ANStorageLoader : NSObject

/**
 Searches index path in specified storage and returns view model.
 
 @param indexPath       NSIndexPath for list view
 @param storage         for searching
 */
+ (id)itemAtIndexPath:(NSIndexPath*)indexPath inStorage:(ANStorageModel*)storage;


/**
 Searches model in specified storage and returns index path.
 
 !!! or !!!
 Returns index path by specified view model in specified storage
 Returns index path by specified view model and searches it in specified storage
 
 @param item            in storage
 @param storage         for searching
 
 @return index path for view model
 */
+ (NSIndexPath*)indexPathForItem:(id)item inStorage:(ANStorageModel*)storage;


/**
 Returns array of view models by specified section index in storage.
 
 @param sectionIndex    for section to return
 @param storage         for searching
 
 @return view models by specified section
 */
+ (NSArray*)itemsInSection:(NSInteger)sectionIndex inStorage:(ANStorageModel*)storage;


/**
 Returns array of index paths by specified view models in storage
 
 @param items           in storage
 @param storage         for searching
 
 @return array of index paths by specified view models
 */
+ (NSArray*)indexPathArrayForItems:(NSArray*)items inStorage:(ANStorageModel*)storage;


/**
 Returns section model by specified section index in storage
 
 @param sectionIndex    in storage
 @param storage         for searching
 
 @return storage model by specified section index
 */
+ (ANStorageSectionModel*)sectionAtIndex:(NSInteger)sectionIndex inStorage:(ANStorageModel*)storage;


/**
 Returns supplemetary model for specified section and with specified kind
 
 @param kind            for model
 @param sectionIndex    for section to return
 
 @return viewModel with specified kind
 */

+ (id)supplementaryModelOfKind:(NSString*)kind forSectionIndex:(NSInteger)sectionIndex inStorage:(ANStorageModel*)storage;

@end
