//
//  ASCCalendarView.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/16.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ASCCalendarViewDelegate;

@interface ASCCalendarView : UIView {
  @private
    UIImage *_normalImage;
}

@property (weak, nonatomic) id <ASCCalendarViewDelegate> delegate;
@property (nonatomic, readonly) NSInteger year;
@property (nonatomic, readonly) NSInteger month;
@property (nonatomic) CGSize calendarButtonSize;

- (void)prevMonth;
- (void)nextMonth;
- (void)reloadCalendarViewWithYear:(NSInteger)year month:(NSInteger)month;

- (void)setImage:(UIImage *)image forState:(UIControlState)state;
@end

@protocol ASCCalendarViewDelegate <NSObject>
@optional
- (void)calendarView:(ASCCalendarView *)view onTouchUpInside:(NSDate *)date;

@end