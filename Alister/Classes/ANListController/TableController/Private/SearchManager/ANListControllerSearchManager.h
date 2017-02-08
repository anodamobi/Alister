//
//  ANTableControllerSearchManager.h
//  ANStorage
//
//  Created by Oksana Kovalchuk on 2/3/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "Alister.h"

typedef NS_ENUM(NSInteger, ANListControllerSearchScope)
{
    ANListControllerSearchScopeNone = -1,
};

@class ANStorage;

@protocol ANListControllerSearchManagerDelegate <NSObject>

- (void)searchControllerDidCancelSearch;
- (void)searchControllerCreatedStorage:(ANStorage*)searchStorage;
- (ANStorage*)storage;

@end

@interface ANListControllerSearchManager : NSObject <UISearchBarDelegate>

@property (nonatomic, weak) id<ANListControllerSearchManagerDelegate> delegate;
@property (nonatomic, strong, readonly) ANStorage* searchingStorage;
@property (nonatomic, weak) UISearchBar* searchBar;
@property (nonatomic, copy) ANListControllerSearchPredicateBlock searchPredicateConfigBlock; //TODO: configuration

- (instancetype)initWithDelegate:(id<ANListControllerSearchManagerDelegate>)delegate;

- (BOOL)isSearching;

@end
