//
//  ANCollectionControllerSpec.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 11/17/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANCollectionController.h"

SpecBegin(ANCollectionController)

fdescribe(@"", ^{
    
    __block UICollectionView* collectionView = nil;
    __block ANCollectionController* controller = nil;
    __block NSIndexPath* zeroIndexPath = nil;
    
    beforeEach(^{
        
        UICollectionViewLayout* layout = [UICollectionViewLayout new];
        collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 400, 400)
                                            collectionViewLayout:layout];
        
        controller = [[ANCollectionController alloc] initWithCollectionView:collectionView];
        zeroIndexPath = [ANTestHelper zeroIndexPath];
    });
    
    describe(@"controllerWithCollectionView", ^{
        
        it(@"will not be nil", ^{
            id result = [ANCollectionController controllerWithCollectionView:collectionView];
            expect(result).notTo.beNil();
        });
        
        it(@"will have the same coolection view", ^{
            ANCollectionController* result = [ANCollectionController controllerWithCollectionView:collectionView];
            expect(result.collectionView).equal(collectionView);
        });
    });
    
    
    describe(@"initWithCollectionView", ^{
        
        it(@"will not be nil", ^{
            id result = [[ANCollectionController alloc] initWithCollectionView:collectionView];
            expect(result).notTo.beNil();
        });
        
        it(@"will have the same coolection view", ^{
            ANCollectionController* result = [[ANCollectionController alloc] initWithCollectionView:collectionView];
            expect(result.collectionView).equal(collectionView);
        });
    });
    
    
    describe(@"collectionView: viewForSupplementaryElementOfKind: atIndexPath:", ^{
        
    });
    
    
    describe(@"collectionView: layout: referenceSizeForHeaderInSection:", ^{
        
    });

    
    describe(@"collectionView: layout: referenceSizeForFooterInSection:", ^{
        
    });
    
    
    describe(@"numberOfSectionsInCollectionView:", ^{
        
    });
    
    
    describe(@"collectionView: numberOfItemsInSection:", ^{
        
    });
    
    
    describe(@"collectionView: cellForItemAtIndexPath:", ^{
        
    });
    
    
    describe(@"collectionView: didSelectItemAtIndexPath:", ^{
        
        it(@"should pass correct indexPath and model", ^{
            
            id mockedStorage = OCMClassMock([ANStorage class]);
            id object = [ANTestHelper randomObject];
            NSIndexPath* objectIndexPath = [ANTestHelper zeroIndexPath];
            [controller attachStorage:mockedStorage];
            __block BOOL wasCalled = NO;
            
            [OCMStub([mockedStorage objectAtIndexPath:objectIndexPath]) andReturn:object];
            
            [controller configureItemSelectionBlock:^(id model, NSIndexPath* indexPath) {
                wasCalled = YES;
                expect(model).equal(object);
                expect(objectIndexPath).equal(indexPath);
            }];
            
            [controller collectionView:collectionView didSelectItemAtIndexPath:objectIndexPath];
        });
        
        it(@"should not raise when selection block is nil", ^{
            void(^block)() = ^() {
                [controller collectionView:collectionView didSelectItemAtIndexPath:zeroIndexPath];
            };
            expect(block).notTo.raiseAny();
        });
        
        it(@"should deselect row", ^{
            id collectionMock = OCMClassMock([UICollectionView class]);
            [controller collectionView:collectionMock didSelectItemAtIndexPath:zeroIndexPath];
            
            OCMVerify([collectionMock deselectItemAtIndexPath:zeroIndexPath animated:YES]);
        });
    });
});

SpecEnd
