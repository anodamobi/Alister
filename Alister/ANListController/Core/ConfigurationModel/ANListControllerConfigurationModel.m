//
//  ANListControllerConfigurationModel.m
//  ANStorage
//
//  Created by Oksana Kovalchuk on 2/2/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "ANListControllerConfigurationModel.h"

@interface ANListControllerConfigurationModel ()

@end

@implementation ANListControllerConfigurationModel

+ (instancetype)defaultModel
{
    ANListControllerConfigurationModel* model = [self new];
    
    model.insertSectionAnimation = UITableViewRowAnimationNone;
    model.deleteSectionAnimation = UITableViewRowAnimationAutomatic;
    model.reloadSectionAnimation = UITableViewRowAnimationAutomatic;
    
    model.insertRowAnimation = UITableViewRowAnimationAutomatic;
    model.deleteRowAnimation = UITableViewRowAnimationAutomatic;
    model.reloadRowAnimation = UITableViewRowAnimationAutomatic;
    
    return model;
}

@end
