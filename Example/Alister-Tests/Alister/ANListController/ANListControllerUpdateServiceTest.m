//
//  ANListControllerUpdateServiceTest.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 11/16/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ANListControllerUpdateServiceFixture.h"
#import "ANListViewFixture.h"

@interface ANListControllerUpdateServiceTest : XCTestCase

@property (nonatomic, strong) ANListControllerUpdateServiceFixture* updateService;
@property (nonatomic, strong) ANListViewFixture* listView;

@end

@implementation ANListControllerUpdateServiceTest

- (void)setUp
{
    [super setUp];
    
    self.listView = [ANListViewFixture new];
    self.updateService = [[ANListControllerUpdateServiceFixture alloc] initWithListView:self.listView];
}

- (void)tearDown
{
    [super tearDown];
    
    self.updateService = nil;
}


- (void)test_initWithListView_shouldHaveListView
{
    expect(self.updateService.listView).equal(self.listView);
}


- (void)test_storageDidPerformUpdate_shouldAddUpdateOperation
{
    
}






//- (void)storageNeedsReloadWithIdentifier:(NSString*)identifier animated:(BOOL)shouldAnimate;

@end
