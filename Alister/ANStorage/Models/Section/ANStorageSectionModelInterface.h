//
//  ANStorageSectionModelInterface.h
//  Pods
//
//  Created by Oksana Kovalchuk on 1/28/16.
//
//


NS_ASSUME_NONNULL_BEGIN

/**
 Public ANStorageSectionModel interface methods
 */
@protocol ANStorageSectionModelInterface <NSObject>


/**
 Returns number of objects in current section

 @return number of objects
 */
- (NSInteger)numberOfObjects;


/**
 Returns all section objects

 @return NSArray* of all objects in this section
 */
- (NSArray*)objects;


/**
 Returns supplementaty (header / footer) model for the

 @param kind NSString* 

 @return model for the specified kind
 */
- (id)supplementaryModelOfKind:(NSString*)kind;


/**
 Updates supplementary model for the specified kind. If kind is nil it will remove model.

 @param model model to set for the specified kind
 @param kind  aslias for model
 */
- (void)updateSupplementaryModel:(id)model forKind:(NSString*)kind;

@end

NS_ASSUME_NONNULL_END
