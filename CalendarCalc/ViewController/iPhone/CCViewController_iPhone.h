//
//  CCViewController_iPhone.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/01/01.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCViewController_iPhone : UIViewController <UIScrollViewDelegate>
@property (strong, nonatomic) UIViewController *frontViewController;
@property (strong, nonatomic) UIViewController *backViewController;
@end