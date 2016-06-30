//
//  ANTableControllerSearchManager.h
//  ANStorage
//
//  Created by Oksana Kovalchuk on 2/3/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

@protocol ANListControllerSearchManagerDelegate <NSObject>

- (void)searchControllerDidCancelSearch;
- (void)searchControllerRequiresStorageWithSearchString:(NSString*)searchString andScope:(NSInteger)scope;

@end

@interface ANListControllerSearchManager : NSObject <UISearchBarDelegate>

@property (nonatomic, weak) id<ANListControllerSearchManagerDelegate> delegate;

- (BOOL)isSearching;

@end
