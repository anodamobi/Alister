//
//  ANTableContainerViewTest.m
//  Alister-Example
//
//  Created by ANODA on 8/25/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANTableContainerView.h"

SpecBegin(ANTableContainerView)


describe(@"containerWithTableViewStyle:", ^{
    
    it(@"not a nil after creation", ^{
        id view = [ANTableContainerView containerWithTableViewStyle:UITableViewStylePlain];
        expect(view).notTo.beNil();
    });
    
    it(@"tableView property is not nil", ^{
        ANTableContainerView* view = [ANTableContainerView containerWithTableViewStyle:UITableViewStylePlain];
        expect(view.tableView).notTo.beNil();
    });
    
    it(@"tableView style match passed value", ^{
        NSInteger style = UITableViewStylePlain;
        ANTableContainerView* view = [ANTableContainerView containerWithTableViewStyle:style];
        
        expect(view.tableView.style).equal(style);
    });
    
    it(@"contains ANTableView as subview", ^{
        ANTableContainerView* view = [ANTableContainerView containerWithTableViewStyle:UITableViewStylePlain];
        expect(view.subviews).contain(view.tableView);
    });
});


describe(@"initWithStyle:", ^{
    
    it(@"tableView property is not nil", ^{
        ANTableContainerView* view = [[ANTableContainerView alloc] initWithTableViewStyle:UITableViewStylePlain];
        expect(view.tableView).notTo.beNil();
    });
    
    it(@"tableView style match passed value", ^{
        NSInteger style = UITableViewStylePlain;
        ANTableContainerView* view = [[ANTableContainerView alloc] initWithTableViewStyle:style];
        
        expect(view.tableView.style).equal(style);
    });
    
    it(@"contains ANTableView as subview", ^{
        ANTableContainerView* view = [[ANTableContainerView alloc] initWithTableViewStyle:UITableViewStylePlain];
        expect(view.subviews).contain(view.tableView);
    });
});

SpecEnd
