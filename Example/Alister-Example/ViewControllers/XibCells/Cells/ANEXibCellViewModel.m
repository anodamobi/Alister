//
//  ANEXibCellViewModel.m
//  Alister-Example
//
//  Created by ANODA on 11/18/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANEXibCellViewModel.h"

@interface ANEXibCellViewModel ()

@property (nonatomic, copy) NSString* username;
@property (nonatomic, assign) BOOL activeState;

@end

@implementation ANEXibCellViewModel

+ (instancetype)viewModelWithUsername:(NSString*)username
                       andActiveState:(BOOL)isActive
{
    ANEXibCellViewModel* viewModel = [self new];
    viewModel.username = username;
    viewModel.activeState = isActive;
    
    return viewModel;
}

@end
