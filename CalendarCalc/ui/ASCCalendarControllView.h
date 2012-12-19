//
//  ASCCalendarControllView.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/19.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ASCCalendarControllViewDelegate;

@interface ASCCalendarControllView : UIView
@property (weak, nonatomic) id <ASCCalendarControllViewDelegate> delegate;
@end

@protocol ASCCalendarControllViewDelegate <NSObject>
- (NSDate *)calendarControllView:(ASCCalendarControllView *)calendarControllView pressPrevMonthButton:(UIButton *)prevMonthButton;
- (NSDate *)calendarControllView:(ASCCalendarControllView *)calendarControllView pressNextMonthButton:(UIButton *)nextMonthBUtton;
- (NSDate *)calendarControllView:(ASCCalendarControllView *)calendarControllView pressDateSelectButton:(UIButton *)dateSelectButton;
@end