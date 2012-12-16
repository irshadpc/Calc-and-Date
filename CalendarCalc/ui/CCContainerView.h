//
//  CCContainerView.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/16.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CCContainerViewDelegate;

@interface CCContainerView : UIView
@property (weak, nonatomic) id <CCContainerViewDelegate> delegate;

- (void)addBarButtonWithTitle:(NSString *)title buttonIndex:(NSInteger)buttonIndex;
- (void)showInView:(UIView *)view animated:(BOOL)animated;
- (void)dismissContainerViewWithAnimated:(BOOL)animated;
@end

@protocol CCContainerViewDelegate <NSObject>
@required
- (void)containerViewClickedCancelButton:(CCContainerView *)view;

@optional
- (void)containerView:(CCContainerView *)view clickedButtonAtIndex:(NSInteger)buttonIndex;

@end