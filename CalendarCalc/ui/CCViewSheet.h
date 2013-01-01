//
//  CCContainerView.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/16.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CCViewSheetDelegate;

@interface CCViewSheet : UIView

@property (weak, nonatomic) id <CCViewSheetDelegate> delegate;
@property (strong, nonatomic, readonly) UIViewController *contentViewController;
@property (nonatomic, readonly, getter = isVisible) BOOL visible;

- (id)initWithContentViewController:(UIViewController *)contentViewController;
- (id)initWithContentView:(UIView *)contentView;
- (void)showInView:(UIView *)view animated:(BOOL)animated;
- (void)dismissContainerViewWithAnimated:(BOOL)animated;
- (void)setRightButton:(UIBarButtonItem *)rightButton;
@end


@protocol CCViewSheetDelegate <NSObject>
@required
- (void)viewSheetClickedCancelButton:(CCViewSheet *)viewSheet;
@end