//
//  ANStorageSpec.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 10/18/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANStorage.h"
#import "ANStorageModel.h"
#import "ANListControllerUpdateService.h"


@interface ANStorage ()

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

describe(@"reloadStorageWithAnimation:", ^{
    __block id listController = nil;

    beforeEach(^{
        listController = OCMPartialMock([ANListControllerUpdateService new]);
        storage.updatesHandler = listController;
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
    
    //TODO: check we need to test this flow
    
//    it(@"updates successfully with correct values", ^{
//        [storage updateHeaderKind:headerKind footerKind:footerKind];
//        expect(storage.controller.storageModel.headerKind).equal(headerKind);
//        expect(storage.controller.storageModel.footerKind).equal(footerKind);
//    });
    
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
        listController = OCMPartialMock([ANListControllerUpdateService new]);
        storage.updatesHandler = listController;
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
    
    it(@"update with animation block return ANStorageUpdatableInterface instance, when list controller is nil",^{
        storage.updatesHandler = nil;
        
        void (^testBlock)(id interfaceObject) = ^(id interfaceObject) {
            expect(interfaceObject).conformTo(@protocol(ANStorageUpdatableInterface));
        };
        
        [storage updateWithAnimationChangeBlock:testBlock];
    });
    
});

describe(@"updateWithoutAnimationChangeBlock", ^{
    
    __block id listController = nil;
    
    beforeEach(^{
        listController = OCMPartialMock([ANListControllerUpdateService new]);
        storage.updatesHandler = listController;
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
        storage.updatesHandler = nil;
        
        void (^testBlock)(id interfaceObject) = ^(id interfaceObject) {
            expect(interfaceObject).conformTo(@protocol(ANStorageUpdatableInterface));
        };
        
        [storage updateWithoutAnimationChangeBlock:testBlock];
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
