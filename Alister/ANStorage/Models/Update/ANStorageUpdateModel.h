//
//  ANStorageUpdateModel.h
//  Pods
//
//  Created by Oksana Kovalchuk on 1/28/16.
//
//

#import "ANStorageUpdateModelInterface.h"
#import "ANStorageMovedIndexPathModel.h"

/**
 Private class represents any update transaction related to ANStorageModel.
 Never should be used directly.
 */
@interface ANStorageUpdateModel : NSObject <ANStorageUpdateModelInterface>


/**
 Indicates does storage should reload related TableView or CollectionView or try to execute update
 */
@property (nonatomic, assign) BOOL isRequireReload;


/**
 Indicates does current model contain any changes

 @return BOOL state
 */
- (BOOL)isEmpty;


/**
 Merges one updateModel with another. 
 Object that was executor for this operation will get all updates from another model.

 @param model model to merge all updates with
 */
- (void)mergeWith:(id<ANStorageUpdateModelInterface>  _Nonnull)model;

@end
