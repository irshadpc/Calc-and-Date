//
//  ASCCalendarButton.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/22.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASCCalendarButton : UIButton

@property (nonatomic) NSInteger dayOfCalendar;

@property (nonatomic) NSInteger year;
@property (nonatomic) NSInteger month;
@property (nonatomic) NSInteger dayOfMonth;
@property (nonatomic) NSInteger weekday;

- (void)setImage:(UIImage *)image forState:(UIControlState)state;
@end
