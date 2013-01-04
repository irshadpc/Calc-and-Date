//
//  CCCalendarCalcViewController_iPad+Orientation.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/01/03.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "CCCalendarCalcViewController_iPad+Orientation.h"
#import "CCFunction.h"
#import "ASCCalendarConstant.h"

@interface CCCalendarCalcViewController_iPad (OrientationPrivate)
- (CGFloat)portrateOriginXWithTag:(NSInteger)tag;
- (CGFloat)portrateOriginYWithTag:(NSInteger)tag;
- (CGFloat)portrateSizeWidthWithTag:(NSInteger)tag;
- (CGFloat)portrateSizeHeightWithTag:(NSInteger)tag;

- (CGFloat)landscapeOriginXWithTag:(NSInteger)tag;
- (CGFloat)landscapeOriginYWithTag:(NSInteger)tag;
- (CGFloat)landscapeSizeWidthWithTag:(NSInteger)tag;
- (CGFloat)landscapeSizeHeightWithTag:(NSInteger)tag;
@end

@implementation CCCalendarCalcViewController_iPad (Orientation)

static const CGFloat PortrateWidth = 192.0;
static const CGFloat PortrateHeight = 80.0;
static const CGFloat LandscapeWidth = 135.0;
static const CGFloat LandscapeHeight = 99.0;
static const CGFloat LandscapeClearButtonHeight = 132.0;

enum {
    CCDisplay = 100,
    CCCalendar = 700,
    CCDateSelectButton,
    CCPrevButton,
    CCNextButton,
    CCEventButton,
};

- (void)setupLayoutWithOrientation:(UIInterfaceOrientation)orientation
{
    for (UIView *view in self.view.subviews) {
        if (view.tag == CCDisplay) {
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
    }
}

@end

@implementation CCCalendarCalcViewController_iPad (OrientationPrivate)

- (CGFloat)portrateOriginXWithTag:(NSInteger)tag
{
    static const CGFloat Leftmost = 0;
    static const CGFloat DateControllerOriginX = 484.0;
    switch (tag) {
        case CCCalendar:
        case CCDelete:
        case 7:
        case 4:
        case 1:
        case 0:
            return Leftmost + (PortrateWidth * 0);
        case CCPlusMinus:
        case 8:
        case 5:
        case 2:
        case 10:
            return Leftmost + (PortrateWidth * 1);
        case CCDivide:
        case 9:
        case 6:
        case 3:
        case CCDecimal:
            return Leftmost + (PortrateWidth * 2);
        case CCMinus:
        case CCMultiply:
        case CCPlus:
        case CCEqual:
            return Leftmost + (PortrateWidth * 3);
        case CCDateSelectButton:
        case CCPrevButton:
        case CCNextButton:
        case CCEventButton:
        case CCClear:
            return DateControllerOriginX;
        case CCDisplay:
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
        case CCCalendar:
        case CCDateSelectButton:
            return Topmost + (66.0 * 0);
        case CCPrevButton:
            return Topmost + (66.0 * 1);
        case CCNextButton:
            return Topmost + (66.0 * 2);
        case CCEventButton:
            return Topmost + (66.0 * 3);
        case CCClear:
            return ClearButtonOriginY;
        case CCDelete:
        case CCPlusMinus:
        case CCDivide:
        case CCMinus:
            return CalcButtonTopmost + (PortrateHeight * 0);
        case 7:
        case 8:
        case 9:
        case CCMultiply:
            return CalcButtonTopmost + (PortrateHeight * 1);
        case 4:
        case 5:
        case 6:
        case CCPlus:
            return CalcButtonTopmost + (PortrateHeight * 2);
        case 1:
        case 2:
        case 3:
        case CCEqual:
            return CalcButtonTopmost + (PortrateHeight * 3);
        case 0:
        case 10:
        case CCDecimal:
            return CalcButtonTopmost + (PortrateHeight * 4);
        case CCDisplay:
        default:
            NSLog(@"TAG: %d", tag);
            abort();
    }
}

- (CGFloat)portrateSizeWidthWithTag:(NSInteger)tag
{
    static const CGFloat CalendarControllerWidth = 284.0;
    switch (tag) {
        case CCDateSelectButton:
        case CCEventButton:
        case CCPrevButton:
        case CCNextButton:
        case CCClear:
            return CalendarControllerWidth;
        case CCCalendar:
            return (66.0 * 7);
        case CCDelete:
        case CCPlusMinus:
        case CCDivide:
        case CCMinus:
        case CCMultiply:
        case CCPlus:
        case CCEqual:
        case CCDecimal:
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
        case CCDisplay:
        default:
            NSLog(@"TAG: %d", tag);
            abort();
    }
}

- (CGFloat)portrateSizeHeightWithTag:(NSInteger)tag
{
    static const CGFloat PortrateClearHeight = 176.0;
    switch (tag) {
        case CCDateSelectButton:
        case CCPrevButton:
        case CCNextButton:
        case CCEventButton:
            return (66.0 * 1);
        case CCCalendar:
            return (66.0 * 7);
        case CCClear:
            return PortrateClearHeight;
        case CCEqual:
            return (PortrateHeight * 2);
        case CCDelete:
        case CCPlusMinus:
        case CCDivide:
        case CCMinus:
        case CCMultiply:
        case CCPlus:
        case CCDecimal:
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
        case CCDisplay:
        default:
            NSLog(@"TAG: %d", tag);
            abort();
    }
}

- (CGFloat)landscapeOriginXWithTag:(NSInteger)tag
{
    static const CGFloat Leftmost = 484.0;
    switch (tag) {
        case CCClear:
        case CCDelete:
        case 7:
        case 4:
        case 1:
        case 0:
            return Leftmost + (LandscapeWidth * 0);
        case CCPlusMinus:
        case 8:
        case 5:
        case 2:
        case 10:
            return Leftmost + (LandscapeWidth * 1);
        case CCDivide:
        case 9:
        case 6:
        case 3:
        case CCDecimal:
            return Leftmost + (LandscapeWidth * 2);
        case CCMinus:
        case CCMultiply:
        case CCPlus:
        case CCEqual:
            return Leftmost + (LandscapeWidth * 3);
        case CCCalendar:
            return 0;
        case CCEventButton:
        case CCPrevButton:
            return ASCCalendarMargin;
        case CCDateSelectButton:
            return ASCCalendarMargin + (66.0 * 2);
        case CCNextButton:
            return ASCCalendarMargin + (66.0 * 5);
        case CCDisplay:
        default:
            NSLog(@"TAG: %d", tag);
            abort();
    }
}

- (CGFloat)landscapeOriginYWithTag:(NSInteger)tag
{
    static const CGFloat Topmost = 120.0;
    switch (tag) {
        case CCEventButton:
        case CCClear:
            return Topmost;
        case CCPrevButton:
        case CCDateSelectButton:
        case CCNextButton:
            return Topmost + (66.0 * 1);
        case CCCalendar:
            return Topmost + (66.0 * 2);
        case CCDelete:
        case CCPlusMinus:
        case CCDivide:
        case CCMinus:
            return Topmost + LandscapeClearButtonHeight + (LandscapeHeight * 0);
        case 7:
        case 8:
        case 9:
        case CCMultiply:
            return Topmost + LandscapeClearButtonHeight + (LandscapeHeight * 1);
        case 4:
        case 5:
        case 6:
        case CCPlus:
            return Topmost + LandscapeClearButtonHeight + (LandscapeHeight * 2);
        case 1:
        case 2:
        case 3:
        case CCEqual:
            return Topmost + LandscapeClearButtonHeight + (LandscapeHeight * 3);
        case 0:
        case 10:
        case CCDecimal:
            return Topmost + LandscapeClearButtonHeight + (LandscapeHeight * 4);
        case CCDisplay:
        default:
            NSLog(@"TAG: %d", tag);
            abort();
    }
}

- (CGFloat)landscapeSizeWidthWithTag:(NSInteger)tag
{
    switch (tag) {
        case CCEventButton:
            return (66.0 * 7);
        case CCCalendar:
            return (66.0 * 7);
        case CCPrevButton:
        case CCNextButton:
            return (66.0 * 2);
        case CCDateSelectButton:
            return (66.0 * 3);
        case CCClear:
            return (LandscapeWidth * 4);
        case CCDelete:
        case CCPlusMinus:
        case CCDivide:
        case CCMinus:
        case CCMultiply:
        case CCPlus:
        case CCEqual:
        case CCDecimal:
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
        case CCDisplay:
        default:
            NSLog(@"TAG: %d", tag);
            abort();
    }
}

- (CGFloat)landscapeSizeHeightWithTag:(NSInteger)tag
{
    switch (tag) {
        case CCEventButton:
        case CCPrevButton:
        case CCNextButton:
        case CCDateSelectButton:
            return (66.0 * 1);
        case CCCalendar:
            return (66.0 * 7);
        case CCClear:
            return LandscapeClearButtonHeight;
        case CCEqual:
            return (LandscapeHeight * 2);
        case CCDelete:
        case CCPlusMinus:
        case CCDivide:
        case CCMinus:
        case CCMultiply:
        case CCPlus:
        case CCDecimal:
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
        case CCDisplay:
        default:
            NSLog(@"TAG: %d", tag);
            abort();
    }
}

@end
