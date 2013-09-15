//
//  CalendarCalcViewController_iPad+Layout.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/05/10.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "CalendarCalcViewController_iPad+Layout.h"
#import "CalendarCalcViewController_iPad_Common.h"
#import "CalendarViewController.h"
#import "Function.h"
#import "CalendarConstant.h"
#import "UIImage+Calculator.h"
#import "UIView+MutableFrame.h"

@interface CalendarCalcViewController_iPad (LayoutPrivate)
- (CGRect)dateSelectButtonFrame;
- (CGRect)prevButtonFrame;
- (CGRect)nextButtonFrame;
@end

@interface CalendarCalcViewController_iPad (LayoutOrientationPrivate)
- (CGRect)calendarContainerFrameWithOrientation:(UIInterfaceOrientation)orientation;
- (CGRect)calcContainerFrameWithOrientation:(UIInterfaceOrientation)orientation;
- (CGRect)clearButtonFrameWithOrientation:(UIInterfaceOrientation)orientation;
- (CGRect)eventButtonFrameWithOrientation:(UIInterfaceOrientation)orientation;
- (CGRect)dateSelectButtonContainerFrameWithOrientation:(UIInterfaceOrientation)orientation;
- (CGRect)prevButtonContainerFrameWithOrientation:(UIInterfaceOrientation)orientation;
- (CGRect)nextButtonContainerFrameWithOrientation:(UIInterfaceOrientation)orientation;
- (void)reloadCalcButtonsWithOrientation:(UIInterfaceOrientation)orientation;
- (CGFloat)frameOriginXWithTag:(NSInteger)tag orientation:(UIInterfaceOrientation)orientation;
- (CGFloat)frameOriginYWithTag:(NSInteger)tag orientation:(UIInterfaceOrientation)orientation;
- (CGFloat)systemVersionAdjustValue;
@end

static const CGFloat CalcButtonWidthPortrait = 192.0;
static const CGFloat CalcButtonHeightPortrait = 80.0;
static const CGFloat CalcButtonWidthLandscape = 135.0;
static const CGFloat CalcButtonHeightLangscape = 99.0;

@implementation CalendarCalcViewController_iPad (Layout)
- (void)setupView
{
    [self.calendarViewContainer addSubview:self.calendarViewController.view];
    [self.calendarViewController.dateSelectButton setFrame:[self dateSelectButtonFrame]];
    [self.dateSelectButtonContainer addSubview:self.calendarViewController.dateSelectButton];
    [self.calendarViewController.prevButton setFrame:[self prevButtonFrame]];
    [self.prevButtonContainer addSubview:self.calendarViewController.prevButton];
    [self.calendarViewController.nextButton setFrame:[self nextButtonFrame]];
    [self.nextButtonContainer addSubview:self.calendarViewController.nextButton];
    [self setupLayoutWithOrientation:self.interfaceOrientation];
}

- (void)setupLayoutWithOrientation:(UIInterfaceOrientation)orientation
{
    [self.calendarViewController setStringTitleMode:UIInterfaceOrientationIsPortrait(orientation)];

    [self.calendarViewContainer setFrame:[self calendarContainerFrameWithOrientation:orientation]];
    [self.calcViewContainer setFrame:[self calcContainerFrameWithOrientation:orientation]];
    [self.clearButton setFrame:[self clearButtonFrameWithOrientation:orientation]];
    [self.eventButton setFrame:[self eventButtonFrameWithOrientation:orientation]];
    [self.dateSelectButtonContainer setFrame:[self dateSelectButtonContainerFrameWithOrientation:orientation]];
    [self.prevButtonContainer setFrame:[self prevButtonContainerFrameWithOrientation:orientation]];
    [self.nextButtonContainer setFrame:[self nextButtonContainerFrameWithOrientation:orientation]];
    [self reloadCalcButtonsWithOrientation:orientation];
}
@end

@implementation CalendarCalcViewController_iPad (LayoutPrivate)
- (CGRect)dateSelectButtonFrame
{
    return CGRectMake(0,
                      0,
                      self.dateSelectButtonContainer.bounds.size.width,
                      self.dateSelectButtonContainer.bounds.size.height);
}

- (CGRect)prevButtonFrame
{
    return CGRectMake(0,
                      0,
                      self.prevButtonContainer.bounds.size.width,
                      self.prevButtonContainer.bounds.size.height);
}

- (CGRect)nextButtonFrame
{
    return CGRectMake(0,
                      0,
                      self.nextButtonContainer.bounds.size.width,
                      self.nextButtonContainer.bounds.size.height);
}
@end

@implementation CalendarCalcViewController_iPad (LayoutOrientationPrivate)
- (CGRect)calendarContainerFrameWithOrientation:(UIInterfaceOrientation)orientation
{
    CGFloat baseY = 120.0 + [self systemVersionAdjustValue];
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        return CGRectMake(0, baseY, 484.0, 462.0);
    } else {
        return CGRectMake(0, baseY + (66.0 * 2), 484.0, 462.0);
    }
}

- (CGRect)calcContainerFrameWithOrientation:(UIInterfaceOrientation)orientation
{
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        return CGRectMake(0,
                          604.0 + [self systemVersionAdjustValue],
                          CalcButtonWidthPortrait * 4,
                          CalcButtonHeightPortrait * 5);
    } else {
        return CGRectMake(484.0,
                          120.0 + [self systemVersionAdjustValue] + (66.0 * 2),
                          CalcButtonWidthLandscape * 4,
                          CalcButtonHeightLangscape * 5);
    }
}

- (CGRect)clearButtonFrameWithOrientation:(UIInterfaceOrientation)orientation
{
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        return CGRectMake(484.0, 406.0 + [self systemVersionAdjustValue], 284.0, 176.0);
    } else {
        return CGRectMake(484.0, 120.0 + [self systemVersionAdjustValue], 540.0, 66.0 * 2);
    }
}

- (CGRect)eventButtonFrameWithOrientation:(UIInterfaceOrientation)orientation
{
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        return CGRectMake(484.0, 318.0 + [self systemVersionAdjustValue], 284.0, 66.0);
    } else {
        return CGRectMake(6.0, 120.0 + [self systemVersionAdjustValue], 462.0, 66.0);
    }
}

- (CGRect)dateSelectButtonContainerFrameWithOrientation:(UIInterfaceOrientation)orientation
{
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        return CGRectMake(484.0,
                          120.0 + [self systemVersionAdjustValue],
                          284.0,
                          66.0);
    } else {
        return CGRectMake(6.0 + (66.0 * 2),
                          120.0 + [self systemVersionAdjustValue] + 66.0,
                          198.0,
                          66.0);
    }
}

- (CGRect)prevButtonContainerFrameWithOrientation:(UIInterfaceOrientation)orientation
{
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        return CGRectMake(484.0, 120.0 + [self systemVersionAdjustValue] + 66.0, 284.0, 66.0);
    } else {
        return CGRectMake(6.0, 120.0 + [self systemVersionAdjustValue] + 66.0, 132.0, 66.0);
    }

}

- (CGRect)nextButtonContainerFrameWithOrientation:(UIInterfaceOrientation)orientation
{
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        return CGRectMake(484.0,
                          120.0 + [self systemVersionAdjustValue] + (66.0 * 2),
                          284.0,
                          66.0);
    } else {
        return CGRectMake(6.0 + (66.0 * 5),
                          120.0 + [self systemVersionAdjustValue] + 66.0,
                          132.0,
                          66.0);
    }
}

- (void)reloadCalcButtonsWithOrientation:(UIInterfaceOrientation)orientation
{
    void (^reloadImage)(UIButton *) = ^(UIButton *calcButton) {
        if (calcButton.tag <= 10 || calcButton.tag == FunctionDecimal) {
            [calcButton setBackgroundImage:[UIImage numberKeyImageWithOrientation:orientation]
                                  forState:UIControlStateNormal];
        } else if (calcButton.tag == FunctionClear) {
            [calcButton setBackgroundImage:[UIImage clearKeyImageWithOrientation:orientation]
                                  forState:UIControlStateNormal];
        } else {
            [calcButton setBackgroundImage:[UIImage operatorKeyImageWithOrientation:orientation]
                                  forState:UIControlStateNormal];
        }
    };

    void (^reloadSize)(UIButton *) = ^(UIButton *calcButton) {
        [calcButton setFrameOriginX:[self frameOriginXWithTag:calcButton.tag
                                                  orientation:orientation]];
        [calcButton setFrameOriginY:[self frameOriginYWithTag:calcButton.tag
                                                  orientation:orientation]];

        CGFloat heightScale = calcButton.tag == FunctionEqual ? 2 : 1;
        if (UIInterfaceOrientationIsPortrait(orientation)) {
            [calcButton setFrameSize:CGSizeMake(CalcButtonWidthPortrait,
                                                CalcButtonHeightPortrait * heightScale)];
        } else {
            [calcButton setFrameSize:CGSizeMake(CalcButtonWidthLandscape,
                                                CalcButtonHeightLangscape * heightScale)];
        }
    };

    for (UIView *subview in self.calcViewContainer.subviews) {
        reloadImage((UIButton *)subview);
        reloadSize((UIButton *)subview);
    }
}

- (CGFloat)frameOriginXWithTag:(NSInteger)tag orientation:(UIInterfaceOrientation)orientation
{
    CGFloat buttonWidth = 0;
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        buttonWidth = CalcButtonWidthPortrait;
    } else {
        buttonWidth = CalcButtonWidthLandscape;
    }

    switch (tag) {
        case FunctionDelete:
        case 7:
        case 4:
        case 1:
        case 0:
            return 0;
        case FunctionPlusMinus:
        case 8:
        case 5:
        case 2:
        case 10:
            return buttonWidth;
        case FunctionDivide:
        case 9:
        case 6:
        case 3:
        case FunctionDecimal:
            return buttonWidth * 2;
        case FunctionMinus:
        case FunctionMultiply:
        case FunctionPlus:
        case FunctionEqual:
            return buttonWidth * 3;
        default:
            NSLog(@"TAG: %ld", (long)tag);
            abort();
    }
}

- (CGFloat)frameOriginYWithTag:(NSInteger)tag orientation:(UIInterfaceOrientation)orientation
{
    CGFloat buttonHeight = 0;
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        buttonHeight = CalcButtonHeightPortrait;
    } else {
        buttonHeight = CalcButtonHeightLangscape;
    }

    switch (tag) {
        case FunctionDelete:
        case FunctionPlusMinus:
        case FunctionDivide:
        case FunctionMinus:
            return 0;
        case 7:
        case 8:
        case 9:
        case FunctionMultiply:
            return buttonHeight;
        case 4:
        case 5:
        case 6:
        case FunctionPlus:
            return buttonHeight * 2;
        case 1:
        case 2:
        case 3:
        case FunctionEqual:
            return buttonHeight * 3;
        case 0:
        case 10:
        case FunctionDecimal:
            return buttonHeight * 4;
        default:
            NSLog(@"TAG: %ld", (long)tag);
            abort();
    }
}

- (CGFloat)systemVersionAdjustValue
{
    return [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? 20.0 : 0;
}
@end
