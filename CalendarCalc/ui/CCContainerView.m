//
//  CCContainerView.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/16.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CCContainerView.h"

@interface CCContainerView ()
@property (strong, nonatomic) UIToolbar *toolbar;
@property (strong, nonatomic) NSMutableArray *barButonItems;
@property (strong, nonatomic) NSMutableArray *contentViews;

- (UIBarButtonItem *)cancelButton;
- (void)onCancel:(UIBarButtonItem *)sender;
- (void)onOptionalButton:(UIBarButtonItem *)sender;
@end

@implementation CCContainerView

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        _barButonItems = [[NSMutableArray alloc] init];
        [_barButonItems addObject:[self cancelButton]];

        _toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 44.0)];
        [_toolbar setItems:_barButonItems];
        [self addSubview:_toolbar];
       
        _contentViews = [[NSMutableArray alloc] init];
        [self setBackgroundColor:[UIColor blackColor]];
    }
    return self;
}

- (void)addBarButtonWithTitle:(NSString *)title
                  buttonIndex:(NSInteger)buttonIndex
{
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle: title
                                                                      style: UIBarButtonItemStyleBordered
                                                                     target: self 
                                                                     action: @selector(onOptionalButton:)];
    [barButtonItem setTag:buttonIndex];
    [self.barButonItems addObject:barButtonItem];
}

- (void)addContentView:(UIView *)view
{
    CGRect newFrame = view.frame;
    newFrame.origin.y += self.toolbar.frame.size.height;
    view.frame = newFrame;
    [self addSubview:view];
    [self bringSubviewToFront:view];
}

- (void)showInView:(UIView *)view animated:(BOOL)animated
{

    CGRect hideFrame = self.frame;
    hideFrame.origin.y = view.frame.size.height;
    self.frame = hideFrame;
    [view addSubview:self];
    
    [UIView animateWithDuration: animated ? 0.25 : 0
                     animations: ^{
                         CGRect showFrame = self.frame;
                         showFrame.origin.y -= self.frame.size.height;
                         self.frame = showFrame;
                     }];
}

- (void)dismissContainerViewWithAnimated:(BOOL)animated
{
    [UIView animateWithDuration: animated ? 0.25 : 0
                     animations: ^{
                         CGRect hideFrame = self.frame;
                         hideFrame.origin.y += self.frame.size.height;
                         self.frame = hideFrame;
                     }
                     completion: ^(BOOL finished) {
                         if (finished) {
                             [self removeFromSuperview];
                         }
                     }];
}

#pragma mark - Private

- (UIBarButtonItem *)cancelButton
{
   return [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemCancel
                                                        target: self
                                                        action: @selector(onCancel:)];
}

- (void)onCancel:(UIBarButtonItem *)sender
{
    [self.delegate containerViewClickedCancelButton:self];
}
        
- (void)onOptionalButton:(UIBarButtonItem *)sender
{
    [self.delegate containerView:self clickedButtonAtIndex:sender.tag];
}

@end
