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

- (UIBarButtonItem *)cancelButton;
- (void)onCancel:(UIBarButtonItem *)sender;
- (void)onOptionalButton:(UIBarButtonItem *)sender;
@end

@implementation CCViewSheet

- (id)initWithContentView:(UIView *)contentView
{
    CGRect frame = contentView.frame;
    frame.origin.y = 0;
    frame.size.height = contentView.frame.size.height + 44.0;
    if ((self = [super initWithFrame:frame])) {
        _barButonItems = [[NSMutableArray alloc] init];
        [_barButonItems addObject:[self cancelButton]];

        _toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,
                                                               0,
                                                               [UIScreen mainScreen].bounds.size.width,
                                                               44.0)];
        [_toolbar setItems:_barButonItems];
        [self addSubview:_toolbar];
       
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                  44.0,
                                                                  frame.size.width,
                                                                  frame.size.height - 44.0)];
        [self addSubview:_containerView];
        [_containerView addSubview:contentView];
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
    [self.delegate viewSheetClickedCancelButton:self];
}
        
- (void)onOptionalButton:(UIBarButtonItem *)sender
{
    [self.delegate viewSheet:self clickedButtonAtIndex:sender.tag];
}

@end
