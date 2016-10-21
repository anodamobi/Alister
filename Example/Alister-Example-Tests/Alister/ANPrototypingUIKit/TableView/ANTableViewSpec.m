//
//  ANTableViewTests.m
//  Alister-Example
//
//  Created by Maxim Eremenko on 8/22/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <Alister/ANTableView.h>

@interface ANTableView ()

@property (nonatomic, strong) UIView* stickedContainer;
@property (nonatomic, assign) CGFloat stickedFooterHeight;
@property (nonatomic, strong) UIView* bottomStickedFooterView;
@property (nonatomic, assign) BOOL additionalContentSizeAdded;

@end

SpecBegin(ANTableView)

describe(@"tableViewDefaultStyleWithFrame:style:", ^{
    
    it(@"object not nil after creation", ^{
        ANTableView* table = [ANTableView tableViewDefaultStyleWithFrame:CGRectZero style:UITableViewStylePlain];
        expect(table).notTo.beNil();
    });
});

describe(@"addStickyFooter:withFixedHeight:", ^{
    
    __block ANTableView* tableView = nil;
    
    beforeEach(^{
        tableView = [ANTableView tableViewDefaultStyleWithFrame:CGRectZero style:UITableViewStylePlain];
    });
    
    it(@"should set bottomStickedFooterView correctly", ^{
        UIView* footerView = [UIView new];
        [tableView addStickyFooter:footerView withFixedHeight:0];
        expect(tableView.bottomStickedFooterView).notTo.beNil();
    });
    
    it(@"no assert if bottomStickedFooterView is nil", ^{
        void(^block)() = ^() {
            [tableView addStickyFooter:nil withFixedHeight:0];
        };
        expect(block).notTo.raiseAny();
    });
    
    it(@"should set stickedFooterHeight correctly", ^{
        CGFloat footerHeight = 50;
        UIView* footerView = [UIView new];
        [tableView addStickyFooter:footerView withFixedHeight:footerHeight];
        expect(tableView.stickedFooterHeight).equal(footerHeight);
    });
    
    it(@"should set correct frame for stickedContainer", ^{
        tableView = [ANTableView tableViewDefaultStyleWithFrame:[UIScreen mainScreen].bounds
                                                          style:UITableViewStylePlain];
        CGFloat footerHeight = 50;
        UIView* footerView = [UIView new];
        [tableView addStickyFooter:footerView withFixedHeight:footerHeight];
        [tableView setNeedsLayout];
        expect(tableView.stickedFooterHeight).equal(footerHeight);
    });

    afterEach(^{
        tableView = nil;
    });
});

SpecEnd
