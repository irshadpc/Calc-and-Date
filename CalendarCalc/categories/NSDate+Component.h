//
//  NSDate+Component.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/09.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Component)
- (NSInteger)year;
- (NSInteger)month;
- (NSInteger)day;
- (NSInteger)weekday;        
- (NSDate *)noTime;
@end
