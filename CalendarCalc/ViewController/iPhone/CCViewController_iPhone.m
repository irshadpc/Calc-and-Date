//
//  CCViewController_iPhone.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/01/01.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "CCViewController_iPhone.h"

@interface CCViewController_iPhone ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *frontContainerView;
@property (weak, nonatomic) IBOutlet UIView *backContainerView;
@end

@implementation CCViewController_iPhone

static const CGFloat BackViewTop = 88.0;

- (void)viewDidLoad
{
    [super viewDidLoad];

    if (![self.frontContainerView.subviews containsObject:self.frontViewController.view]) {
        [self.frontContainerView addSubview:self.frontViewController.view];
    }
    if (![self.backContainerView.subviews containsObject:self.backViewController.view]) {
        [self.backContainerView addSubview:self.backViewController.view];
    }
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.bounds.size.width,
                                               self.scrollView.bounds.size.height * 2)];
    [self.scrollView setContentOffset:CGPointMake(0,
                                                  self.frontContainerView.frame.origin.y)];
}

- (void)viewDidUnload {
    [self setScrollView:nil];
    [self setFrontContainerView:nil];
    [self setBackContainerView:nil];
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)setFrontViewController:(UIViewController *)frontViewController
{
    if (_frontViewController != frontViewController) {
        [_frontViewController.view removeFromSuperview];
        _frontViewController = frontViewController;
    }
    if (self.frontContainerView) {
        [self.frontContainerView addSubview:_frontViewController.view];
    }
}

- (void)setBackViewController:(UIViewController *)backViewController
{
    if (_backViewController != backViewController) {
        [_backViewController.view removeFromSuperview];
        _backViewController = backViewController;
    }
    if (self.backContainerView) {
        [self.backContainerView addSubview:_backViewController.view];
    }
}


#pragma mark - UIScrollView

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view bringSubviewToFront:scrollView];
    if (scrollView.contentOffset.y < 0) {
        [scrollView setContentOffset:CGPointZero animated:NO];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity 
              targetContentOffset:(inout CGPoint *)targetContentOffset
{
    BOOL isFrontEnabled = NO;
    if (velocity.y < 0) {
        isFrontEnabled = YES;
    } else if (velocity.y >= 1) {
        isFrontEnabled = NO;
    } else {
        isFrontEnabled = scrollView.contentOffset.y <= (scrollView.bounds.size.height / 2);
    }

    CGFloat offsetY = 0;
    UIView *enabledView = nil;
    if (isFrontEnabled) {
        offsetY = self.frontContainerView.frame.origin.y;
        enabledView = self.scrollView;
    } else {
        offsetY = self.frontContainerView.frame.size.height - BackViewTop;
        enabledView = self.backContainerView;
    }

    [self.frontViewController.view setUserInteractionEnabled:isFrontEnabled];
    [self.backViewController.view setUserInteractionEnabled:!isFrontEnabled];
    [self.view bringSubviewToFront:enabledView];
    
    [UIView animateWithDuration:0.1
                     animations:^{
                         targetContentOffset->y = offsetY;
                         [scrollView setContentOffset:CGPointMake(0, offsetY) animated:NO];
                     }];
}

@end
