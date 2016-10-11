//
//  ANStorageValidator.m
//  Pods
//
//  Created by Oksana Kovalchuk on 10/11/16.
//
//

#import "ANStorageValidator.h"

BOOL ANIsIndexValid(NSInteger index)
{
    BOOL isValid = YES;
    isValid = isValid && (index >= 0);
    isValid = isValid && (index != NSNotFound);
    
    return isValid;
}
