//
//  UIBarButtonItem+ConvenienceConstructor.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/04/07.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (ConvenienceConstructor)
+ (UIBarButtonItem *)flexibleSpaceItem;
+ (UIBarButtonItem *)closeButtonItemWithTarget:(id)target action:(SEL)action;
+ (UIBarButtonItem *)cancelButtonItemWithTarget:(id)target action:(SEL)action;
+ (UIBarButtonItem *)doneButtonItemWithTarget:(id)target action:(SEL)action;
@end
