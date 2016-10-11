//
//  ANStorageUpdateModel.h
//  Pods
//
//  Created by Oksana Kovalchuk on 1/28/16.
//
//

#import "ANStorageUpdateModelInterface.h"
#import "ANStorageMovedIndexPathModel.h"
#import "ANBaseDomainModel.h" // TODO: temp for debug

@interface ANStorageUpdateModel : ANBaseDomainModel <ANStorageUpdateModelInterface>

@property (nonatomic, assign) BOOL isRequireReload;

- (BOOL)isEmpty;
- (void)mergeWith:(id<ANStorageUpdateModelInterface>)model;

@end
