//
//  ANListControllerConfigurationModel.h
//  ANStorage
//
//  Created by Oksana Kovalchuk on 2/2/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "ANListControllerConfigurationModelInterface.h"

@interface ANListControllerConfigurationModel : NSObject <ANListControllerConfigurationModelInterface>

@property (nonatomic, assign) BOOL shouldHandleKeyboard;

@property (nonatomic, assign) CGFloat reloadAnimationDuration;
@property (nonatomic, copy) NSString* reloadAnimationKey;

@property (nonatomic, assign) BOOL shouldDisplayHeaderOnEmptySection;
@property (nonatomic, assign) BOOL shouldDisplayFooterOnEmptySection;

@property (nonatomic, assign) UITableViewRowAnimation insertSectionAnimation;
@property (nonatomic, assign) UITableViewRowAnimation deleteSectionAnimation;
@property (nonatomic, assign) UITableViewRowAnimation reloadSectionAnimation;
@property (nonatomic, assign) UITableViewRowAnimation insertRowAnimation;
@property (nonatomic, assign) UITableViewRowAnimation deleteRowAnimation;
@property (nonatomic, assign) UITableViewRowAnimation reloadRowAnimation;

@property (nonatomic, strong) NSString* defaultHeaderSupplementary;
@property (nonatomic, strong) NSString* defaultFooterSupplementary;

@property (nonatomic, assign) CGFloat defaultAnimationDuration;

+ (instancetype)defaultModel;

@end
