//
//  ANStorageSpec.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 10/18/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <Alister/ANStorage.h>
#import <Alister/ANStorageModel.h>
#import <Alister/ANListControllerQueueProcessor.h>

@interface ANStorage ()

@property (nonatomic, assign) BOOL isSearchingType;
@property (nonatomic, strong, nonnull) ANStorageModel* storageModel;

@end

SpecBegin(ANStorage)

__block ANStorage* storage = nil;

beforeEach(^{
    storage = [ANStorage new];
});

describe(@"at default state", ^{
    
    it(@"has identifier", ^{
        expect(storage.identifier).notTo.beNil();
    });
});




describe(@"searchStorageForSearchString: inSearchScope:", ^{
    
    beforeEach(^{
        storage.storagePredicateBlock = ^NSPredicate* (NSString* searchString, NSInteger scope) {
            
            NSPredicate* predicate = nil;
            if (searchString)
            {
                if (scope == -1)
                {
                    predicate = [NSPredicate predicateWithFormat:@"ANY self BEGINSWITH[cd] %@", searchString];
                }
                else if (scope == 0)
                {
                     predicate = [NSPredicate predicateWithFormat:@"self CONTAINS[cd] %@", searchString];
                }
            }
            
            return predicate;
        };
    });
    
    it(@"successfully created", ^{
        ANStorage* searchStorage = [storage searchStorageForSearchString:@"test" inSearchScope:0];
        expect(searchStorage).notTo.beNil();
    });
    
    it(@"successfully created when string is nil", ^{
        ANStorage* searchStorage = [storage searchStorageForSearchString:nil inSearchScope:0];
        expect(searchStorage).notTo.beNil();
    });
    
    it(@"no assert if string is nil", ^{
        void(^block)() = ^() {
            [storage searchStorageForSearchString:nil inSearchScope:0];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"filters by predicate ", ^{
        NSArray* itemsForScope1 = @[@"test", @"test1", @"test2", @"test4"];
        NSArray* items = [itemsForScope1 arrayByAddingObjectsFromArray:@[@"anoda", @"tiger", @"tooth",
                                                                         @"tool", @"something", @"anything"]];
        
        [storage updateWithoutAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
            [storageController addItems:items];
        }];
        
        NSString* searchString = @"test";
        ANStorage* searchStorage = [storage searchStorageForSearchString:searchString inSearchScope:0];
        expect(searchStorage.sections).haveCount(1);
        
        [[searchStorage itemsInSection:0] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger __unused idx, BOOL * _Nonnull __unused stop) {
           expect(obj).beginWith(searchString);
        }];
        
        expect([searchStorage itemsInSection:0]).haveCount(itemsForScope1.count);
        expect([searchStorage sections]).haveCount(1);
    });
});


describe(@"storagePredicateBlock", ^{
    
    it(@"called when searching storage created", ^{
        waitUntil(^(void (^done)(void)) {
            storage.storagePredicateBlock = ^NSPredicate* (NSString* __unused searchString,
                                                           NSInteger __unused scope) {
                done();
                
                return nil;
            };
            
            [storage searchStorageForSearchString:nil inSearchScope:0];
        });
    });
    
    it(@"received correct parameters", ^{
        __block NSString* searchStringItem = @"test";
        __block NSInteger scopeItem = 2;
        
        waitUntil(^(void (^done)(void)) {
            storage.storagePredicateBlock = ^NSPredicate* (NSString* __unused searchString, NSInteger __unused scope) {
                done();
                
                expect(searchString).equal(searchStringItem);
                expect(scope).equal(scopeItem);
                
                return nil;
            };
            [storage searchStorageForSearchString:searchStringItem inSearchScope:scopeItem];
        });
    });
    
    it(@"no assert when block is nil", ^{
        void(^block)() = ^() {
            [storage searchStorageForSearchString:nil inSearchScope:0];
        };
        expect(block).notTo.raiseAny();
    });
});

describe(@"reloadStorageWithAnimation:", ^{
    __block id listController = nil;

    beforeEach(^{
        listController = OCMPartialMock([ANListControllerQueueProcessor new]);
        storage.listController = listController;
    });
    
    it(@"storage called reload in list controller",^{
        OCMExpect([listController storageNeedsReloadWithIdentifier:[OCMArg any] animated:YES]);
        [storage reloadStorageWithAnimation:YES];
        OCMVerifyAll(listController);
    });
    
});

describe(@"updateHeaderKind: footerKind:", ^{
    
    __block NSString* headerKind = nil;
    __block NSString* footerKind = nil;
    
    beforeAll(^{
        headerKind = @"headerKind";
        footerKind = @"footerKind";
    });
    
    it(@"updates successfully with correct values", ^{
        [storage updateHeaderKind:headerKind footerKind:footerKind];
        expect(storage.storageModel.headerKind).equal(headerKind);
        expect(storage.storageModel.footerKind).equal(footerKind);
    });
    
    it(@"no assert if both are nil", ^{
        void(^block)() = ^() {
            [storage updateHeaderKind:nil footerKind:nil];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if header is nil", ^{
        void(^block)() = ^() {
            [storage updateHeaderKind:nil footerKind:footerKind];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"no assert if footer is nil", ^{
        void(^block)() = ^() {
            [storage updateHeaderKind:headerKind footerKind:nil];
        };
        expect(block).notTo.raiseAny();
    });
});

describe(@"updateWithAnimationChangeBlock", ^{
    
    __block id listController = nil;
    
    beforeEach(^{
        listController = OCMPartialMock([ANListControllerQueueProcessor new]);
        storage.listController = listController;
    });
    
    it(@"updateWithAnimationChangeBlock called list controller storageDidPerformUpdate", ^{
        
        storage.isSearchingType = NO;
        OCMExpect([listController storageDidPerformUpdate:[OCMArg any] withIdentifier:storage.identifier animatable:YES]);
        
        [storage updateWithAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
            [storageController addItem:@"first"];
        }];
        
        OCMVerifyAll(listController);
    });
    
    it(@"update with animation block return ANStorageUpdatableInterface instance", ^{
        
        storage.isSearchingType = YES;
        
        void (^testBlock)(id interfaceObject) = ^(id interfaceObject) {
            expect(interfaceObject).conformTo(@protocol(ANStorageUpdatableInterface));
        };
        
        [storage updateWithAnimationChangeBlock:testBlock];
    });
    
    it(@"update with animation block return ANStorageUpdatableInterface instance, when list controller is nil", ^{
        storage.listController = nil;
        
        void (^testBlock)(id interfaceObject) = ^(id interfaceObject) {
            expect(interfaceObject).conformTo(@protocol(ANStorageUpdatableInterface));
        };
        
        [storage updateWithAnimationChangeBlock:testBlock];
    });
    
});

describe(@"updateWithoutAnimationChangeBlock", ^{
    
    __block id listController = nil;
    
    beforeEach(^{
        listController = OCMPartialMock([ANListControllerQueueProcessor new]);
        storage.listController = listController;
    });
    
    it(@"called list controller storageDidPerformUpdate", ^{
        storage.isSearchingType = NO;
        OCMExpect([listController storageDidPerformUpdate:[OCMArg any] withIdentifier:[OCMArg any] animatable:NO]);
        
        [storage updateWithoutAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
            [storageController addItem:@"first"];
        }];
        
        OCMVerifyAll(listController);
    });
    
    it(@"update without animation block return ANStorageUpdatableInterface instance", ^{
        
        storage.isSearchingType = YES;
        
        void (^testBlock)(id interfaceObject) = ^(id interfaceObject) {
            expect(interfaceObject).conformTo(@protocol(ANStorageUpdatableInterface));
        };
        
        [storage updateWithoutAnimationChangeBlock:testBlock];
    });
    
    it(@"update without animation block return ANStorageUpdatableInterface instance, when list controller is nil",^{
        storage.listController = nil;
        
        void (^testBlock)(id interfaceObject) = ^(id interfaceObject) {
            expect(interfaceObject).conformTo(@protocol(ANStorageUpdatableInterface));
        };
        
        [storage updateWithoutAnimationChangeBlock:testBlock];
    });
    
    
});


#pragma mark - ANStorageRetrivingInterface tests

describe(@"storage ANStorageRetrivingInterface", ^{
    
    it(@"storage conform to protocol ANStorageRetrivingInterface", ^{
        expect(storage).conformTo(@protocol(ANStorageRetrivingInterface));
    });
    
    it(@"isEmpty should return YES",^{
        [storage updateWithoutAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
            [storageController removeAllItemsAndSections];
        }];
        expect([storage isEmpty]).to.beTruthy();
    });
    
    it(@"isEmpty should return  NO after add items", ^{
        [storage updateWithAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
            [storageController addItem:@"some object"];
        }];
        expect([storage isEmpty]).to.beFalsy();
    });
    
    
});













//describe(@"updateSupplementaryHeaderKind:", ^{
//    
//    it(@"should match stogeModel value after update", ^{
//        NSString* item = @"test";
//        [storage updateSupplementaryHeaderKind:item];
//        
//        expect(storage.storageModel.headerKind).equal(item);
//    });
//    
//    it(@"no assert if kind is nil", ^{
//        void(^block)() = ^() {
//            [storage updateSupplementaryHeaderKind:kANTestNil];
//        };
//        expect(block).notTo.raiseAny();
//    });
//});


//describe(@"updateSupplementaryFooterKind:", ^{
//    
//    it(@"should match stogeModel value after update", ^{
//        NSString* item = @"test";
//        [storage updateSupplementaryFooterKind:item];
//        
//        expect(storage.storageModel.footerKind).equal(item);
//    });
//    
//    it(@"no assert if kind is nil", ^{
//        void(^block)() = ^() {
//            [storage updateSupplementaryFooterKind:kANTestNil];
//        };
//        expect(block).notTo.raiseAny();
//    });
//});
//
//
//describe(@"updateSupplementaryFooterKind:", ^{
//    
//    it(@"should match storageModel value", ^{
//        [controller updateSupplementaryFooterKind:@"test"];
//        expect(storage.storageModel.headerKind).equal(@"test");
//    });
//});
//
//
//describe(@"footerModelForSectionIndex:", ^{
//    
//    it(@"should match storageModel value", ^{
//        [storage updateSupplementaryFooterKind:@"test"];
//        expect(storage.storageModel.footerKind).equal(@"test");
//    });
//});
//
//
//describe(@"updateSectionHeaderModel: forSectionIndex:", ^{
//    
//    [storage updateSectionHeaderModel:@"test" forSectionIndex:0];
//    pending(@"Pending");
//});
//
//
//describe(@"updateSectionFooterModel: forSectionIndex:", ^{
//    
//    [storage updateSectionFooterModel:@"test" forSectionIndex:0];
//    pending(@"Pending");
//});


describe(@"supplementaryModelOfKind: forSectionIndex:", ^{
    
    it(@"responds to selector", ^{
        expect(storage).respondTo(@selector(supplementaryModelOfKind:forSectionIndex:));
    });
});







describe(@"sections", ^{
    it(@"responds", ^{
        pending(@"Pending");
    });
});


describe(@"objectAtIndexPath:", ^{
    it(@"responds", ^{
        pending(@"Pending");
    });
});


describe(@"sectionAtIndex:", ^{
    it(@"responds", ^{
        pending(@"Pending");
    });
});


describe(@"indexPathForItem:", ^{
    it(@"responds", ^{
        pending(@"Pending");
    });
});

describe(@"headerModelForSectionIndex:", ^{
    it(@"responds", ^{
        pending(@"Pending");
    });
});


describe(@"headerModelForSectionIndex:", ^{
    it(@"responds", ^{
        pending(@"Pending");
    });
});


describe(@"footerModelForSectionIndex:", ^{
    it(@"responds", ^{
        pending(@"Pending");
    });
});


describe(@"supplementaryModelOfKind: forSectionIndex:", ^{
    it(@"responds", ^{
        pending(@"Pending");
    });
});

SpecEnd


//@property (nonatomic, weak) id<ANStorageUpdatingInterface> listController;
//@property (nonatomic, copy) ANStorageSearchPredicate storagePredicateBlock;
//
//@property (nonatomic, strong, readonly) NSString* identifier;
//
//- (instancetype)searchStorageForSearchString:(NSString*)searchString
//inSearchScope:(NSInteger)searchScope;
//
//- (void)updateWithAnimationChangeBlock:(ANDataStorageUpdateBlock)block;
//- (void)updateWithoutAnimationChangeBlock:(ANDataStorageUpdateBlock)block;
//- (void)reloadStorageWithAnimation:(BOOL)isAnimatable;
//
////private ://todo
//- (void)updateHeaderKind:(NSString*)headerKind footerKind:(NSString*)footerKind;
//- (BOOL)isEmpty;
//- (NSArray*)sections;
//- (nullable id)objectAtIndexPath:(NSIndexPath*)indexPath;
//- (nullable ANStorageSectionModel*)sectionAtIndex:(NSUInteger)sectionIndex;
//- (nullable NSArray*)itemsInSection:(NSUInteger)sectionIndex;
//- (nullable NSIndexPath*)indexPathForItem:(id)item;
//- (nullable id)headerModelForSectionIndex:(NSUInteger)index;
//- (nullable id)footerModelForSectionIndex:(NSUInteger)index;
//- (nullable id)supplementaryModelOfKind:(NSString*)kind forSectionIndex:(NSUInteger)sectionIndex;
