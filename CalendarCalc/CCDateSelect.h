//
//  CCDateSelect.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/23.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASCWeek.h"

@protocol CCDateSelect <NSObject>
- (void)didSelectDate:(NSDate *)date;
- (void)didSelectWeek:(ASCWeek)week exclude:(BOOL)exclude;
@end
