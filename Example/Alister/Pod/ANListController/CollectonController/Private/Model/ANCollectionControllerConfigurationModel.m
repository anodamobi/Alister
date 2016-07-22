//
//  ANCollectionControllerConfigurationModel.m
//  ANStorage
//
//  Created by Oksana Kovalchuk on 2/3/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "ANCollectionControllerConfigurationModel.h"

@implementation ANCollectionControllerConfigurationModel

+ (instancetype)defaultModel
{
    ANCollectionControllerConfigurationModel* model = [self new];
    model.isHandlingKeyboard = YES;
    model.reloadAnimationDuration = 0.25;
    model.reloadAnimationKey = @"UICollectionViewReloadDataAnimationKey";
    
    return model;
}

@end
