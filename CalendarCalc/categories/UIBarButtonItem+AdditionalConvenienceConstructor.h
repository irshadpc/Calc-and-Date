//
//  UIBarButtonItem+AdditionalConvenienceConstructor.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/04/07.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (AdditionalConvenienceConstructor)
+ (UIBarButtonItem *)flexibleSpaceItem;
+ (UIBarButtonItem *)cancelButtonItemWithTarget:(id)target action:(SEL)action;
+ (UIBarButtonItem *)doneButtonItemWithTarget:(id)target action:(SEL)action;
@end
