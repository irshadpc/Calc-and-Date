//
//  CCEventViewController.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/31.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EventViewControllerDelegate;

@interface EventViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) id <EventViewControllerDelegate> delegate;
@property (strong, nonatomic) NSDate *selectedDate;
@end

@protocol EventViewControllerDelegate <NSObject>
- (void)eventViewControllerDidDone:(EventViewController *)eventViewController;
@end