//
//  ANESearchBarControllerSpec.m
//  Alister-Example
//
//  Created by ANODA on 11/11/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANESearchBarController.h"

SpecBegin(ANESearchBarController)

describe(@"ANESearchBarController", ^{
    
    __block ANESearchBarController* controller = nil;
    
    beforeEach(^{
        controller = [ANESearchBarController new];
    });
    
    it(@"should update tableView correct", ^{
        ANStorage* storage = [ANStorage new];
        [controller updateWithStorage:storage];
        expect(controller.currentStorage).to.equal(storage);
    });
    
    it(@"should update searchBar correct", ^{
        UISearchBar* searchBar = [UISearchBar new];
        [controller updateWithSearchBar:searchBar];
        //TODO: how we can get access?
        //expect(controller.searchBar).to.equal(searchBar);
    });
    
    afterEach(^{
        controller = nil;
    });
});

SpecEnd
