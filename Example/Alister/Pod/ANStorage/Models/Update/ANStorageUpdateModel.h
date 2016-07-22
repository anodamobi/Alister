//
//  ANStorageUpdateModel.h
//  Pods
//
//  Created by Oksana Kovalchuk on 1/28/16.
//
//

#import "ANStorageUpdateModelInterface.h"
#import "ANStorageMovedIndexPathModel.h"

@interface ANStorageUpdateModel : NSObject <ANStorageUpdateModelInterface>

@property (nonatomic, assign) BOOL isRequireReload;

- (BOOL)isEmpty;
- (void)mergeWith:(id<ANStorageUpdateModelInterface>)model;

@end
