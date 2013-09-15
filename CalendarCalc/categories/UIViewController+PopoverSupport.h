//
//  UIViewController+PopoverSupport.h
//  CalendarCalc
//
//  Created by Junichi Ishida on 2013/09/15.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (PopoverSupport)
- (CGSize)contentSizeForPopover;
- (void)setContentSizeForPopover:(CGSize)size;
@end
