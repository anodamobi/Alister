//
//  ANListMappingModel.h
//  ANStorage
//
//  Created by Oksana Kovalchuk on 2/2/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

@interface ANListControllerMappingModel : NSObject

@property (nonatomic, copy) NSString* classIdentifier;
@property (nonatomic, copy) NSString* kind;
@property (nonatomic, strong) Class mappingClass;
@property (nonatomic, assign) BOOL isSystem;

@end
