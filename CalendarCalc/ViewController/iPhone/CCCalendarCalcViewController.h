//
//  CCCalendarCalcViewController.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/08.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "CCCalendarViewController.h"
#import "CCEventViewController.h"
#import "CCCalendarCalcFormatter.h"

@interface CCCalendarCalcViewController : UIViewController {
  @private
    AVAudioPlayer *_player;
}
@property (strong, nonatomic) CCCalendarViewController *calendarViewController;
@property (strong, nonatomic) CCEventViewController *eventViewController;
@property (strong, nonatomic) CCCalendarCalcFormatter *calendarCalcFormatter;
@property (weak, nonatomic) IBOutlet UILabel *display;
@property (weak, nonatomic) IBOutlet UILabel *indicator;
@property (weak, nonatomic) IBOutlet UIButton *clearButton;

- (void)onEventButton:(UIButton *)sender;
- (void)configureView;
@end
