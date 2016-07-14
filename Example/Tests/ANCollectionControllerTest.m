//
//  ANCollectionControllerTest.m
//  Alister
//
//  Created by Oksana Kovalchuk on 7/2/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ANStorage.h"
#import "ANCollectionController.h"
#import "ANCollectionViewCell.h"
#import <Expecta/Expecta.h>

@interface ANCollectionControllerTest : XCTestCase

@property (nonatomic, strong) ANStorage* storage;
@property (nonatomic, strong) ANCollectionController* listController;
@property (nonatomic, strong) UICollectionView* collectionView;

@end

@implementation ANCollectionControllerTest

- (void)setUp
{
    [super setUp];
    
    self.storage = [ANStorage new];
    
    UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc] init];
    CGRect screenRect = [UIScreen mainScreen].bounds;
    self.collectionView = [[UICollectionView alloc] initWithFrame:screenRect collectionViewLayout:flowLayout];
    self.listController = [ANCollectionController controllerWithCollectionView:self.collectionView];
    [self.listController attachStorage:self.storage];
}

- (void)tearDown
{
    self.listController = nil;
    self.collectionView = nil;
    self.storage = nil;
    
    [super tearDown];
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-retain-cycles"

- (void)test_attachStorage_positive_currentStorageNotNil
{
    //given
    ANCollectionController* listController = [ANCollectionController new];
    ANStorage* storage = [ANStorage new];
    
    //when
    [listController attachStorage:storage];
    
    //then
    XCTAssertNotNil(listController.currentStorage);
    XCTAssertEqualObjects(listController.currentStorage, storage);
}

- (void)test_attachStorage_negative_attachStorageWithNil
{
    //given
    ANCollectionController* listController = [ANCollectionController new];
    ANStorage* storage = nil;
    //when
    [listController attachStorage:storage];
    
    XCTAssertNil(listController.currentStorage);
    
}

- (void)test_configureItemSelectionBlock_positive_selectItemsWithConfiguredIndexPath
{
    //given
    NSString* testModel = @"Mock";
    
    [self.listController configureCellsWithBlock:^(id<ANListControllerReusableInterface> configurator) {
        [configurator registerCellClass:[ANCollectionViewCell class] forSystemClass:[NSString class]];
    }];
    
    //when
    XCTestExpectation *expectation = [self expectationWithDescription:@"configureItemSelectionBlock called"];
    __weak typeof(self) welf = self;
    
    [self.listController configureItemSelectionBlock:^(id model, NSIndexPath *indexPath) {
        [expectation fulfill];
        XCTAssertEqualObjects(model, testModel);
        XCTAssertEqual(indexPath.row, 0);
        XCTAssertEqual(indexPath.section, 0);
    }];
    
    [self.listController addUpdatesFinsihedTriggerBlock:^{
        [welf.listController collectionView:welf.collectionView
                   didSelectItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    }];

    [self.storage updateWithAnimationWithBlock:^(id<ANStorageUpdatableInterface> storageController) {
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
        [configurator registerCellClass:[ANCollectionViewCell class] forSystemClass:[NSString class]];
    }];
    
    //when
    XCTestExpectation *expectation = [self expectationWithDescription:@"configureItemSelectionBlock called"];
    __weak typeof(self) welf = self;
    
    [self.listController configureItemSelectionBlock:^(id model, NSIndexPath *indexPath) {
        XCTAssertNil(model);
        XCTAssertEqualObjects(indexPath, selectedIndexPath);
        [expectation fulfill];
    }];
    
    [self.listController addUpdatesFinsihedTriggerBlock:^{
        [welf.listController collectionView:welf.collectionView
                   didSelectItemAtIndexPath:selectedIndexPath];
    }];
    
    [self.storage updateWithoutAnimationWithBlock:^(id<ANStorageUpdatableInterface> storageController) {
        [storageController addItem:testModel];
    }];
    
    //then
    [self waitForExpectationsWithTimeout:0.1 handler:nil];
}

- (void)test_updateConfigurationModelWithBlock_positive_configurationModelShouldHandleKeyboardAndEmptySectionWithNO
{
    //given
    XCTestExpectation *expectation = [self expectationWithDescription:@"updateConfigurationModelWithBlock called"];
    
    //when
    [self.listController updateConfigurationModelWithBlock:^(ANListControllerConfigurationModel *configurationModel) {
        configurationModel.shouldHandleKeyboard = NO;
        configurationModel.shouldDisplayHeaderOnEmptySection = NO;
    }];
    
    [self.listController updateConfigurationModelWithBlock:^(ANListControllerConfigurationModel *configurationModel) {
        XCTAssertFalse(configurationModel.shouldHandleKeyboard);
        XCTAssertFalse(configurationModel.shouldDisplayHeaderOnEmptySection);
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
        [configurator registerCellClass:[ANCollectionViewCell class] forSystemClass:[NSString class]];
    }];
    
    //when
    __block XCTestExpectation *expectation = [self expectationWithDescription:@"testAddUpdatesFinsihedTriggerBlock"];
    
    [self.listController addUpdatesFinsihedTriggerBlock:^{
        [expectation fulfill];
    }];
    
    [self.storage updateWithoutAnimationWithBlock:^(id<ANStorageUpdatableInterface> storageController) {
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
    XCTAssertNotNil(self.listController.searchBar);
    XCTAssertEqualObjects(self.listController.searchBar, searchBar);
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

- (void)test_createControllerWithCollectionView_positive_expectSetupedANdNotNil
{
    //when
    ANCollectionController* collectionController = [ANCollectionController controllerWithCollectionView:self.collectionView];
    
    //then
    XCTAssertNotNil(collectionController.collectionView);
    XCTAssertEqualObjects(collectionController.collectionView, self.collectionView);
}

- (void)test_createControllerWithCollectionView_negative_collectionViewIsNilAndExpectedExeption
{
    //when
    void(^testBlock)() = ^{
        __unused ANCollectionController* tc = [ANCollectionController controllerWithCollectionView:nil];
    };
    
    //then
    XCTAssertThrows(testBlock());
}

- (void)test_numberOfSectionsInCollectionView_positive_addedTwoSectionSuccessfull
{
    //given
    XCTestExpectation *expectation = [self expectationWithDescription:@"testNumberOfSectionsInTableView"];
    __weak typeof(self) welf = self;
    
    [self.listController configureCellsWithBlock:^(id<ANListControllerReusableInterface> configurator) {
        [configurator registerCellClass:[ANCollectionViewCell class] forSystemClass:[NSString class]];
    }];
    
    //when
    [self.storage updateWithoutAnimationWithBlock:^(id<ANStorageUpdatableInterface> storageController) {
        [storageController addItem:@"test"];
        [storageController addItem:@"test1" toSection:1];
    }];
    
    //then
//    @weakify(self);
    [self.listController addUpdatesFinsihedTriggerBlock:^{
//        @strongify(self);
        [expectation fulfill];
        NSInteger sectionCount = [welf.listController numberOfSectionsInCollectionView:welf.collectionView];
        XCTAssertEqual(sectionCount, 2);
    }];
    [self waitForExpectationsWithTimeout:0.1 handler:nil];
}

- (void)test_numberOfRowsInSection_positive_addedItemsToFirstSection
{
    //given
    XCTestExpectation *expectation = [self expectationWithDescription:@"testNumberOfRowsInSection"];
    __weak typeof(self) welf = self;
    
    [self.listController configureCellsWithBlock:^(id<ANListControllerReusableInterface> configurator) {
        [configurator registerCellClass:[ANCollectionViewCell class] forSystemClass:[NSString class]];
    }];
    
    //when
    [self.storage updateWithoutAnimationWithBlock:^(id<ANStorageUpdatableInterface> storageController) {
        [storageController addItem:@"test"];
        [storageController addItem:@"test1" toSection:0];
        [storageController addItem:@"test3" atIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    }];
    
    //then
    
    [self.listController addUpdatesFinsihedTriggerBlock:^{
        [expectation fulfill];
        NSInteger listControllerSectionRowsNumber = [welf.listController collectionView:welf.collectionView numberOfItemsInSection:0];
        NSInteger dataSourceRowsNumber = [welf.collectionView.dataSource collectionView:welf.collectionView numberOfItemsInSection:0];
        XCTAssertEqual(listControllerSectionRowsNumber, 3);
        XCTAssertEqual(dataSourceRowsNumber, 3);
    }];
    [self waitForExpectationsWithTimeout:0.1 handler:nil];
}

- (void)test_didSelectRowAtIndexPath_positive_selectedIndexPathNotNil
{
    //given
    NSIndexPath* selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    NSString* testModel = @"Mock";
    
    [self.listController configureCellsWithBlock:^(id<ANListControllerReusableInterface> configurator) {
        [configurator registerCellClass:[ANCollectionViewCell class] forSystemClass:[NSString class]];
    }];
    
    //when
    XCTestExpectation *expectation = [self expectationWithDescription:@"testDidSelectRowAtIndexPath called"];
    __weak typeof(self) welf = self;
    
    [self.listController configureItemSelectionBlock:^(id model, NSIndexPath *indexPath) {
        XCTAssertEqualObjects(selectedIndexPath, indexPath);
        [expectation fulfill];
    }];
    
    [self.listController addUpdatesFinsihedTriggerBlock:^{
        [welf.collectionView.delegate collectionView:welf.collectionView didSelectItemAtIndexPath:selectedIndexPath];
    }];
    
    [self.storage updateWithoutAnimationWithBlock:^(id<ANStorageUpdatableInterface> storageController) {
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
        [configurator registerCellClass:[ANCollectionViewCell class] forSystemClass:[NSString class]];
    }];
    
    //when
    
    void(^testBlock)() = ^{
        XCTestExpectation *expectation = [self expectationWithDescription:@"expectationNotExistIndexPath"];
        __weak typeof(self) welf = self;
        
        [self.listController configureItemSelectionBlock:^(id model, NSIndexPath *indexPath) {
            XCTAssertEqualObjects(notExistIndexPath, indexPath);
            [expectation fulfill];
        }];
        
        [self.listController addUpdatesFinsihedTriggerBlock:^{
            [welf.collectionView.delegate collectionView:welf.collectionView didSelectItemAtIndexPath:notExistIndexPath];
        }];
        
        [self.storage updateWithoutAnimationWithBlock:^(id<ANStorageUpdatableInterface> storageController) {
            [storageController addItem:testModel];
        }];
        
    };
    
    //then
    XCTAssertNoThrow(testBlock());
    [self waitForExpectationsWithTimeout:0.1 handler:nil];
}

#pragma clang diagnostic pop

@end

