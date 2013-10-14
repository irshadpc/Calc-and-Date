//
//  ViewSheet.m
//  DateNumber
//
//  Created by Ishida Junichi on 2013/01/08.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "ViewSheet.h"
#import "UIView+Frame.h"

@interface ViewSheet ()
@property(strong, nonatomic, readwrite) UIViewController *contentViewController;
@property(nonatomic, readwrite) BOOL visible;
@property(strong, nonatomic) UIView *containerView;
@property(strong, nonatomic) UIView *protectView;
@end

@implementation ViewSheet
- (id)initWithContentViewController:(UIViewController *)contentViewController
{
    CGRect frame = [UIScreen mainScreen].bounds;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
        frame.size.height -= 20.0;
    }
    if ((self = [super initWithFrame:frame])) {
        _contentViewController = contentViewController;

        _protectView = [[UIView alloc] initWithFrame:self.bounds];
        [_protectView setBackgroundColor:[UIColor colorWithWhite:0 alpha:1]];
        [_protectView setAlpha:0];
        [self addSubview:_protectView];

        _containerView = [[UIView alloc] initWithFrame:_contentViewController.view.bounds];
        [_containerView addSubview:_contentViewController.view];
        [self addSubview:_containerView];
        [self bringSubviewToFront:_containerView];
    }
    return self;
}

- (void)showViewSheetAnimated:(BOOL)animated
{
    [self.containerView setFrameOriginY:self.frame.size.height];

    UIView *rootView = [[[[[UIApplication sharedApplication] delegate] window] rootViewController] view];
    [rootView addSubview:self];
    [rootView bringSubviewToFront:self];

    CGFloat originY = self.isTopAlign ? 0 : (self.frame.size.height - self.containerView.frame.size.height);
    [UIView animateWithDuration: animated ? 0.25 : 0.0
                     animations: ^{
                         self.protectView.alpha = 0.5;
                         [self.containerView setFrameOriginY:originY];
                     }
                     completion:^(BOOL finished) {
                         self.visible = YES;
                     }
     ];
}

- (void)dismissViewSheetAnimated:(BOOL)animated
                           shoot:(BOOL)shoot
{
    if (!self.isVisible) {
        return;
    }
    
    CGFloat originY = self.frame.size.height;
    if (shoot) {
        originY *= -1;
    }

    [UIView animateWithDuration: animated ? 0.25 : 0
                     animations: ^{
                         [self.containerView setFrameOriginY:originY];
                         self.protectView.alpha = 0;
                     }
                     completion: ^(BOOL finished) {
                         if (finished) {
                             [self removeFromSuperview];
                             self.visible = NO;
                         }
                     }];
}
@end