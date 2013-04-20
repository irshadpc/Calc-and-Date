//
//  CalendarViewController+Week.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/03/25.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "CalendarViewController.h"
#import "WeekView.h"

@interface CalendarViewController (Week)<WeekViewDelegate>
- (void)showWeekView;
@end
