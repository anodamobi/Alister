//
//  ANStorageMovedIndexPathModelTest.m
//  Alister-Example
//
//  Created by ANODA on 8/29/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <Alister/ANStorageMovedIndexPathModel.h>

SpecBegin(ANStorageMovedIndexPathModel)

__block ANStorageMovedIndexPathModel* model = nil;

beforeEach(^{
    model = [ANStorageMovedIndexPathModel new];
});

describe(@"default value", ^{
   
    it(@"from and to indexPaths are nil", ^{
        expect(model.toIndexPath).beNil();
        expect(model.fromIndexPath).beNil();
    });
});

SpecEnd
