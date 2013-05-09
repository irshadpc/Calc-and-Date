//
//  UIBarButtonItem+AdditionalConvenienceConstructor.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/04/07.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "UIBarButtonItem+AdditionalConvenienceConstructor.h"

@implementation UIBarButtonItem (AdditionalConvenienceConstructor)
+ (UIBarButtonItem *)flexibleSpaceItem
{
    return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                         target:nil
                                                         action:nil];
}

+ (UIBarButtonItem *)closeButtonItemWithTarget:(id)target action:(SEL)action
{
    return [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"CLOSE", nil)
                                            style:UIBarButtonItemStyleBordered
                                           target:target
                                           action:action];
}

+ (UIBarButtonItem *)cancelButtonItemWithTarget:(id)target action:(SEL)action
{
    return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                         target:target
                                                         action:action];
}

+ (UIBarButtonItem *)doneButtonItemWithTarget:(id)target action:(SEL)action
{
    return [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                        target:target
                                                        action:action];
}
@end
