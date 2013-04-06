//
//  ViewSheet.h
//  DateNumber
//
//  Created by Ishida Junichi on 2013/01/08.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewSheet : UIView
@property(strong, nonatomic, readonly) UIViewController *contentViewController;
@property(nonatomic, readonly, getter=isVisible) BOOL visible;
@property(nonatomic, getter=isTopAlign) BOOL topAlign;

- (id)initWithContentViewController:(UIViewController *)contentViewController;
- (void)showViewSheetAnimated:(BOOL)animated;
- (void)dismissViewSheetAnimated:(BOOL)animated shoot:(BOOL)shoot;
@end
