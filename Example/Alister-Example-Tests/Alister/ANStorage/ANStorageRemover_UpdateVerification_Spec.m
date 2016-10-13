//
//  ANStorageRemover_UpdateVerification_Spec.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 10/12/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <Alister/ANStorageUpdater.h>
#import <Alister/ANStorageModel.h>
#import <Alister/ANStorageUpdateModel.h>
#import <Alister/ANStorageRemover.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"

SpecBegin(ANStorageRemover_UpdateVerification_Spec)

__block ANStorageModel* storage = nil;

beforeEach(^{
    storage = [ANStorageModel new];
});



SpecEnd

#pragma clang diagnostic pop
