//
//  ANECollectionCustomSupplementaryVCTest.m
//  Alister-Example
//
//  Created by ANODA on 11/20/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANECollectionCustomSupplementaryVC.h"
#import "ANECollectionCustomSupplementaryController.h"
#import "ANStorage.h"

@interface ANECollectionCustomSupplementaryVC ()

@property (nonatomic, strong) ANStorage* storage;
@property (nonatomic, strong) ANECollectionCustomSupplementaryController* controller;
@property (nonatomic, strong) UICollectionView* collectionView;

@end

SpecBegin(ANECollectionCustomSupplementaryVC)

__block ANECollectionCustomSupplementaryVC* vc = nil;

beforeEach(^{
    vc = [ANECollectionCustomSupplementaryVC new];
});

describe(@"ANECollectionCustomSupplementaryVC", ^{
   
    it(@"should have non nil properties", ^{
        expect(vc.collectionView).notTo.beNil();
        expect(vc.controller).notTo.beNil();
        expect(vc.storage).notTo.beNil();
    });
});

SpecEnd
