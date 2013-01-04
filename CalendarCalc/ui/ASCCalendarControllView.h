//
//  ASCCalendarControllView.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/19.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ASCCalendarControllViewDelegate;
@class AVAudioPlayer;
@class ASCCalendarView;

@interface ASCCalendarControllView : UIView

@property (weak, nonatomic) AVAudioPlayer *player;

@property (weak, nonatomic) id <ASCCalendarControllViewDelegate> delegate;
@property (strong, nonatomic, readonly) UIButton *dateSelectButton;
@property (strong, nonatomic, readonly) UIButton *prevButton;
@property (strong, nonatomic, readonly) UIButton *nextButton;
@property (strong, nonatomic) NSDate *currentDate;

- (id)initWithCalendarView:(ASCCalendarView *)calendarView;
@end

@protocol ASCCalendarControllViewDelegate <NSObject>
- (NSDate *)calendarControllView:(ASCCalendarControllView *)calendarControllView pressPrevMonthButton:(UIButton *)prevMonthButton;
- (NSDate *)calendarControllView:(ASCCalendarControllView *)calendarControllView pressNextMonthButton:(UIButton *)nextMonthBUtton;
- (void)calendarControllView:(ASCCalendarControllView *)calendarControllView pressDateSelectButton:(UIButton *)dateSelectButton;
@end