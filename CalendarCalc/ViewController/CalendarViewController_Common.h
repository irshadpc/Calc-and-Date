//
//  CalendarViewController_Common.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/03/25.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "CalendarViewController.h"
#import "CalendarControlView.h"
#import "PageView.h"
#import "ViewSheet.h"

@interface CalendarViewController ()
@property(strong, nonatomic) NSArray *calendarViews;
@property(strong, nonatomic) CalendarControlView *calendarControllView;
@property(strong, nonatomic) PageView *pageView;
@property(strong, nonatomic) ViewSheet *viewSheet;

- (CGRect)viewFrame;
@end
