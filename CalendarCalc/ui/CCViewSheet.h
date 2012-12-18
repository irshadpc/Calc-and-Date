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
@property (strong, nonatomic, readonly) UIView *containerView;

- (id)initWithContentView:(UIView *)contentView;
- (void)addBarButtonWithTitle:(NSString *)title buttonIndex:(NSInteger)buttonIndex;
- (void)showInView:(UIView *)view animated:(BOOL)animated;
- (void)dismissContainerViewWithAnimated:(BOOL)animated;
@end

@protocol CCViewSheetDelegate <NSObject>
@required
- (void)viewSheetClickedCancelButton:(CCViewSheet *)viewSheet;

@optional
- (void)viewSheet:(CCViewSheet *)viewSheet clickedButtonAtIndex:(NSInteger)buttonIndex;

@end