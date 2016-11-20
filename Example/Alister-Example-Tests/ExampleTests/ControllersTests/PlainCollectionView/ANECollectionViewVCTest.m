//
//  ANECollectionViewVCTest.m
//  Alister-Example
//
//  Created by ANODA on 11/20/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANECollectionViewVC.h"
#import "ANECollectionViewController.h"
#import "ANStorage.h"

@interface ANECollectionViewVC ()

@property (nonatomic, strong) UICollectionView* collectionView;
@property (nonatomic, strong) ANECollectionViewController* controller;
@property (nonatomic, strong) ANStorage* storage;

@end

SpecBegin(ANECollectionViewVC)

__block ANECollectionViewVC* vc = nil;

beforeEach(^{
    vc = [ANECollectionViewVC new];
});

describe(@"ANECollectionViewVC", ^{
    
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
