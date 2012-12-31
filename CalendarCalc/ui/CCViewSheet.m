//
//  CCContainerView.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/16.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CCViewSheet.h"

@interface CCViewSheet ()
@property (strong, nonatomic) UIToolbar *toolbar;
@property (strong, nonatomic) NSMutableArray *barButonItems;
@property (strong, nonatomic, readwrite) UIViewController *contentViewController;
@property (strong, nonatomic) UIView *protectView;
@property (nonatomic, readwrite) BOOL visible;

- (CGRect)containerFrameWithContentView:(UIView *)view;
- (UIBarButtonItem *)cancelButton;
- (UIBarButtonItem *)flexibleSpace;
- (void)onCancel:(UIBarButtonItem *)sender;
- (void)onOptionalButton:(UIBarButtonItem *)sender;
@end

@implementation CCViewSheet

- (id)initWithContentViewController:(UIViewController *)contentViewController
{
    _contentViewController = contentViewController;
    return [self initWithContentView:_contentViewController.view];
}

- (id)initWithContentView:(UIView *)contentView
{
    CGRect frame = [self containerFrameWithContentView:contentView];
    frame.origin.y = 0;
    frame.size.height += 44.0;
    if ((self = [super initWithFrame:frame])) {
        _barButonItems = [[NSMutableArray alloc] init];
        [_barButonItems addObject:[self cancelButton]];

        _toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,
                                                               0,
                                                               [UIScreen mainScreen].bounds.size.width,
                                                               44.0)];
        _toolbar.barStyle = UIBarStyleBlackOpaque;
        _toolbar.items = _barButonItems;
        [self addSubview:_toolbar];
       
        _containerView = [[UIView alloc] initWithFrame:[self containerFrameWithContentView:contentView]];
        [self addSubview:_containerView];
        [_containerView addSubview:contentView];
    }
    return self;
}

- (void)setRightButton:(UIBarButtonItem *)rightButton
{
    self.toolbar.items = @[[self cancelButton],
                           [self flexibleSpace],
                           rightButton];
}

- (void)showInView:(UIView *)view animated:(BOOL)animated
{
    UIView *rootView = [[[UIApplication sharedApplication] delegate] window].rootViewController.view;
    self.protectView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.protectView.backgroundColor = [UIColor colorWithWhite:0 alpha:1];
    self.protectView.alpha = 0;
    [rootView addSubview:self.protectView];
    [rootView bringSubviewToFront:self.protectView];
    
    CGRect hideFrame = self.frame;
    hideFrame.origin.y = rootView.frame.size.height;
    self.frame = hideFrame;
    [rootView addSubview:self];
    [rootView bringSubviewToFront:self];
    
    [UIView animateWithDuration: animated ? 0.25 : 0
                     animations: ^{
                         self.protectView.alpha = 0.5;
                         CGRect showFrame = self.frame;
                         showFrame.origin.y -= self.frame.size.height;
                         self.frame = showFrame;
                         self.visible = YES;
                     }];
}

- (void)dismissContainerViewWithAnimated:(BOOL)animated
{
    [UIView animateWithDuration: animated ? 0.25 : 0
                     animations: ^{
                         CGRect hideFrame = self.frame;
                         hideFrame.origin.y += self.frame.size.height;
                         self.frame = hideFrame;
                         self.protectView.alpha = 0;
                     }
                     completion: ^(BOOL finished) {
                         if (finished) {
                             [self.protectView removeFromSuperview];
                             [self removeFromSuperview];
                             self.visible = NO;
                         }
                     }];
}

#pragma mark - Private

- (CGRect)containerFrameWithContentView:(UIView *)view
{
    return CGRectMake(0,
                      44.0,
                      view.frame.size.width, 
                      view.frame.size.height);
}



- (UIBarButtonItem *)cancelButton
{
   return [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemCancel
                                                        target: self
                                                        action: @selector(onCancel:)];
}

- (UIBarButtonItem *)flexibleSpace
{
    return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                         target:nil
                                                         action:nil];
}

- (void)onCancel:(UIBarButtonItem *)sender
{
    [self.delegate viewSheetClickedCancelButton:self];
}
        
- (void)onOptionalButton:(UIBarButtonItem *)sender
{
    [self.delegate viewSheet:self clickedButtonAtIndex:sender.tag];
}

@end
