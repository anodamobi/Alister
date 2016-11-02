//
//  ANListControllerConfigurationModelInterface.h
//  ANStorage
//
//  Created by Oksana Kovalchuk on 2/2/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

@protocol ANListControllerConfigurationModelInterface <NSObject>

@required

- (BOOL)shouldHandleKeyboard;
- (CGFloat)reloadAnimationDuration;

- (NSString*)reloadAnimationKey;
- (void)setReloadAnimationKey:(NSString*)model;


#pragma mark - TableView Settings

@optional

- (BOOL)shouldDisplayHeaderOnEmptySection;
- (BOOL)shouldDisplayFooterOnEmptySection;
- (UITableViewRowAnimation)insertSectionAnimation;
- (UITableViewRowAnimation)deleteSectionAnimation;
- (UITableViewRowAnimation)reloadSectionAnimation;
- (UITableViewRowAnimation)insertRowAnimation;
- (UITableViewRowAnimation)deleteRowAnimation;
- (UITableViewRowAnimation)reloadRowAnimation;

@end
