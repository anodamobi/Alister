//
//  ANTableViewTests.m
//  Alister-Example
//
//  Created by Maxim Eremenko on 8/22/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <Alister/ANTableView.h>

SpecBegin(ANTableView)

describe(@"tableViewDefaultStyleWithFrame:style:", ^{
    
    it(@"object not nil after creation", ^{
        ANTableView* table = [ANTableView tableViewDefaultStyleWithFrame:CGRectZero style:UITableViewStylePlain];
        expect(table).notTo.beNil();
    });
});


//describe(@"addStickyFooter:withFixedHeight:", ^{
//   
//    it(@"if tableview height less than screen height", ^{
//        failure(@"Pending");
//    });
//    
//    it(@"handles navigation bar height", ^{
//        failure(@"Pending");
//    });
//    
//    it(@"handles status bar height", ^{
//        failure(@"Pending");
//    });
//});

SpecEnd
