//
//  ANListControllerMappingServiceFixture.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 11/11/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANListControllerMappingServiceFixture.h"

@implementation ANListControllerMappingServiceFixture

- (NSString*)registerViewModelClass:(Class)viewModelClass
{
    self.lastMappingClass = viewModelClass;
    self.lastIdentifier = [ANTestHelper randomString];
    self.wasAskedForRegister = YES;
    
    return self.lastIdentifier;
}

- (NSString*)registerViewModelClass:(Class)viewModelClass kind:(NSString*)kind
{
    self.lastMappingClass = viewModelClass;
    self.lastIdentifier = [ANTestHelper randomString];
    self.lastKind = kind;
    self.wasAskedForRegister = YES;
    return self.lastIdentifier;
}

- (NSString*)identifierForViewModelClass:(Class)keyClass
{
    self.lastMappingClass = keyClass;
    self.lastIdentifier = [ANTestHelper randomString];
    return self.lastIdentifier;
}

- (NSString*)identifierForViewModelClass:(Class)viewModelClass kind:(NSString*)kind
{
    self.lastMappingClass = viewModelClass;
    self.lastIdentifier = [ANTestHelper randomString];
    self.lastKind = kind;
    return self.lastIdentifier;
}

@end
