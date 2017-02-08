//
//  ANListControllerCollectionViewWrapper.h
//  ANStorage
//
//  Created by Oksana Kovalchuk on 2/2/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "ANListViewInterface.h"

@interface ANListCollectionView : NSObject <ANListViewInterface>

+ (instancetype)wrapperWithCollectionView:(UICollectionView*)collectionView;

@end
