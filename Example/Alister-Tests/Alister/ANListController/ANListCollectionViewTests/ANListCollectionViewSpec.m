//
//  ANListCollectionViewSpec.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 11/18/16.
//  Copyright 2016 Oksana Kovalchuk. All rights reserved.
//

#import "Specta.h"
#import "ANListCollectionView.h"
#import <OCMock.h>

SpecBegin(ANListCollectionView)

describe(@"ANListCollectionView", ^{

    __block ANListCollectionView *listCollectionView = nil;
    __block UICollectionView *collectionView = nil;
    
    beforeEach(^{
        UICollectionViewLayout *collectionLayout = [UICollectionViewLayout new];
        collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:collectionLayout];
        listCollectionView = [ANListCollectionView wrapperWithCollectionView:collectionView];
    });
    
    describe(@"ANListCollectionView init", ^{
        it(@"wrapperWithCollectionView",^{
            id listModel = [ANListCollectionView wrapperWithCollectionView:collectionView];
            expect(listModel).to.beKindOf([ANListCollectionView class]);
        });
    });
    
    describe(@"ANListViewInterface tests", ^{
       
        it(@"confirm to protocol ANListCollectionView", ^{
            BOOL conformToProtocol = [listCollectionView conformsToProtocol:@protocol(ANListViewInterface)];
            expect(conformToProtocol).to.beTruthy();
        });
        
        it(@"registerSupplementaryClass", ^{
            
            id mockedCollection = OCMPartialMock(collectionView);
            
            NSString *testKind = [ANTestHelper randomString];
            NSString *testIdentifier = [ANTestHelper randomString];
            
            ANListCollectionView *listController = [ANListCollectionView wrapperWithCollectionView:mockedCollection];
            OCMExpect([mockedCollection registerClass:[UICollectionReusableView class]
                           forSupplementaryViewOfKind:testKind
                                  withReuseIdentifier:testIdentifier]);
            
            [listController registerSupplementaryClass:[UICollectionReusableView class]
                                       reuseIdentifier:testIdentifier
                                                  kind:testKind];
            
            OCMVerifyAll(mockedCollection);
        });
        
        it(@"registerCellClass",^{
            
            id mockedCollection = OCMClassMock([UICollectionView class]);
            
            NSString *testIdentifier = [ANTestHelper randomString];
            
            ANListCollectionView *listController = [ANListCollectionView wrapperWithCollectionView:mockedCollection];
            
            OCMExpect([mockedCollection registerClass:[UICollectionViewCell class]
                               forCellWithReuseIdentifier:testIdentifier]);
            
            [listController registerCellClass:[UICollectionViewCell class] forReuseIdentifier:testIdentifier];
            
            OCMVerifyAll(mockedCollection);
        });
        
        it(@"registerCellClass leads to crash with invalid objects", ^{
            
            void (^testBlock)() = ^{
                [listCollectionView registerCellClass:nil forReuseIdentifier:nil];
            };
            
            expect(testBlock).to.raiseAny();
            
        });
        
        it(@"defaultCell return object UICollectionViewCell class",^{
            id object = [listCollectionView defaultCell];
            expect(object).to.beKindOf([UICollectionViewCell class]);
        });
        
        it(@"defaultSupplementary return UICollectionReusableView object class",^{
            id object = [listCollectionView defaultSupplementary];
            expect(object).to.beKindOf([UICollectionReusableView class]);
        });
        
        it(@"method view return UIScrollView", ^{
            id object = [listCollectionView view];
            expect(object).to.beKindOf([UIScrollView class]);
        });
        
        it(@"reloadAnimationDuration return 0.25",^{
            CGFloat animationDuration = [listCollectionView reloadAnimationDuration];
            expect(animationDuration).equal(0.25);
        });
        
        it(@"animationKey equal to expected key",^{
            id object = [listCollectionView animationKey];
            expect(object).equal(@"UICollectionViewReloadDataAnimationKey");
        });
        
        it(@"reload data called collection view reload data",^{
            id mockedCollection = OCMClassMock([UICollectionView class]);
            ANListCollectionView *listController = [ANListCollectionView wrapperWithCollectionView:mockedCollection];
            OCMExpect([mockedCollection reloadData]);
            
            [listController reloadData];
            
            OCMVerifyAll(mockedCollection);
        });
        
        it(@"setDelegate called setDelegate for collection view",^{
            id mockedCollection = OCMClassMock([UICollectionView class]);
            ANListCollectionView *listController = [ANListCollectionView wrapperWithCollectionView:mockedCollection];
            OCMExpect([mockedCollection setDelegate:[OCMArg any]]);
            
            [listController setDelegate:[OCMArg any]];
            
            OCMVerifyAll(mockedCollection);
        });
        
        it(@"setDataSource called setDataSource for collection view",^{
            id mockedCollection = OCMClassMock([UICollectionView class]);
            ANListCollectionView *listController = [ANListCollectionView wrapperWithCollectionView:mockedCollection];
            OCMExpect([mockedCollection setDelegate:[OCMArg any]]);
            
            [listController setDelegate:[OCMArg any]];
            
            OCMVerifyAll(mockedCollection);
        });
        
        it(@"cellForReuseIdentifier",^{
            
        });
        
    });
    
});

SpecEnd
