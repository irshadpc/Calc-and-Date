//
//  CCDateSelect.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/23.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Week.h"

@protocol DateSelect <NSObject>
- (void)didSelectDate:(NSDate *)date;
- (void)didSelectWeek:(Week)week exclude:(BOOL)exclude;
@end
