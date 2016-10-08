//
//  ANStorageModelTest.m
//  Alister
//
//  Created by Oksana on 7/10/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <Alister/ANStorageModel.h>
#import <Alister/ANStorageSectionModel.h>

@interface ANStorageModel ()

@property (nonatomic, strong) NSMutableArray<ANStorageSectionModel*>* sectionModels;

@end



SpecBegin(ANStorageModel)

__block ANStorageModel* model = nil;

beforeEach(^{
    model = [ANStorageModel new];
});


describe(@"default state", ^{
    
    it(@"sectionModels array is empty", ^{
        expect(model.sectionModels).haveCount(0);
    });
    
    it(@"sectionModels array not nil", ^{
        expect(model.sectionModels).toNot.beNil();
    });
});


describe(@"addSection:", ^{
    
    it(@"no assert if add nil instead model", ^{
        
        void(^testBlock)(void) = ^{
            [model addSection:nil];
        };
        
        expect(testBlock).notTo.raiseAny();
        expect(model.sections).haveCount(0);
    });
    
    it(@"after has a valid number of sections", ^{
        
        [model addSection:[ANStorageSectionModel new]];
        expect(model.sections).haveCount(1);
    });
    
    it(@"should not add non section model", ^{
        
        void(^testBlock)(void) = ^{
            [model addSection:(ANStorageSectionModel*)@""];
        };
        
        expect(testBlock).notTo.raiseAny();
        expect(model.sections).haveCount(0);
    });
});


describe(@"itemsInSection:", ^{
    
    it(@"no assert if provide invalid index", ^{
        
        void(^TestBlock)(void) = ^{
            [model itemsInSection:arc4random()];
        };
        
        expect(TestBlock).notTo.raiseAny();
    });
    
    it(@"has correct value after add item", ^{
        
        ANStorageSectionModel* section = [ANStorageSectionModel new];
        [section addItem:@"Test"];
        [model.sectionModels addObject:section];
        
        expect([model itemsInSection:0]).haveCount(1);
    });
    
    it(@"is nil when section not exists after init", ^{
        expect([model itemsInSection:0]).to.beNil();
    });
});


describe(@"sectionAtIndex:", ^{
    
    it(@"no assert if provide invalid index", ^{
        
        void(^testBlock)(void) = ^{
            [model sectionAtIndex:1];
        };
        expect(testBlock).notTo.raiseAny();
    });
    
    it(@"returns correct section", ^{
        [model addSection:[ANStorageSectionModel new]];
        expect([model sectionAtIndex:0]).notTo.beNil();
    });
    
    it(@"returns nil if section not exists", ^{
        expect([model sectionAtIndex:1]).to.beNil();
    });
});


describe(@"removeSectionAtIndex:", ^{
    
    it(@"no assert if provide invalid index", ^{
        
        void(^testBlock)(void) = ^{
            [model removeSectionAtIndex:2];
        };
        
        expect(testBlock).notTo.raiseAny();
    });
    
    it(@"removes section if it exists", ^{
        [model addSection:[ANStorageSectionModel new]];
        [model addSection:[ANStorageSectionModel new]];
        [model removeSectionAtIndex:0];
        
        expect(model.sectionModels).haveCount(1);
    });
    
    it(@"removes last section in model", ^{
        [model addSection:[ANStorageSectionModel new]];
        [model removeSectionAtIndex:0];
        
        expect(model.sectionModels).haveCount(0);
    });
    
    it(@"not removes section if index not exists", ^{
        [model addSection:[ANStorageSectionModel new]];
        [model removeSectionAtIndex:1];
        
        expect(model.sectionModels).haveCount(1);
    });
});


describe(@"removeAllSections", ^{
    
    it(@"successfully removes all sections if they exists", ^{
        [model addSection:[ANStorageSectionModel new]];
        [model removeAllSections];
        
        expect(model.sections).haveCount(0);
    });
    
    it(@"no assert if sections were empty", ^{
        [model removeAllSections];
        
        expect(model.sections).haveCount(0);
    });
    
    it(@"possible to add new section after removeAll", ^{
        [model removeAllSections];
        [model addSection:[ANStorageSectionModel new]];
        
        expect(model.sections).haveCount(1);
    });
});


describe(@"itemAtIndexPath:", ^{
    
    it(@"returns valid item when indexPath exists", ^{
       
        NSString* object = @"Test";
        ANStorageSectionModel* section = [ANStorageSectionModel new];
        [section addItem:object];
        [model addSection:section];
        NSIndexPath* firstItemIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
        
        expect([model itemAtIndexPath:firstItemIndexPath]).to.equal(object);
    });
    
    it(@"no assert when indexPath is nil", ^{
        
        void(^testBlock)() = ^{
            [model itemAtIndexPath:nil];
        };
        
        expect(testBlock).notTo.raiseAny();
    });
    
    it(@"returns nil when indexPath is not exists", ^{
        NSIndexPath* negativeIndexPath = [NSIndexPath indexPathForItem:1 inSection:1];
        expect([model itemAtIndexPath:negativeIndexPath]).to.beNil();
    });
    
    it(@"no assert if provide not a instance of indexPath", ^{
        
        void(^testBlock)() = ^{
            [model itemAtIndexPath:(NSIndexPath*)@""];
        };
        
        expect(testBlock).notTo.raiseAny();
    });
});


SpecEnd
