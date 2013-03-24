//
//  CCCalendarCalcViewController.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/08.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarViewController.h"
#import "EventViewController.h"
#import "CalendarCalcFormatter.h"
#import "CopybleLabel.h"

@class AVAudioPlayer;

@interface CalendarCalcViewController : UIViewController <UIPopoverControllerDelegate>

@property (weak, nonatomic) AVAudioPlayer *player;

@property (strong, nonatomic) CalendarViewController *calendarViewController;
@property (strong, nonatomic) EventViewController *eventViewController;
@property (strong, nonatomic) CalendarCalcFormatter *calendarCalcFormatter;
@property (weak, nonatomic) IBOutlet CopybleLabel *display;
@property (weak, nonatomic) IBOutlet UILabel *indicator;
@property (weak, nonatomic) IBOutlet UIButton *clearButton;

- (void)onEventDone;
- (void)showEventView:(UIButton *)sender;
- (void)configureView;
@end
