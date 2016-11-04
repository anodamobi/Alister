//
//  ANListControllerConfigurationModelInterface.h
//  ANStorage
//
//  Created by Oksana Kovalchuk on 2/2/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

@protocol ANListControllerConfigurationModelInterface <NSObject> //TODO: make it for table

#pragma mark - TableView Settings

@optional

- (UITableViewRowAnimation)insertSectionAnimation;
- (UITableViewRowAnimation)deleteSectionAnimation;
- (UITableViewRowAnimation)reloadSectionAnimation;
- (UITableViewRowAnimation)insertRowAnimation;
- (UITableViewRowAnimation)deleteRowAnimation;
- (UITableViewRowAnimation)reloadRowAnimation;

@end
