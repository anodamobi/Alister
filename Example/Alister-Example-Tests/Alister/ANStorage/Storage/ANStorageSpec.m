//
//  ANStorageSpec.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 10/18/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <Alister/ANStorage.h>
#import <Alister/ANStorageController.h>
#import <Alister/ANStorageModel.h>

@interface ANStorage ()

@property (nonatomic, strong) ANStorageController* controller;
@property (nonatomic, assign) BOOL isSearchingType;

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

//describe(@"updateWithAnimationChangeBlock:", ^{
//    it(@"no assert if block is nil", ^{
//        failure(@"Pending");
//    });
//});
//
//
//describe(@"updateWithoutAnimationChangeBlock:", ^{
//    it(@"no assert if block is nil", ^{
//        failure(@"Pending");
//    });
//});
//
//
describe(@"reloadStorageWithAnimation:", ^{
    
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
        expect(storage.controller.storageModel.headerKind).equal(headerKind);
        expect(storage.controller.storageModel.footerKind).equal(footerKind);
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

//describe(@"sections", ^{
//    it(@"responds", ^{
//        failure(@"Pending");
//    });
//});
//
//
//describe(@"objectAtIndexPath:", ^{
//    it(@"responds", ^{
//        failure(@"Pending");
//    });
//});
//
//
//describe(@"sectionAtIndex:", ^{
//    it(@"responds", ^{
//        failure(@"Pending");
//    });
//});
//
//
//describe(@"indexPathForItem:", ^{
//    it(@"responds", ^{
//        failure(@"Pending");
//    });
//});
//
//describe(@"headerModelForSectionIndex:", ^{
//    it(@"responds", ^{
//        failure(@"Pending");
//    });
//});
//
//
//describe(@"headerModelForSectionIndex:", ^{
//    it(@"responds", ^{
//        failure(@"Pending");
//    });
//});
//
//
//describe(@"footerModelForSectionIndex:", ^{
//    it(@"responds", ^{
//        failure(@"Pending");
//    });
//});
//
//
//describe(@"supplementaryModelOfKind: forSectionIndex:", ^{
//    it(@"responds", ^{
//        failure(@"Pending");
//    });
//});

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
