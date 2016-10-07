//
//  ANECustomHeaderViewModel.m
//  Alister-Example
//
//  Created by Oksana Kovalchuk on 10/7/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANECustomHeaderViewModel.h"

@interface ANECustomHeaderViewModel ()

@property (nonatomic, strong) NSArray* segmentTitles;

@end

@implementation ANECustomHeaderViewModel

- (void)itemSelectedWithIndex:(NSUInteger)index
{
    [self.delegate headerViewModelIndexUpdatedTo:index onModel:self];
}

@end
