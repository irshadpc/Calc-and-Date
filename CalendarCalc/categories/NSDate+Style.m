//
//  NSDate+Style.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/09.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "NSDate+Style.h"
#import "NSDateComponents+Unit.h"

@implementation NSDate (Style)
- (NSDate *)noTime
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    return [calendar dateFromComponents:[calendar components:[NSDateComponents componentsYMD]
                                                    fromDate:self]];
}
@end
