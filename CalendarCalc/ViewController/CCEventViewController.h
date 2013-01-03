//
//  CCEventViewController.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/31.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CCEventViewControllerDelegate;

@interface CCEventViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) id <CCEventViewControllerDelegate> delegate;
@property (strong, nonatomic) NSDate *selectedDate;
@end

@protocol CCEventViewControllerDelegate <NSObject>
- (void)eventViewControllerDidDone:(CCEventViewController *)eventViewController;
@end