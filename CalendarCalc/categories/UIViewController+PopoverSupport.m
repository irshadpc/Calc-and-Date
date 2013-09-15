//
//  UIViewController+PopoverSupport.m
//  CalendarCalc
//
//  Created by Junichi Ishida on 2013/09/15.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "UIViewController+PopoverSupport.h"

@implementation UIViewController (PopoverSupport)

#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
- (CGSize)contentSizeForPopover
{
    return [self respondsToSelector:@selector(preferredContentSize)] ? self.preferredContentSize 
                                                                     : self.contentSizeForViewInPopover;
}

- (void)setContentSizeForPopover:(CGSize)size
{
    if ([self respondsToSelector:@selector(setPreferredContentSize)]) {
        [self setPreferredContentSize:size];
    } else {
        [self setContentSizeForViewInPopover:size];
    }
}
#pragma GCC diagnostic warning "-Wdeprecated-declarations"

@end
