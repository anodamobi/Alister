//
//  ANListControllerReusableLoadInterface.h
//  ANStorage
//
//  Created by Oksana Kovalchuk on 2/2/16.
//  Copyright © 2016 ANODA. All rights reserved.
//

#import "ANListControllerUpdateViewInterface.h"

@protocol ANListControllerReusableLoadInterface <NSObject>

- (id<ANListControllerUpdateViewInterface>)cellForModel:(id)viewModel atIndexPath:(NSIndexPath*)indexPath;

- (id<ANListControllerUpdateViewInterface>)supplementaryViewForModel:(id)viewModel
                                                            kind:(NSString*)kind
                                                    forIndexPath:(NSIndexPath*)indexPath;
@end