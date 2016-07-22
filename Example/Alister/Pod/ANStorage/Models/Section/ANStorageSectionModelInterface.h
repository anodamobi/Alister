//
//  ANStorageSectionModelInterface.h
//  Pods
//
//  Created by Oksana Kovalchuk on 1/28/16.
//
//

@protocol ANStorageSectionModelInterface <NSObject>

- (NSUInteger)numberOfObjects;
- (NSArray*)objects;

- (id)supplementaryModelOfKind:(NSString*)kind;
- (void)updateSupplementaryModel:(id)model forKind:(NSString*)kind;

@end
