//
//  NSString+Safe.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/02/16.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "NSString+Safe.h"

@implementation NSString (Safe)
- (NSString *)safeSubstringToIndex:(NSUInteger)index
{
    return [self substringToIndex:MIN([self length], index)];
}
@end
