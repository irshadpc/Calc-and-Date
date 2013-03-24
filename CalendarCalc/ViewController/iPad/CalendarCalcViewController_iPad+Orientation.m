//
//  CCCalendarCalcViewController_iPad+Orientation.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/01/03.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "CalendarCalcViewController_iPad+Orientation.h"
#import "Function.h"
#import "CalendarConstant.h"
#import "UIImage+Calculator.h"

@interface CalendarCalcViewController_iPad (OrientationPrivate)
- (CGFloat)portrateOriginXWithTag:(NSInteger)tag;
- (CGFloat)portrateOriginYWithTag:(NSInteger)tag;
- (CGFloat)portrateSizeWidthWithTag:(NSInteger)tag;
- (CGFloat)portrateSizeHeightWithTag:(NSInteger)tag;

- (CGFloat)landscapeOriginXWithTag:(NSInteger)tag;
- (CGFloat)landscapeOriginYWithTag:(NSInteger)tag;
- (CGFloat)landscapeSizeWidthWithTag:(NSInteger)tag;
- (CGFloat)landscapeSizeHeightWithTag:(NSInteger)tag;

- (UIImage *)imageWithTag:(NSInteger)tag orientation:(UIInterfaceOrientation)orientation;
@end

@implementation CalendarCalcViewController_iPad (Orientation)

static const CGFloat PortrateWidth = 192.0;
static const CGFloat PortrateHeight = 80.0;
static const CGFloat LandscapeWidth = 135.0;
static const CGFloat LandscapeHeight = 99.0;
static const CGFloat LandscapeClearButtonHeight = 132.0;

enum {
    Display = 100,
    Calendar = 700,
    DateSelectButton,
    PrevButton,
    NextButton,
    EventButton,
};

- (void)setupLayoutWithOrientation:(UIInterfaceOrientation)orientation
{
    for (UIView *view in self.view.subviews) {
        if (view.tag == Display) {
            continue;
        }
       
        if (UIInterfaceOrientationIsPortrait(orientation)) {
            view.frame = CGRectMake([self portrateOriginXWithTag:view.tag],
                                    [self portrateOriginYWithTag:view.tag],
                                    [self portrateSizeWidthWithTag:view.tag],
                                    [self portrateSizeHeightWithTag:view.tag]);
        } else {
            view.frame = CGRectMake([self landscapeOriginXWithTag:view.tag],
                                    [self landscapeOriginYWithTag:view.tag],
                                    [self landscapeSizeWidthWithTag:view.tag],
                                    [self landscapeSizeHeightWithTag:view.tag]);
        }
        
        if (view.tag < Calendar) {
            [(UIButton *)view setBackgroundImage:[self imageWithTag:view.tag
                                                        orientation:orientation]
                                        forState:UIControlStateNormal];
        }
    }
}

@end

@implementation CalendarCalcViewController_iPad (OrientationPrivate)

- (CGFloat)portrateOriginXWithTag:(NSInteger)tag
{
    static const CGFloat Leftmost = 0;
    static const CGFloat DateControllerOriginX = 484.0;
    switch (tag) {
        case Calendar:
        case FunctionDelete:
        case 7:
        case 4:
        case 1:
        case 0:
            return Leftmost + (PortrateWidth * 0);
        case FunctionPlusMinus:
        case 8:
        case 5:
        case 2:
        case 10:
            return Leftmost + (PortrateWidth * 1);
        case FunctionDivide:
        case 9:
        case 6:
        case 3:
        case FunctionDecimal:
            return Leftmost + (PortrateWidth * 2);
        case FunctionMinus:
        case FunctionMultiply:
        case FunctionPlus:
        case FunctionEqual:
            return Leftmost + (PortrateWidth * 3);
        case DateSelectButton:
        case PrevButton:
        case NextButton:
        case EventButton:
        case FunctionClear:
            return DateControllerOriginX;
        case Display:
        default:
            NSLog(@"TAG: %d", tag);
            abort();
    }
}

- (CGFloat)portrateOriginYWithTag:(NSInteger)tag
{
    static const CGFloat Topmost = 120.0;
    static const CGFloat ClearButtonOriginY = 406.0;
    static const CGFloat CalcButtonTopmost = 604.0;
    switch (tag) {
        case Calendar:
        case DateSelectButton:
            return Topmost + (66.0 * 0);
        case PrevButton:
            return Topmost + (66.0 * 1);
        case NextButton:
            return Topmost + (66.0 * 2);
        case EventButton:
            return Topmost + (66.0 * 3);
        case FunctionClear:
            return ClearButtonOriginY;
        case FunctionDelete:
        case FunctionPlusMinus:
        case FunctionDivide:
        case FunctionMinus:
            return CalcButtonTopmost + (PortrateHeight * 0);
        case 7:
        case 8:
        case 9:
        case FunctionMultiply:
            return CalcButtonTopmost + (PortrateHeight * 1);
        case 4:
        case 5:
        case 6:
        case FunctionPlus:
            return CalcButtonTopmost + (PortrateHeight * 2);
        case 1:
        case 2:
        case 3:
        case FunctionEqual:
            return CalcButtonTopmost + (PortrateHeight * 3);
        case 0:
        case 10:
        case FunctionDecimal:
            return CalcButtonTopmost + (PortrateHeight * 4);
        case Display:
        default:
            NSLog(@"TAG: %d", tag);
            abort();
    }
}

- (CGFloat)portrateSizeWidthWithTag:(NSInteger)tag
{
    static const CGFloat CalendarControllerWidth = 284.0;
    switch (tag) {
        case DateSelectButton:
        case EventButton:
        case PrevButton:
        case NextButton:
        case FunctionClear:
            return CalendarControllerWidth;
        case Calendar:
            return (66.0 * 7);
        case FunctionDelete:
        case FunctionPlusMinus:
        case FunctionDivide:
        case FunctionMinus:
        case FunctionMultiply:
        case FunctionPlus:
        case FunctionEqual:
        case FunctionDecimal:
        case 10:
        case 0:
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
        case 8:
        case 9:
            return (PortrateWidth * 1);
        case Display:
        default:
            NSLog(@"TAG: %d", tag);
            abort();
    }
}

- (CGFloat)portrateSizeHeightWithTag:(NSInteger)tag
{
    static const CGFloat PortrateClearHeight = 176.0;
    switch (tag) {
        case DateSelectButton:
        case PrevButton:
        case NextButton:
        case EventButton:
            return (66.0 * 1);
        case Calendar:
            return (66.0 * 7);
        case FunctionClear:
            return PortrateClearHeight;
        case FunctionEqual:
            return (PortrateHeight * 2);
        case FunctionDelete:
        case FunctionPlusMinus:
        case FunctionDivide:
        case FunctionMinus:
        case FunctionMultiply:
        case FunctionPlus:
        case FunctionDecimal:
        case 10:
        case 0:
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
        case 8:
        case 9:
            return (PortrateHeight * 1);
        case Display:
        default:
            NSLog(@"TAG: %d", tag);
            abort();
    }
}

- (CGFloat)landscapeOriginXWithTag:(NSInteger)tag
{
    static const CGFloat Leftmost = 484.0;
    switch (tag) {
        case FunctionClear:
        case FunctionDelete:
        case 7:
        case 4:
        case 1:
        case 0:
            return Leftmost + (LandscapeWidth * 0);
        case FunctionPlusMinus:
        case 8:
        case 5:
        case 2:
        case 10:
            return Leftmost + (LandscapeWidth * 1);
        case FunctionDivide:
        case 9:
        case 6:
        case 3:
        case FunctionDecimal:
            return Leftmost + (LandscapeWidth * 2);
        case FunctionMinus:
        case FunctionMultiply:
        case FunctionPlus:
        case FunctionEqual:
            return Leftmost + (LandscapeWidth * 3);
        case Calendar:
            return 0;
        case EventButton:
        case PrevButton:
            return CalendarMargin;
        case DateSelectButton:
            return CalendarMargin + (66.0 * 2);
        case NextButton:
            return CalendarMargin + (66.0 * 5);
        case Display:
        default:
            NSLog(@"TAG: %d", tag);
            abort();
    }
}

- (CGFloat)landscapeOriginYWithTag:(NSInteger)tag
{
    static const CGFloat Topmost = 120.0;
    switch (tag) {
        case EventButton:
        case FunctionClear:
            return Topmost;
        case PrevButton:
        case DateSelectButton:
        case NextButton:
            return Topmost + (66.0 * 1);
        case Calendar:
            return Topmost + (66.0 * 2);
        case FunctionDelete:
        case FunctionPlusMinus:
        case FunctionDivide:
        case FunctionMinus:
            return Topmost + LandscapeClearButtonHeight + (LandscapeHeight * 0);
        case 7:
        case 8:
        case 9:
        case FunctionMultiply:
            return Topmost + LandscapeClearButtonHeight + (LandscapeHeight * 1);
        case 4:
        case 5:
        case 6:
        case FunctionPlus:
            return Topmost + LandscapeClearButtonHeight + (LandscapeHeight * 2);
        case 1:
        case 2:
        case 3:
        case FunctionEqual:
            return Topmost + LandscapeClearButtonHeight + (LandscapeHeight * 3);
        case 0:
        case 10:
        case FunctionDecimal:
            return Topmost + LandscapeClearButtonHeight + (LandscapeHeight * 4);
        case Display:
        default:
            NSLog(@"TAG: %d", tag);
            abort();
    }
}

- (CGFloat)landscapeSizeWidthWithTag:(NSInteger)tag
{
    switch (tag) {
        case EventButton:
            return (66.0 * 7);
        case Calendar:
            return (66.0 * 7);
        case PrevButton:
        case NextButton:
            return (66.0 * 2);
        case DateSelectButton:
            return (66.0 * 3);
        case FunctionClear:
            return (LandscapeWidth * 4);
        case FunctionDelete:
        case FunctionPlusMinus:
        case FunctionDivide:
        case FunctionMinus:
        case FunctionMultiply:
        case FunctionPlus:
        case FunctionEqual:
        case FunctionDecimal:
        case 10:
        case 0:
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
        case 8:
        case 9:
            return (LandscapeWidth * 1);
        case Display:
        default:
            NSLog(@"TAG: %d", tag);
            abort();
    }
}

- (CGFloat)landscapeSizeHeightWithTag:(NSInteger)tag
{
    switch (tag) {
        case EventButton:
        case PrevButton:
        case NextButton:
        case DateSelectButton:
            return (66.0 * 1);
        case Calendar:
            return (66.0 * 7);
        case FunctionClear:
            return LandscapeClearButtonHeight;
        case FunctionEqual:
            return (LandscapeHeight * 2);
        case FunctionDelete:
        case FunctionPlusMinus:
        case FunctionDivide:
        case FunctionMinus:
        case FunctionMultiply:
        case FunctionPlus:
        case FunctionDecimal:
        case 10:
        case 0:
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
        case 8:
        case 9:
            return (LandscapeHeight * 1);
        case Display:
        default:
            NSLog(@"TAG: %d", tag);
            abort();
    }
}

- (UIImage *)imageWithTag:(NSInteger)tag
              orientation:(UIInterfaceOrientation)orientation
{
    switch (tag) {
        case FunctionClear:
            return [UIImage clearKeyImageWithOrientation:orientation];
        case FunctionDecimal:
        case 10:
        case 0:
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
        case 8:
        case 9:
            return [UIImage numberKeyImageWithOrientation:orientation];
        case FunctionDelete:
        case FunctionPlusMinus:
        case FunctionDivide:
        case FunctionMinus:
        case FunctionMultiply:
        case FunctionPlus:
            return [UIImage operatorKeyImageWithOrientation:orientation];
        case FunctionEqual:
            return [UIImage equalKeyImageWithOrientation:orientation];
        case Display:
        case EventButton:
        case DateSelectButton:
        case PrevButton:
        case NextButton:
        case Calendar:
        default:
            NSLog(@"TAG: %d", tag);
            abort();
    }
}

@end
