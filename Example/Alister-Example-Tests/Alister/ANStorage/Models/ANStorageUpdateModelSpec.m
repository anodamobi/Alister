//
//  ANStorageUpdateModelTests.m
//  Alister-Example
//
//  Created by Maxim Eremenko on 8/23/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANStorageUpdateModel.h"
#import "ANStorageUpdateModel+Test.h"

SpecBegin(ANStorageUpdateModel)

__block ANStorageUpdateModel* model = nil;

beforeEach(^{
    model = [ANStorageUpdateModel new];
});


describe(@"model at default state", ^{
    
    it(@"has empty changes", ^{
        expect([model hasSpecifiedCountOfObjectsInEachProperty:0]).beTruthy();
    });
    
    it(@"shouldn't require reload", ^{
        expect(model.isRequireReload).to.beFalsy();
    });
    
    it(@"conforms to model's protocol", ^{
        expect(model).conformTo(@protocol(ANStorageUpdateModelInterface));
    });
    
    it(@"is empty", ^{
        expect(model.isEmpty).beTruthy();
    });
});


describe(@"isEqual", ^{
    
    it(@"empty models should be equal", ^{
        ANStorageUpdateModel* emptyModel = [ANStorageUpdateModel new];
        expect(emptyModel).equal(model);
    });
    
    describe(@"models with identical changes are equal", ^{
        ANStorageUpdateModel* secondModel = [ANStorageUpdateModel filledModel];
        model = [ANStorageUpdateModel filledModel];
        expect(model).equal(secondModel);
    });
});


describe(@"isEmpty", ^{
    
    context(@"", ^{
        
        __block NSArray* array = @[[NSIndexPath indexPathForRow:0 inSection:0]];
        
        it(@"falsy when have deleted indexPath", ^{
            [model addDeletedIndexPaths:array];
            expect(model.isEmpty).to.beFalsy();
        });
        
        it(@"falsy when have inserted indexPath", ^{
            [model addInsertedIndexPaths:array];
            expect(model.isEmpty).to.beFalsy();
        });
        
        it(@"falsy when have moved indexPath", ^{
            [model addMovedIndexPaths:array];
            expect(model.isEmpty).to.beFalsy();
        });
        
        it(@"falsy when have updated indexPath", ^{
            [model addUpdatedIndexPaths:array];
            expect(model.isEmpty).to.beFalsy();
        });
    });
    
    
    context(@"", ^{
        
        __block NSIndexSet* indexSet = [NSIndexSet indexSetWithIndex:2];
        
        it(@"falsy when have deleted sections", ^{
            [model addDeletedSectionIndexes:indexSet];
            expect(model.isEmpty).to.beFalsy();
        });
        
        it(@"falsy when have updated sections", ^{
            [model addUpdatedSectionIndexes:indexSet];
            expect(model.isEmpty).to.beFalsy();
        });
        
        it(@"falsy when have inserted sections", ^{
            [model addInsertedSectionIndexes:indexSet];
            expect(model.isEmpty).to.beFalsy();
        });
    });
    
    it(@"falsy when requires reload", ^{
        model.isRequireReload = YES;
        expect(model.isEmpty).to.beFalsy();
    });
});


describe(@"index sets", ^{
    
    __block NSIndexSet* indexSet = [NSIndexSet indexSetWithIndex:1];
    
    
    context(@"addInsertedSectionIndexes:", ^{
        
        it(@"no assert if set is nil", ^{
            void(^block)() = ^() {
                [model addInsertedSectionIndexes:nil];
            };
            expect(block).notTo.raiseAny();
        });
        
        it(@"added index successfully", ^{
            [model addInsertedSectionIndexes:indexSet];
            expect(model.insertedSectionIndexes).haveCount(1);
        });
    });
    
    
    context(@"addUpdatedSectionIndexes:", ^{
        
        it(@"no assert if set is nil", ^{
            void(^block)() = ^() {
                [model addUpdatedSectionIndexes:nil];
            };
            expect(block).notTo.raiseAny();
        });
        
        it(@"added index successfully", ^{
            [model addUpdatedSectionIndexes:indexSet];
            expect(model.updatedSectionIndexes).haveCount(1);
        });
    });
    
    
    context(@"addDeletedSectionIndexes:", ^{
        
        it(@"no assert if set is nil", ^{
            void(^block)() = ^() {
                [model addDeletedSectionIndexes:nil];
            };
            expect(block).notTo.raiseAny();
        });
        
        it(@"added index successfully", ^{
            [model addDeletedSectionIndexes:indexSet];
            expect(model.deletedSectionIndexes).haveCount(1);
        });
    });
});


describe(@"indexes", ^{
    
    __block NSInteger index = 1;
    
    
    context(@"addDeletedSectionIndex:", ^{
        
        it(@"contains index", ^{
            [model addDeletedSectionIndex:index];
            expect([model.deletedSectionIndexes containsIndex:index]).beTruthy();
            expect(model.deletedSectionIndexes).haveCount(1);
        });
    });
    
    
    context(@"addUpdatedSectionIndex:", ^{
        
        it(@"contains index", ^{
            [model addUpdatedSectionIndex:index];
            expect([model.updatedSectionIndexes containsIndex:index]).beTruthy();
            expect(model.updatedSectionIndexes).haveCount(1);
        });
    });
    
    
    context(@"addInsertedSectionIndex:", ^{
        
        it(@"contains index", ^{
            [model addInsertedSectionIndex:index];
            expect([model.insertedSectionIndexes containsIndex:index]).beTruthy();
            expect(model.insertedSectionIndexes).haveCount(1);
        });
    });
});


describe(@"index Paths", ^{
    
    __block NSIndexPath* indexPath = [NSIndexPath indexPathWithIndex:1];
    __block NSArray* indexPathsArray = @[indexPath];
    
    context(@"addInsertedIndexPaths:", ^{
        
        it(@"contains added indexPath", ^{
            [model addInsertedIndexPaths:indexPathsArray];
            expect(model.insertedRowIndexPaths).contain(indexPath);
        });
        
        it(@"no assert if add nil", ^{
            void(^block)() = ^() {
                [model addInsertedIndexPaths:nil];
            };
            expect(block).notTo.raiseAny();
        });
    });
    
    
    context(@"addUpdatedIndexPaths:", ^{
        
        it(@"contains updated indexPath", ^{
            [model addUpdatedIndexPaths:indexPathsArray];
            expect(model.updatedRowIndexPaths).contain(indexPath);
        });
        
        it(@"no assert if add nil", ^{
            void(^block)() = ^() {
                [model addUpdatedIndexPaths:nil];
            };
            expect(block).notTo.raiseAny();
        });
    });
    
    
    context(@"addDeletedIndexPaths:", ^{
        
        it(@"contains updated indexPath", ^{
            [model addDeletedIndexPaths:indexPathsArray];
            expect(model.deletedRowIndexPaths).contain(indexPath);
        });
        
        it(@"no assert if add nil", ^{
            void(^block)() = ^() {
                [model addDeletedIndexPaths:nil];
            };
            expect(block).notTo.raiseAny();
        });
    });
    
    
    context(@"addMovedIndexPaths:", ^{
        
        it(@"contains updated indexPath", ^{
            [model addMovedIndexPaths:indexPathsArray];
            expect(model.movedRowsIndexPaths).contain(indexPath);
        });
        
        it(@"no assert if add nil", ^{
            void(^block)() = ^() {
                [model addMovedIndexPaths:nil];
            };
            expect(block).notTo.raiseAny();
        });
    });
});


describe(@"mergeWith:", ^{
    
    __block ANStorageUpdateModel* mergeModel = nil;
    
    beforeEach(^{
        mergeModel = [ANStorageUpdateModel filledModel];
    });
    
    it(@"no assert when model is nil", ^{
        void(^block)() = ^() {
            [model mergeWith:nil];
        };
        expect(block).notTo.raiseAny();
    });
    
    
    context(@"requires reload options", ^{
        
        it(@"merge with model that requiresReload", ^{
            mergeModel.isRequireReload = YES;
            [model mergeWith:mergeModel];
            
            expect(model.isRequireReload).beTruthy();
        });
        
        it(@"current model requires reload ", ^{
            model.isRequireReload = YES;
            [model mergeWith:mergeModel];
            
            expect(model.isRequireReload).beTruthy();
        });
        
        it(@"no one model requires reload", ^{
            [model mergeWith:mergeModel];
            
            expect(model.isRequireReload).beFalsy();
        });
    });
    
    context(@"properties after merge", ^{
        
        it(@"empty with filled", ^{
            [model mergeWith:mergeModel];
            expect([model hasSpecifiedCountOfObjectsInEachProperty:1]).beTruthy();
        });
        
        it(@"filled with empty", ^{
            [mergeModel mergeWith:model];
            expect([mergeModel hasSpecifiedCountOfObjectsInEachProperty:1]).beTruthy();
        });
        
        it(@"empty with empty", ^{
            [model mergeWith:[ANStorageUpdateModel new]];
            expect([model hasSpecifiedCountOfObjectsInEachProperty:0]).beTruthy();
        });
        
        it(@"filled with filled", ^{
            
            ANStorageUpdateModel* testModel = [ANStorageUpdateModel new];
            
            [testModel addInsertedSectionIndexes:[NSIndexSet indexSetWithIndex:2]];
            [testModel addUpdatedSectionIndexes:[NSIndexSet indexSetWithIndex:4]];
            [testModel addDeletedSectionIndexes:[NSIndexSet indexSetWithIndex:3]];
            
            [testModel addInsertedIndexPaths:@[[NSIndexPath indexPathWithIndex:1]]];
            [testModel addUpdatedIndexPaths:@[[NSIndexPath indexPathWithIndex:2]]];
            [testModel addDeletedIndexPaths:@[[NSIndexPath indexPathWithIndex:10]]];
            [testModel addMovedIndexPaths:@[[NSIndexPath indexPathWithIndex:13]]];
            
            [mergeModel mergeWith:testModel];
            expect([mergeModel hasSpecifiedCountOfObjectsInEachProperty:2]).beTruthy();
        });
    });
});

SpecEnd
