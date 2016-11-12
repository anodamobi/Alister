//
//  ANListControllerMappingServiceFixture.h
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 11/11/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANListControllerMappingServiceInterface.h"

@interface ANListControllerMappingServiceFixture : NSObject <ANListControllerMappingServiceInterface>

@property (nonatomic, strong) Class lastMappingClass;

@property (nonatomic, assign) BOOL wasAskedForRegister;

@property (nonatomic, assign) BOOL wasAskedForRetrive;

@property (nonatomic, strong) NSString* lastKind;
@property (nonatomic, strong) NSString* lastIdentifier;

@end
