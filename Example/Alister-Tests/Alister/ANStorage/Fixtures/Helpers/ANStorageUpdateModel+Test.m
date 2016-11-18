//
//  ANStorageUpdateModel.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 10/9/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANStorageUpdateModel+Test.h"

@implementation ANStorageUpdateModel (Test)

+ (instancetype)filledModel
{
    ANStorageUpdateModel* testModel = [ANStorageUpdateModel new];
    
    [testModel addInsertedSectionIndexes:[NSIndexSet indexSetWithIndex:1]];
    [testModel addUpdatedSectionIndexes:[NSIndexSet indexSetWithIndex:1]];
    [testModel addDeletedSectionIndexes:[NSIndexSet indexSetWithIndex:1]];
    
    [testModel addInsertedIndexPaths:@[[NSIndexPath indexPathWithIndex:0]]];
    [testModel addUpdatedIndexPaths:@[[NSIndexPath indexPathWithIndex:0]]];
    [testModel addDeletedIndexPaths:@[[NSIndexPath indexPathWithIndex:0]]];
    [testModel addMovedIndexPaths:@[[NSIndexPath indexPathWithIndex:0]]];
    
    return testModel;
}

- (BOOL)hasSpecifiedCountOfObjectsInEachProperty:(NSUInteger)expectedCount
{
    BOOL result = YES;
    
    result = (result && (self.deletedRowIndexPaths.count == expectedCount));
    result = (result && (self.insertedRowIndexPaths.count == expectedCount));
    result = (result && (self.updatedRowIndexPaths.count == expectedCount));
    result = (result && (self.movedRowsIndexPaths.count == expectedCount));
    
    result = (result && (self.insertedSectionIndexes.count == expectedCount));
    result = (result && (self.deletedSectionIndexes.count == expectedCount));
    result = (result && (self.updatedSectionIndexes.count == expectedCount));

    return result;
}

@end
