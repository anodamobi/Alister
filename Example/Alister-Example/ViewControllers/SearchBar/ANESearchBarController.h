//
//  ANESearchBarController.h
//  Alister-Example
//
//  Created by ANODA on 11/11/16.
//  Copyright © 2016 Oksana Kovalchuk. All rights reserved.
//

#import "ANTableController.h"

@interface ANESearchBarController : ANTableController

- (void)updateWithStorage:(ANStorage*)storage;
- (void)updateWithSearchBar:(UISearchBar*)searchBar;

@end
