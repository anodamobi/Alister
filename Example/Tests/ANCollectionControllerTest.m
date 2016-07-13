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
    self.listController = [ANCollectionController new];
}

- (void)tearDown
{
    self.listController = nil;
    self.collectionView = nil;
    self.storage = nil;
    
    [super tearDown];
}

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

@end

