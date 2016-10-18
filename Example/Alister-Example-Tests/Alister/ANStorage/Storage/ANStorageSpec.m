//
//  ANStorageSpec.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 10/18/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <Alister/ANStorage.h>

SpecBegin()

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
        storage.storagePredicateBlock = ^NSPredicate*(NSString* searchString, NSInteger scope) {
            
            NSPredicate* predicate = nil;
            
            if (scope == -1)
            {
                predicate = [NSPredicate predicateWithFormat:@"ANY self BEGINSWITH[c] %@", searchString];
            }
            else if (scope == 0)
            {
                predicate = nil;
            }
            else
            {
                //
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
    
    it(@"searching predicate was called", ^{
        
        waitUntil(^(void (^done)(void)){
            
            storage.storagePredicateBlock = ^NSPredicate*(NSString* searchString, NSInteger scope) {
              done();
                return nil;
            };
            
            [storage searchStorageForSearchString:nil inSearchScope:0];
        });
    });
    
    it(@"", ^{
        
    });
});


describe(@"updateWithAnimationChangeBlock:", ^{
    
});


describe(@"updateWithoutAnimationChangeBlock:", ^{
    
});


describe(@"reloadStorageWithAnimation:", ^{
    
});


describe(@"updateHeaderKind: footerKind:", ^{
    
});

describe(@"sections", ^{
    
});


describe(@"objectAtIndexPath:", ^{
    
});


describe(@"sectionAtIndex:", ^{
    
});


describe(@"indexPathForItem:", ^{
    
});

describe(@"headerModelForSectionIndex:", ^{
    
});


describe(@"headerModelForSectionIndex:", ^{
    
});


describe(@"footerModelForSectionIndex:", ^{
    
});


describe(@"supplementaryModelOfKind: forSectionIndex:", ^{
    
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
