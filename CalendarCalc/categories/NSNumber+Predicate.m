//
//  NSNumber+Predicate.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/09.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "NSNumber+Predicate.h"

@implementation NSNumber (Predicate)
- (BOOL)isNan {
    return [self isEqualToNumber:[NSDecimalNumber notANumber]];
}

- (BOOL)isMinus {
    return [self compare:@0] == NSOrderedAscending;
}
@end
