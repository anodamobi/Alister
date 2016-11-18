//
//  ANListControllerTest.m
//  Alister
//
//  Created by Oksana Kovalchuk on 7/2/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANTableController.h"
#import "ANStorage.h"
#import "ANTestTableCell.h"
#import "ANTestTableHeaderFooter.h"

@interface ANTableControllerTest : XCTestCase

@property (nonatomic, strong) ANStorage* storage;
@property (nonatomic, strong) UITableView* tw;
@property (nonatomic, strong) ANTableController* listController;

@end

@implementation ANTableControllerTest

- (void)setUp
{
    [super setUp];
    
    self.storage = [ANStorage new];
    self.tw = [UITableView new];
    self.tw.sectionHeaderHeight = 30;
    self.tw.sectionFooterHeight = 30;
    self.listController = [ANTableController controllerWithTableView:self.tw];
    [self.listController attachStorage:self.storage];
}

- (void)tearDown
{//TODO: zoombie
    self.listController = nil;
    self.tw = nil;
    self.storage = nil;
    
    [super tearDown];
}


#pragma mark - 

- (void)test_updateWithoutAnimationChangeBlock_positive_storageContainsAddedItems
{
    // given
    NSArray* items = @[@"test1", @"test2"];
    
    [self.listController configureCellsWithBlock:^(id<ANListControllerReusableInterface> configurator) {
        [configurator registerCellClass:[ANTestTableCell class] forModelClass:[NSString class]];
    }];
    
    // then
    XCTestExpectation* expectation = [self expectationWithDescription:@"updateWithoutAnimationChangeBlock called"];
    
    __weak typeof(self) welf = self;
    [self.listController addUpdatesFinsihedTriggerBlock:^{
        
        __strong typeof(welf) strongSelf = welf;
        ANStorageSectionModel* section = strongSelf.storage.sections.firstObject;
        expect(section.objects).to.haveCount(items.count);
        
        [expectation fulfill];
    }];
    
    [self.storage updateWithoutAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
        [storageController removeAllItemsAndSections];
        [storageController addItems:items toSection:0];
    }];
    
    [self waitForExpectationsWithTimeout:0.1 handler:nil];
}

- (void)test_attachStorage_positive_currentStorageNotNil
{
    //given
    ANTableController* listController = [ANTableController new];
    ANStorage* storage = [ANStorage new];
    //when
    [listController attachStorage:storage];
    //then
    expect(listController.currentStorage).notTo.beNil;
    expect(listController.currentStorage).equal(storage);
}

- (void)test_attachStorage_negative_attachStorageWithNil
{
    //given
    ANTableController* listController = [ANTableController new];

    //when
    [listController attachStorage:nil];
    
    //then
    XCTAssertNil(listController.currentStorage);
}

- (void)test_configureItemSelectionBlock_positive_selectItemsWithConfiguredIndexPath
{
    //given
    NSString* testModel = @"Mock";
    
    [self.listController configureCellsWithBlock:^(id<ANListControllerReusableInterface> configurator) {
        [configurator registerCellClass:[ANTestTableCell class] forModelClass:[NSString class]];
    }];
    
    //when
    XCTestExpectation* expectation = [self expectationWithDescription:@"configureItemSelectionBlock called"];
    __weak typeof(self) welf = self;
    
    [self.listController configureItemSelectionBlock:^(id model, NSIndexPath* indexPath) {
        [expectation fulfill];
        expect(model).equal(testModel);
        expect(indexPath.row).equal(0);
        expect(indexPath.section).equal(0);
    }];
    
    [self.listController addUpdatesFinsihedTriggerBlock:^{
        __strong typeof(welf) strongSelf = welf;
        [strongSelf.listController tableView:strongSelf.tw
               didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    }];
    
    [self.storage updateWithoutAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
        [storageController addItem:testModel];
    }];
    
    //then
    [self waitForExpectationsWithTimeout:0.1 handler:nil];
}

- (void)test_configureItemSelectionBlock_negative_selectItemsWithWrongConfiguredIndexPathExpectedNilSelectedModel
{
    //given
    NSString* testModel = @"Mock";
    NSIndexPath* selectedIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    
    [self.listController configureCellsWithBlock:^(id<ANListControllerReusableInterface> configurator) {
        [configurator registerCellClass:[ANTestTableCell class] forModelClass:[NSString class]];
    }];
    
    //when
    XCTestExpectation* expectation = [self expectationWithDescription:@"configureItemSelectionBlock called"];
    __weak typeof(self) welf = self;
    
    [self.listController configureItemSelectionBlock:^(id model, NSIndexPath* indexPath) {
        XCTAssertNil(model);
        XCTAssertEqualObjects(indexPath, selectedIndexPath);
        [expectation fulfill];
    }];
    
    [self.listController addUpdatesFinsihedTriggerBlock:^{
        __strong typeof(welf) strongSelf = welf;
        [strongSelf.listController tableView:strongSelf.tw
               didSelectRowAtIndexPath:selectedIndexPath];
    }];
    
    [self.storage updateWithoutAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
        [storageController addItem:testModel];
    }];
    
    //then
    [self waitForExpectationsWithTimeout:0.1 handler:nil];
}

- (void)test_updateConfigurationModelWithBlock_positive_configurationModelShouldHandleKeyboardAndEmptySectionWithNO
{
    //given
    XCTestExpectation* expectation = [self expectationWithDescription:@"updateConfigurationModelWithBlock called"];

    //when
    [self.listController updateConfigurationModelWithBlock:^(ANListControllerConfigurationModel* configurationModel) {
        configurationModel.shouldHandleKeyboard = NO;
        configurationModel.shouldDisplayHeaderOnEmptySection = NO;
    }];
    
    [self.listController updateConfigurationModelWithBlock:^(ANListControllerConfigurationModel* configurationModel) {
        expect(configurationModel.shouldHandleKeyboard).beFalsy();
        expect(configurationModel.shouldDisplayHeaderOnEmptySection).beFalsy();
        [expectation fulfill];
    }];
    
    //then
    [self waitForExpectationsWithTimeout:0.1 handler:nil];
}

- (void)test_addUpdatesFinsihedTriggerBlock_afterUpdateStorageBlockTriggered
{
    //given
    NSString* testModel = @"Mock";
    
    [self.listController configureCellsWithBlock:^(id<ANListControllerReusableInterface> configurator) {
        [configurator registerCellClass:[ANTestTableCell class] forModelClass:[NSString class]];
    }];
    
    //when
    __block XCTestExpectation* expectation = [self expectationWithDescription:@"testAddUpdatesFinsihedTriggerBlock"];
    
    [self.listController addUpdatesFinsihedTriggerBlock:^{
        [expectation fulfill];
    }];
    
    [self.storage updateWithoutAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
        [storageController addItem:testModel];
    }];
    
    //then
    [self waitForExpectationsWithTimeout:0.1 handler:nil];
}

- (void)test_attachSearchBar_positive_searchBarNotEqualNilAfterAttach
{
    //given
    UISearchBar* searchBar = [UISearchBar new];
    //when
    [self.listController attachSearchBar:searchBar];
    //then
    expect(self.listController.searchBar).notTo.beNil();
    expect(self.listController.searchBar).equal(searchBar);
}

- (void)test_attachSearchBar_negative_attachSearchBarAsNilObject
{
    //given
    UISearchBar* searchBar = nil;
    
    //when
    [self.listController attachSearchBar:searchBar];
    
    //then
    XCTAssertNil(self.listController.searchBar);
}

- (void)test_createControllerWithTableView_positive_expectSetupedANdNotNil
{
    //when
    ANTableController* tc = [ANTableController controllerWithTableView:self.tw];
    //then
    expect(tc.tableView).notTo.beNil();
    expect(tc.tableView).equal(self.tw);
}

- (void)test_createControllerWithTableView_negative_tableViewIsNilAndExpectedExeption
{
    //when
    void(^testBlock)() = ^{
       __unused ANTableController* tc = [ANTableController controllerWithTableView:nil];
    };
    
    //then
    XCTAssertThrows(testBlock());
}

- (void)test_initWithTableView_positive_tableViewNotNilInController
{
    //when
    ANTableController* tc = [[ANTableController alloc] initWithTableView:self.tw];
    
    //then
    expect(tc.tableView).notTo.beNil();
    expect(tc.tableView).equal(self.tw);
}

- (void)test_initWithTableView_negative_tableViewIsNilAndThrowException
{
    //when
    void(^testBlock)() = ^{
       __unused ANTableController* tc = [[ANTableController alloc] initWithTableView:nil];
     };
    
    XCTAssertThrows(testBlock());
}


#pragma mark - UITableView Protocols Implementation
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-retain-cycles"

- (void)test_numberOfSectionsInTableView_positive_addedTwoSectionSuccessfull
{
    //given
    XCTestExpectation* expectation = [self expectationWithDescription:@"testNumberOfSectionsInTableView"];
    __weak typeof(self) welf = self;
    
    [self.listController configureCellsWithBlock:^(id<ANListControllerReusableInterface> configurator) {
        [configurator registerCellClass:[ANTestTableCell class] forModelClass:[NSString class]];
    }];
    
    //when
    [self.storage updateWithoutAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
        [storageController addItem:@"test"];
        [storageController addItem:@"test1" toSection:1];
    }];
    
    //then
    [self.listController addUpdatesFinsihedTriggerBlock:^{
        __strong typeof(welf) strongSelf = welf;
        [expectation fulfill];
        expect([strongSelf.listController numberOfSectionsInTableView:strongSelf.tw]).equal(2);
    }];
    [self waitForExpectationsWithTimeout:0.1 handler:nil];
}

- (void)test_numberOfSectionsInTableView_positive_addedItemToSecondSectionAndThenCreatedTwoSections
{
    //give
    
    NSInteger updatedSectionIndex = 2;
    NSInteger expectedSectionCount = 3;
    
    XCTestExpectation* expectation = [self expectationWithDescription:@"testAddedItemToSecondSection"];
    
    __weak typeof(self) welf = self;
    
    [self.listController configureCellsWithBlock:^(id<ANListControllerReusableInterface> configurator) {
        [configurator registerCellClass:[ANTestTableCell class] forModelClass:[NSString class]];
    }];
    
    //when
    [self.storage updateWithoutAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
        [storageController addItem:@"test" toSection:updatedSectionIndex];
    }];
    
    //then
    [self.listController addUpdatesFinsihedTriggerBlock:^{
        __strong typeof(welf) strongSelf = welf;
        NSInteger sectionIndex = [strongSelf.listController numberOfSectionsInTableView:self.tw];
        XCTAssertEqual(sectionIndex, expectedSectionCount);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:0.1 handler:nil];
}

- (void)test_numberOfRowsInSection_positive_addedItemsToFirstSection
{
    //given
    XCTestExpectation* expectation = [self expectationWithDescription:@"testNumberOfRowsInSection"];
    __weak typeof(self) welf = self;
    
    [self.listController configureCellsWithBlock:^(id<ANListControllerReusableInterface> configurator) {
        [configurator registerCellClass:[ANTestTableCell class] forModelClass:[NSString class]];
    }];
    
    //when
    [self.storage updateWithoutAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
        [storageController addItem:@"test"];
        [storageController addItem:@"test1" toSection:0];
        [storageController addItem:@"test3" atIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    }];
    
    //then
    [self.listController addUpdatesFinsihedTriggerBlock:^{
        [expectation fulfill];
        __strong typeof(welf) strongSelf = welf;
        expect([strongSelf.listController tableView:self.tw numberOfRowsInSection:0]).equal(3);
        expect([strongSelf.tw.dataSource tableView:self.tw numberOfRowsInSection:0]).equal(3);
    }];
    [self waitForExpectationsWithTimeout:0.1 handler:nil];
}

- (void)test_didSelectRowAtIndexPath_positive_selectedIndexPathNotNil
{
    //given
    NSIndexPath* selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    NSString* testModel = @"Mock";
    
    [self.listController configureCellsWithBlock:^(id<ANListControllerReusableInterface> configurator) {
        [configurator registerCellClass:[ANTestTableCell class] forModelClass:[NSString class]];
    }];
    
    //when
    XCTestExpectation* expectation = [self expectationWithDescription:@"testDidSelectRowAtIndexPath called"];
    __weak typeof(self) welf = self;
    
    [self.listController configureItemSelectionBlock:^(__unused id model, NSIndexPath* indexPath) {
        XCTAssertEqualObjects(selectedIndexPath, indexPath);
        [expectation fulfill];
    }];
    
    [self.listController addUpdatesFinsihedTriggerBlock:^{
        __strong typeof(welf) strongSelf = welf;
        [strongSelf.tw.delegate tableView:self.tw didSelectRowAtIndexPath:selectedIndexPath];
    }];
    
    [self.storage updateWithoutAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
        [storageController addItem:testModel];
    }];
    
    //then
    [self waitForExpectationsWithTimeout:0.1 handler:nil];
}

- (void)test_didSelectedRowAnIndexPath_negative_withNotExistedIndexPath
{
    //given
    NSIndexPath* notExistIndexPath = nil;
    NSString* testModel = @"test model";
    
    [self.listController configureCellsWithBlock:^(id<ANListControllerReusableInterface> configurator) {
        [configurator registerCellClass:[ANTestTableCell class] forModelClass:[NSString class]];
    }];
    
    //when
    
    void(^testBlock)() = ^{
        XCTestExpectation* expectation = [self expectationWithDescription:@"expectationNotExistIndexPath"];
        __weak typeof(self) welf = self;
        
        [self.listController configureItemSelectionBlock:^(__unused id model, NSIndexPath* indexPath) {
            XCTAssertEqualObjects(notExistIndexPath, indexPath);
            [expectation fulfill];
        }];
        
        [self.listController addUpdatesFinsihedTriggerBlock:^{
            __strong typeof(welf) strongSelf = welf;
            [strongSelf.tw.delegate tableView:self.tw didSelectRowAtIndexPath:notExistIndexPath];
        }];
        
        [self.storage updateWithoutAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
            [storageController addItem:testModel];
        }];
        
    };
    
    //then
    XCTAssertNoThrow(testBlock());
    [self waitForExpectationsWithTimeout:0.1 handler:nil];
}


#pragma clang diagnostic pop

@end
