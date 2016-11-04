//
//  ANTableControllerSearchManager.h
//  ANStorage
//
//  Created by Oksana Kovalchuk on 2/3/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

@class ANStorage;

@protocol ANListControllerSearchManagerDelegate <NSObject>

- (void)searchControllerDidCancelSearch;
- (void)searchControllerCreatedStorage:(ANStorage*)searchStorage;
- (ANStorage*)storage;

@end

@interface ANListControllerSearchManager : NSObject

@property (nonatomic, weak) id<ANListControllerSearchManagerDelegate> delegate;
@property (nonatomic, strong, readonly) ANStorage* searchingStorage;
@property (nonatomic, weak) UISearchBar* searchBar;

- (BOOL)isSearching;

@end
