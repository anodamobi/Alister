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

+ (instancetype)viewModelWithSegmentTitles:(NSArray*)segmentTitles
{
    ANECustomHeaderViewModel* model = [self new];
    model.segmentTitles = segmentTitles;
    
    return model;
}

- (void)itemSelectedWithIndex:(NSUInteger)index
{
    [self.delegate headerViewModelIndexUpdatedTo:index onModel:self];
}


#pragma mark - Private

- (void)setDelegate:(id<ANECustomHeaderViewModelDelegate>)delegate
{
    if ([delegate conformsToProtocol:@protocol(ANECustomHeaderViewModelDelegate)] || !delegate)
    {
        _delegate = delegate;
    }
    else
    {
        NSAssert(NO, @"Object - %@ must conform to protocol %@",
                 delegate, NSStringFromProtocol(@protocol(ANECustomHeaderViewModelDelegate)));
    }
}

@end
