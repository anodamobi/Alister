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
__block __weak typeof(vc) weakVC = vc;

beforeEach(^{
    vc = [ANECollectionCustomSupplementaryVC new];
    weakVC = vc;
});

describe(@"ANECollectionCustomSupplementaryVC", ^{
   
    it(@"should have non nil collectionView", ^{
        expect(vc.collectionView).notTo.beNil();
    });
    
    it(@"should have non nil controller", ^{
        expect(vc.controller).notTo.beNil();
    });
    
    it(@"should have non nil storage", ^{
        expect(vc.storage).notTo.beNil();
    });
    
});

SpecEnd
