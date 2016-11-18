//
//  ANCollectionControllerSpec.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 11/17/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANCollectionController.h"
#import "ANListController+Interitance.h"

SpecBegin(ANCollectionController)

describe(@"", ^{
    
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
        
        NSString* kind = [ANTestHelper randomString];
        id object = [ANTestHelper randomObject];
        
        id storage = OCMClassMock([ANStorage class]);
        [controller attachStorage:storage];
        
        OCMStub([storage supplementaryModelOfKind:kind forSectionIndex:zeroIndexPath.section]);
        [OCMStub([controller.itemsHandler supplementaryViewForModel:[OCMArg any]
                                                              kind:kind
                                                      forIndexPath:zeroIndexPath]) andReturn:object];
        
        id result = [controller collectionView:collectionView
             viewForSupplementaryElementOfKind:kind
                                   atIndexPath:zeroIndexPath];
        
        expect(result).equal(object);
    });
    
    
    describe(@"collectionView: layout: referenceSizeForHeaderInSection:", ^{
        pending(@"Pending");
    });

    
    describe(@"collectionView: layout: referenceSizeForFooterInSection:", ^{
        pending(@"Pending");
    });
    
    
    describe(@"numberOfSectionsInCollectionView:", ^{
       
        it(@"correct number of items", ^{
            
            id storage = OCMClassMock([ANStorage class]);
            [controller attachStorage:storage];
            NSArray* expectedSections = [ANTestHelper randomArray];
            [OCMStub([storage sections]) andReturn:expectedSections];
           
            NSInteger actualSectionsCount = [controller numberOfSectionsInCollectionView:collectionView];
            
            OCMVerify([storage sections]);
            expect(actualSectionsCount).equal(expectedSections.count);
        });
    });
    
    
    describe(@"collectionView: numberOfItemsInSection:", ^{
        
        it(@"no items when storage is nil", ^{
            NSInteger result = [controller collectionView:collectionView numberOfItemsInSection:0];
            expect(result).equal(0);
        });
        
        it(@"correct number of items", ^{
            
            NSInteger sectionIndex = 0;
            
            NSNumber* objectCount = [ANTestHelper randomNumber];
            id storage = OCMClassMock([ANStorage class]);
            id section = OCMProtocolMock(@protocol(ANStorageSectionModelInterface));
            
            [controller attachStorage:storage];
            
            [OCMStub([storage sectionAtIndex:sectionIndex]) andReturn:section];
            [OCMStub([section numberOfObjects]) andReturnValue:objectCount];
            
            NSInteger currentCount = [controller collectionView:collectionView numberOfItemsInSection:sectionIndex];
            
            OCMVerify([storage sectionAtIndex:sectionIndex]);
            OCMVerify([section numberOfObjects]);
            
            expect(currentCount).equal(objectCount.integerValue);
        });
    });
    
    
    describe(@"collectionView: cellForItemAtIndexPath:", ^{
        
        it(@"should load cell by model object", ^{
            
            [controller collectionView:collectionView cellForItemAtIndexPath:zeroIndexPath];
            
            OCMVerify([controller.storage objectAtIndexPath:zeroIndexPath]);
            OCMVerify([controller.itemsHandler cellForModel:[OCMArg any] atIndexPath:zeroIndexPath]);
        });
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
