//
//  ANStorageMovedIndexPathModelTest.m
//  Alister-Example
//
//  Created by ANODA on 8/29/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANStorageMovedIndexPathModel.h"

@interface ANTestMovedIndexPath : ANStorageMovedIndexPathModel

@end

@implementation ANTestMovedIndexPath

@end


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
    
    it(@"has debug description", ^{
        expect([model debugDescription]).notTo.beNil();
    });
});


describe(@"modelWithFromIndexPath: toIndexPath:", ^{
    
    it(@"properties are not empty after init", ^{
        model = [ANTestMovedIndexPath modelWithFromIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                                                 toIndexPath:[NSIndexPath indexPathForRow:12 inSection:12]];
        expect(model.fromIndexPath).notTo.beNil();
        expect(model.toIndexPath).notTo.beNil();
    });
    
    it(@"created object is not nil", ^{
        id createdModel = [ANTestMovedIndexPath modelWithFromIndexPath:kANTestNil toIndexPath:kANTestNil];
        expect(createdModel).notTo.beNil();
    });
    
    it(@"inherited model is the same class", ^{
        id createdModel = [ANTestMovedIndexPath modelWithFromIndexPath:kANTestNil toIndexPath:kANTestNil];
        expect(createdModel).beMemberOf([ANTestMovedIndexPath class]);
    });
});

SpecEnd
