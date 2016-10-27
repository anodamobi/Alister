//
//  ANListMappingModel.h
//  ANStorage
//
//  Created by Oksana Kovalchuk on 2/2/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

@interface ANListControllerMappingModel : NSObject

@property (nonatomic, strong, readonly) Class mappingClass;
@property (nonatomic, assign, readonly) BOOL isSystem;
@property (nonatomic, copy, readonly) NSString* reuseIdentifier;
@property (nonatomic, copy, readonly) NSString* kind;

+ (instancetype)modelWithMappingClass:(Class)mappingClass
                                 kind:(NSString*)kind
                             isSystem:(BOOL)isSystem
                      classIdentifier:(NSString*)classIdentifier;

- (instancetype)initWithMappingClass:(Class)mappingClass
                                kind:(NSString*)kind
                            isSystem:(BOOL)isSystem
                     classIdentifier:(NSString*)classIdentifier;

@end
