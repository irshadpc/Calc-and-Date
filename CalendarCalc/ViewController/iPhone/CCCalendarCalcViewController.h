//
//  CCCalendarCalcViewController.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/08.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@class CCViewSheet;

@interface CCCalendarCalcViewController : UIViewController {
  @private
    AVAudioPlayer *_player;
    CCViewSheet *_currentViewSheet;
}

@end
