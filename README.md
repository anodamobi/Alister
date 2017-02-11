# Alister

[![Build Status](https://www.bitrise.io/app/b900e8f15eea0533.svg?token=0Tm7DECAACkx3RBavbgllA)](https://www.bitrise.io/app/b900e8f15eea0533)
[![Version](https://img.shields.io/cocoapods/v/Alister.svg?style=flat)](http://cocoapods.org/pods/Alister)
[![License](https://img.shields.io/cocoapods/l/Alister.svg?style=flat)](http://cocoapods.org/pods/Alister)
[![Platform](https://img.shields.io/cocoapods/p/Alister.svg?style=flat)](http://cocoapods.org/pods/Alister)
[![codecov](https://codecov.io/gh/anodamobi/Alister/branch/master/graph/badge.svg)](https://codecov.io/gh/anodamobi/Alister)
[![codebeat badge](https://codebeat.co/badges/0ffd0e1d-727c-424c-95e6-0ea578eb8fb0)](https://codebeat.co/projects/github-com-anodamobi-alister)


# Overview
`Alister` allows to manage the content of any `UITableView` or `UICollectionView`.
The general idea is provide a layer that synchronizes data with the cell appearance for such operations like adding, moving, deleting and reordering.
Alister automatically handle `UITableView` and `UICollectionView` data source and delegates protocols and you can override them by subclassing from base controllers.

# Features
- Works with `UITableView` and `UICollectionView`
- Supports all operations for sections and rows such as `Insert`, `Delete`, `Move`, `Reload`
- Supports `UISearchBar` and provide search predicate
- Supports custom header and footer views
- Provides keyboard handling
- Provides bottom sticked footer as part of `ANTableView`
# Usage
#### Initialize storage and list controller
Use `ANTableController` and `ANCollectionController` for `UITableView` and `UICollectionView` respectively.

```objc
self.storage = [ANStorage new];
self.tableController = [ANTableController controllerWithTableView:self.tableView];
[self.tableController attachStorage:self.storage];
self.collectionController = [ANCollectionController controllerWithCollectionView:self.collectionView];
[self.collectionController attachStorage:self.storage];
```

#### Register cell, header and footer views for models
You can register any views for any model classes.
```objc
[self.controller configureCellsWithBlock:^(id<ANListControllerReusableInterface> configurator) {

[configurator registerCellClass:[ANBaseTableViewCell class]
forModelClass:[ANBaseTableViewCellViewModel class]];

[configurator registerFooterClass:[ANBaseTableFooterView class]
forModelClass:[NSString class]];

[configurator registerHeaderClass:[ANBaseTableHeaderView class]
forModelClass:[NSString class]];
}];
```

#### Add models to `ANStorage`
```objc
NSArray* models = [self generateModels];
[self.storage updateWithoutAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
[storageController addItems:models]; // items will be added to a first section by default
[storageController addItems:models toSection:10];
[storageController addItem:@"Title" atIndexPath:indexPath];
// Supplementary models
[storageController updateSectionHeaderModel:headerTitle forSectionIndex:0];
[storageController updateSectionFooterModel:footerTitle forSectionIndex:0];
}];
```
#### And that`s all!
//TODO: add photos

#### Changing cells order
`Alister` will change order of cells and models in storage automatically.
Or you can change it manually:
```objc
[self.storage updateWithAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
[storageController moveItemFromIndexPath:fromIndexPath toIndexPath:toIndexPath];
}];
```
//TODO: add gif

#### Models search with `UISearchBar`
`Alister` provides an ablility to search in storage.
To use it, search bar and search predicate block must be set:
```objc
[self.controller attachSearchBar:self.searchBar];
[self.controller updateSearchingPredicateBlock:[self predicateBlock]];
```
Where search predicate block is:
```objc
- (ANListControllerSearchPredicateBlock)predicateBlock
{
return ^NSPredicate* (NSString* searchString, NSInteger scope) {

NSPredicate* predicate = nil;
if (searchString)
{
predicate = [NSPredicate predicateWithFormat:@"self BEGINSWITH[cd] %@", searchString];
}

return predicate;
};
}
```
//TODO: add photo
#### Item selection
Provide `configureItemSelectionBlock:` block for handling default cells selection.
```objc
[self.controller configureItemSelectionBlock:^(id model, NSIndexPath *indexPath) {
    //Handle selection
}];
```
#### Custom header and footer views
Provide custom header and footer for list views.
```objc
[self.storage updateWithAnimationChangeBlock:^(id<ANStorageUpdatableInterface> storageController) {
    [storageController updateSectionHeaderModel:@"I'm header section 0" forSectionIndex:0];
    [storageController updateSectionFooterModel:@"I'm footer section 0" forSectionIndex:0];
}];
```
//TODO: collection view supplementary views screen.
#### Table sticked footer
`ANTableView` provides an ability to set custom sticked footer.
```objc
[self.tableView addStickyFooter:self.footerView withFixedHeight:100];
[self.tableView updateStickerHeight:200];
```
//TODO: add photo sticked footer

#### Demo
See projects example or use it by web (Appetize.io link)
To run the example project, clone the repo or download, and run `pod install` from the Example directory first.

## Requirements
Xcode 7.2 or higher
iOS 9 or higher

## Installation
Alister is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:
```ruby
pod "Alister"
```

## Changelog

### 0.2 

renamed methods in ANStorage:
- setHeaderModel: sectionIndex: 
- setFooterModel: sectionIndex: 

to update ... model

## Author
Oksana Kovalchuk, oksana@anoda.mobi
## License
Alister is available under the MIT license. See the LICENSE file for more info.