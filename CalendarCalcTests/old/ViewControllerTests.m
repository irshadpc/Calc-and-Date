//
//  CCViewControllerTests.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/25.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "ViewControllerTests.h"
#import "CalendarCalcViewController_iPhone.h"
#import "CalendarCalcViewController+UnitTest.h"
#import "NSDate+AdditionalConvenienceConstructor.h"
#import "Function.h"

@interface ViewControllerTests () {
  @private
    CalendarCalcViewController_iPhone *_viewController;
    UIView *_view;
}

@end

@implementation ViewControllerTests
static const NSInteger DOUBLE_ZERO = 10;

- (void)setUp
{
    _viewController = [[CalendarCalcViewController_iPhone alloc] initWithNibName:@"CalendarCalcViewController_iPhone"
                                                                          bundle:nil];
    _view = _viewController.view;
}

// {{{ plus
// 01.同じ値同士
// 02.別の値同士
// 03.０での演算
// 04.２桁と１桁
// 05.１桁と２桁
// 06.２桁と２桁
// 07.１桁での３項
// 08.２桁での３項
// 10.イコール２度連続
// 11.数字と日付加算の複合(日付差)
// 12.数字と日付加算の複合(日付加算および日付差)
// 13.演算子から始まる演算
- (void)test_1_Plus_1_Equal
{
    // 1 + 1 = 2
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];

    STAssertEqualObjects(@"2", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_2_Plus_1_Equal
{
    // 2 + 1 = 3
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];

    STAssertEqualObjects(@"3", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_0_Plus_1_Equal
{
    // 0 + 1 = 1
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];

    STAssertEqualObjects(@"1", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_10_Plus_1_Equal
{
    // 10 + 1 = 11
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];

    STAssertEqualObjects(@"11", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_1_Plus_10_Equal
{
    // 1 + 10 = 11
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];

    STAssertEqualObjects(@"11", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_10_Plus_10_Equal
{
    // 10 + 10 = 20
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];

    STAssertEqualObjects(@"20", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_1_Plus_2_Plus_3_Equal
{
    // 1 + 2 + 3 = 6
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];

    STAssertEqualObjects(@"3", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:3]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];

    STAssertEqualObjects(@"6", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_10_Plus_20_Plus_30_Equal
{
    // 10 + 20 + 30 = 60
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];
    
    STAssertEqualObjects(@"30", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:3]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];

    STAssertEqualObjects(@"60", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_10_Plus_20_Plus_Equal_Equal
{
    // 10 + 20 + = = 90
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];
    
    STAssertEqualObjects(@"30", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];

    STAssertEqualObjects(@"60", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];

    STAssertEqualObjects(@"90", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_10_Plus_20_Equal_Equal
{
    // 10 + 20 = = = 70
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];

    STAssertEqualObjects(@"30", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];

    STAssertEqualObjects(@"50", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];

    STAssertEqualObjects(@"70", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_10_Plus_2012_07_28_Plus_2012_07_30_Equal
{
    // 10 + 2012/07/28 + 2012/07/30 = 12
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];

    STAssertEqualObjects(@"2012/08/07", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:30]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];

    STAssertEqualObjects(@"8", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_10_Plus_2012_07_28_Plus_12_Plus_3_Plus_2012_08_15_Equal
{
    // 10 + 2012/07/28 + 12 + 3 + 2012/08/15 = 3
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];

    STAssertEqualObjects(@"2012/08/07", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];

    STAssertEqualObjects(@"2012/08/19", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:3]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];

    STAssertEqualObjects(@"2012/08/22", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:8 day:15]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];

    STAssertEqualObjects(@"7", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_Plus_2_Plus_3_Equal
{
    // + 2 + 3 = 5
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];

    STAssertEqualObjects(@"2", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:3]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    
    STAssertEqualObjects(@"5", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}
//}}}

//{{{ minus
// 01.同じ値同士
// 02.別の値同士
// 03.０での演算
// 04.２桁と１桁
// 05.１桁と２桁
// 06.２桁と２桁
// 07.１桁での３項
// 08.２桁での３項
// 10.イコール２度連続
// 11.数字と日付加算の複合(日付差)
// 12.数字と日付加算の複合(日付加算および日付差)
// 13.演算子から始まる演算
- (void)test_1_Minus_1_Equal
{
    // 1 - 1 = 0
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMinus]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];

    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_2_Minus_1_Equal
{
    // 2 - 1 = 1
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMinus]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"1", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_0_Minus_1_Equal
{
    // 0 - 1 = -1
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMinus]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"-1", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_10_Minus_1_Equal
{
    // 10 - 1 = 9
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMinus]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"9", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_1_Minus_10_Equal
{
    // 1 - 10 = -9
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMinus]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"-9", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_10_Minus_10_Equal
{
    // 10 - 10 = 0
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMinus]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_1_Minus_2_Minus_3_Equal
{
    // 1 - 2 - 3 = -4
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMinus]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMinus]];
    STAssertEqualObjects(@"-1", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:3]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"-4", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_10_Minus_20_Minus_30_Equal
{
    // 10 - 20 - 30 = -40
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMinus]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMinus]];
    STAssertEqualObjects(@"-10", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:3]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"-40", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_10_Minus_20_Minus_Equal_Equal
{
    // 10 - 20 - = = 10
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMinus]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMinus]];
    STAssertEqualObjects(@"-10", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"10", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_10_Minus_20_Equal_Equal_Equal
{
    // 10 - 20 = = = -50
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMinus]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"-10", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"-30", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"-50", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_10_Minus_2012_07_28_Minus_2012_07_30_Equal
{
    // 10 - 2012/07/28 - 2012/07/30 = 12
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMinus]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMinus]];
    STAssertEqualObjects(@"2012/07/18", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:30]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"-12", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_10_Minus_2012_07_28_Minus_12_Minus_3_Minus_2012_08_15_Equal
{
    // 10 - 2012/07/28 - 12 - 3 - 2012/08/15 = 43
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMinus]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMinus]];
    STAssertEqualObjects(@"2012/07/18", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMinus]];
    STAssertEqualObjects(@"2012/07/06", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:3]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMinus]];
    STAssertEqualObjects(@"2012/07/03", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:8 day:15]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"-43", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_Minus_2_Minus_3_Equal
{
    // - 2 - 3 = -5
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMinus]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMinus]];
    STAssertEqualObjects(@"-2", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:3]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"-5", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}
//}}}

//{{{ multiply
// 01.同じ値同士
// 02.別の値同士
// 03.０での演算
// 04.２桁と１桁
// 05.１桁と２桁
// 06.２桁と２桁
// 07.１桁での３項
// 08.２桁での３項
// 10.イコール２度連続
// 11.数字と日付加算の複合(日付差)
// 12.数字と日付加算の複合(日付加算および日付差)
// 13.演算子から始まる演算
- (void)test_1_Multiply_2_Equal
{
    // 1 * 2 = 2
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMultiply]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"2", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_2_Multiply_2_Equal
{
    // 2 * 2 = 4
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMultiply]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"4", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_0_Multiply_2_Equal
{
    // 0 * 2 = 0
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMultiply]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_20_Multiply_2_Equal
{
    // 20 * 2 = 40
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMultiply]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"40", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_2_Multiply_20_Equal
{
    // 2 * 20 = 40
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMultiply]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"40", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_20_Multiply_20_Equal
{
    // 20 * 20 = 400
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMultiply]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"400", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_2_Multiply_2_Multiply_3_Equal
{
    // 2 * 2 * 3 = 12
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMultiply]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMultiply]];
    STAssertEqualObjects(@"4", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:3]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"12", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_20_Multiply_20_Multiply_30_Equal
{
    // 20 * 20 * 30 = 12000
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMultiply]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMultiply]];
    STAssertEqualObjects(@"400", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:3]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"12,000", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_20_Multiply_20_Multiply_Equal_Equal
{
    // 20 * 20 * = = 64000000
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMultiply]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMultiply]];
    STAssertEqualObjects(@"400", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"160,000", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"64,000,000", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_20_Multiply_20_Equal_Equal_Equal
{
    // 20 * 20 = = = 160000
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMultiply]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"400", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"8,000", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"160,000", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_20_Mlutiply_2012_07_28_Plus_2012_07_30_Equal
{
    // 10 * 2012/07/28 + 2012/07/30 = 20
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMultiply]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];
    STAssertEqualObjects(@"2012/07/28", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:30]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"20", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_10_Multiply_2012_07_28_Plus_12_Plus_3_2012_08_15_Equal
{
    // 10 * 2012/07/28 + 12 + 3 + 2012/08/15 = 30
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMultiply]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];
    STAssertEqualObjects(@"2012/07/28", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];
    STAssertEqualObjects(@"2012/08/09", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:3]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];
    STAssertEqualObjects(@"2012/08/12", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:8 day:15]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"30", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_Multiply_2_Multiply_3_Equal
{
    // * 2 * 3 = 0
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMultiply]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMultiply]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:3]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}
//}}}

//{{{ divide
// 01.同じ値同士
// 02.別の値同士
// 03.０での演算
// 04.２桁と１桁
// 05.１桁と２桁
// 06.２桁と２桁
// 07.１桁での３項
// 08.２桁での３項
// 10.イコール２度連続
// 11.数字と日付加算の複合(日付差)
// 12.数字と日付加算の複合(日付加算および日付差)
// 13.演算子から始まる演算
- (void)test_1_Divide_2_Equal
{
    // 1 / 2 = 0.5
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionDivide]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"0.5", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_2_Divide_2_Equal
{
    // 2 / 2 = 1
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionDivide]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"1", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_0_Divide_2_Equal
{
    // 0 / 2 = 0
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionDivide]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_20_Divide_2_Equal
{
    // 20 / 2 = 10
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionDivide]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"10", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_2_Divide_20_Equal
{
    // 2 / 20 = 0.1
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionDivide]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"0.1", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_20_Divide_20_Equal
{
    // 20 / 20 = 1
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionDivide]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"1", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_2_Divide_2_Divide_3_Equal
{
    // 2 / 2 / 3 = 0.333333
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionDivide]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionDivide]];
    STAssertEqualObjects(@"1", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:3]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"0.33333333333", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_20_Divide_20_Divide_30_Equal
{
    // 20 / 20 / 30 = 0.033333
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionDivide]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionDivide]];
    STAssertEqualObjects(@"1", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:3]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"0.03333333333", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_40_Divide_20_Divide_Equal_Equal
{
    // 40 / 20 / = = 0.5
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionClear]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionClear]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:4]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionDivide]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionDivide]];
    STAssertEqualObjects(@"2", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"1", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"0.5", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_40_Divide_20_Equal_Equal_Equal
{
    // 40 / 20 = = = 0.005
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:4]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionDivide]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"2", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"0.1", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"0.005", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_10_Divide_2012_07_28_Plus_2012_07_30_Equal
{
    // 10 / 2012/07/28 + 2012/07/30 = 5
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionDivide]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];
    STAssertEqualObjects(@"2012/07/28", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:30]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"5", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_10_Divide_2012_07_28_Plus_12_Plus_3_Plus_2012_08_15_Equal
{
    // 10 / 2012/07/28 + 12 + 3 + 2012/08/15 = 3.333333
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionDivide]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];
    STAssertEqualObjects(@"2012/07/28", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];
    STAssertEqualObjects(@"2012/08/09", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:3]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];
    STAssertEqualObjects(@"2012/08/12", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:8 day:15]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"3.33333333333", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_Divide_2_Divide_3_Equal
{
    // / 2 / 3 = 0
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionDivide]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionDivide]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:3]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}
//}}}

// {{{ date plus
// 01.小さい日付と大きい日付
// 02.大きい日付と小さい日付
// 03.日付と数値
// 04.数字と日付差
// 05.日付差でイコール２度連続
// 06.日付と数値でイコール２度連続
// 07.演算子から始まる日付差
// 08.演算子から始まる日付と数値
- (void)test_2012_07_28_Plus_2012_08_15_Equal
{
    // 2012/07/28 + 2012/08/15 = 18
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:8 day:15]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"18", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_2012_08_15_Plus_2012_07_28_Equal
{
    // 2012/08/15 + 2012/07/28 = 18
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:8 day:15]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"18", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_2012_07_28_Plus_1_Equal
{
    // 2012/07/28 + 1 = 2012/07/29
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"2012/07/29", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_1_Plus_2012_07_28_Plus_2012_07_29_Equal
{
    // 1 + 2012/07/28 + 2012/07/29 = 2
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];
    STAssertEqualObjects(@"2012/07/29", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:29]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_2012_07_28_Plus_2012_07_29_Equal_Equal
{
    // 2012/07/28 + 2012/07/29 = = 1
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:29]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"1", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"2", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_2012_07_28_Plus_2_Equal_Equal
{
    // 2012/07/28 + 2 = = 2012/08/01
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"2012/07/30", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"2012/08/01", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_Plus_2012_07_28_Plus_2012_07_30_Equal
{
    // + 2012/07/28 + 2012/07/30 = 2
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];
    STAssertEqualObjects(@"2012/07/28", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:30]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"2", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_Plus_2012_07_28_Plus_2_Equal
{
    // + 2012/07/28 + 2 = 2012/07/30
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"2012/07/30", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}
//}}}

// {{{ date minus
// 01.小さい日付と大きい日付
// 02.大きい日付と小さい日付
// 03.日付と数値
// 04.数字と日付差
// 05.日付差でイコール２度連続
// 06.日付と数値でイコール２度連続
// 07.演算子から始まる日付差
// 08.演算子から始まる日付と数値
- (void)test_2012_07_28_Minus_2012_08_15_Equal
{
    // 2012/07/28 - 2012/08/15 = -18
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMinus]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:8 day:15]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"-18", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_2012_08_15_Minus_2012_07_28_Equal
{
    // 2012/08/15 - 2012/07/28 = -18
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:8 day:15]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMinus]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"-18", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_2012_07_28_Minus_1_Equal
{
    // 2012/07/28 - 1 = 2012/07/27
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMinus]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"2012/07/27", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_1_Minus_2012_07_28_Minus_2012_07_29_Equal
{
    // 1 - 2012/07/28 - 2012/07/29 = 2
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMinus]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMinus]];
    STAssertEqualObjects(@"2012/07/27", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:29]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"-2", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_2012_07_28_Minus_2012_07_29_Equal_Equal
{
    // 2012/07/28 - 2012/07/29 = = -1
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMinus]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:29]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"-1", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"-2", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_2012_07_28_Minus_2_Equal_Equal
{
    // 2012/07/28 - 2 = = 2012/07/24
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMinus]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"2012/07/26", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"2012/07/24", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_Minus_2012_07_28_Minus_2012_07_30_Equal
{
    // - 2012/07/28 - 2012/07/30 = 2
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMinus]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMinus]];
    STAssertEqualObjects(@"2012/07/28", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:30]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"-2", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_Minus_2012_07_28_Minus_2_Equal
{
    // - 2012/07/28 - 2 = 2012/07/26
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMinus]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMinus]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"2012/07/26", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}
//}}}

// {{{ date multi
// 01.小さい日付と大きい日付
// 02.大きい日付と小さい日付
// 03.日付と数値
// 04.数字と日付差
// 05.日付差でイコール２度連続
// 06.日付と数値でイコール２度連続
// 07.演算子から始まる日付差
// 08.演算子から始まる日付差と数値
// 09.演算子から始まる日付と数値
// 10.演算子から始まる日付と数値と数値
- (void)test_2012_07_28_Multiply_2012_08_15_Equal
{
    // 2012/07/28 * 2012/08/15 = 0
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMultiply]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:8 day:15]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_2012_08_15_Multiply_2012_07_28_Equal
{
    // 2012/08/15 * 2012/07/28 = 0
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:8 day:15]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMultiply]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_2012_07_28_Multiply_1_Equal
{
    // 2012/07/28 * 1 = 0
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMultiply]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_1_Multiply_2012_07_28_Plus_2012_07_30_Equal
{
    // 1 * 2012/07/28 + 2012/07/30 = 2
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMultiply]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];
    STAssertEqualObjects(@"2012/07/28", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:30]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"2", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_2012_07_28_Multiply_2012_07_29_Equal_Equal
{
    // 2012/07/28 * 2012/07/29 = = 0
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMultiply]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:29]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_2012_07_28_Multiply_2_Equal_Equal
{
    // 2012/07/28 * 2 = = 0
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMultiply]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_Multiply_2012_07_28_Multiply_2012_07_30_Equal
{
    // * 2012/07/28 * 2012/07/30 = 0
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMultiply]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMultiply]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:30]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_Multiply_2012_07_28_Multiply_2012_07_30_Plus_3_Equal
{
    // * 2012/07/28 * 2012/07/30 + 3 = 0
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMultiply]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMultiply]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:30]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:3]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"3", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_Multiply_2012_07_28_Multiply_2_Equal
{
    // * 2012/07/28 * 2 = 0
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMultiply]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMultiply]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_Multiply_2012_07_28_Multiply_2_Plus_3_Equal
{
    // * 2012/07/28 * 2 + 3 = 3
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMultiply]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMultiply]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMultiply]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:3]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"3", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}
//}}}

// {{{ date divide
// 01.小さい日付と大きい日付
// 02.大きい日付と小さい日付
// 03.日付と数値
// 04.数字と日付差
// 05.日付差でイコール２度連続
// 06.日付と数値でイコール２度連続
// 07.演算子から始まる日付差
// 08.演算子から始まる日付差と数値
// 09.演算子から始まる日付と数値
// 10.演算子から始まる日付と数値と数値
- (void)test_2012_07_28_Divide_2012_08_15_Equal
{
    // 2012/07/28 / 2012/08/15 = 0
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionDivide]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:8 day:15]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_2012_08_15_Divide_2012_07_28_Equal
{
    // 2012/08/15 / 2012/07/28 = 0
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:8 day:15]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionDivide]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_2012_07_28_Divide_1_Equal
{
    // 2012/07/28 / 1 = 0
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionDivide]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_1_Divide_2012_07_28_Plus_2012_07_30_Equal
{
    // 1 / 2012/07/28 + 2012/07/30 = 0.5
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionDivide]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];
    STAssertEqualObjects(@"2012/07/28", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:30]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"0.5", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_2012_07_28_Divide_2012_07_29_Equal_Equal
{
    // 2012/07/28 / 2012/07/29 = = 0
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionDivide]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:29]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_2012_07_28_Divide_2_Equal_Equal
{
    // 2012/07/28 / 2 = = 0
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionDivide]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_Divide_2012_07_28_Divide_2012_07_30_Equal
{
    // / 2012/07/28 / 2012/07/30 = 0
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionDivide]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionDivide]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:30]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_Divide_2012_07_28_Divide_2012_07_30_Plus_3_Equal
{
    // / 2012/07/28 / 2012/07/30 + 3 = 3
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionDivide]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionDivide]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:30]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:3]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"3", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_Divide_2012_07_28_Divide_2_Equal
{
    // / 2012/07/28 / 2 = 0
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionDivide]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionDivide]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_Divide_2012_07_28_Divide_2_Plus_3_Equal
{
    // / 2012/07/28 / 2 + 3 = 3
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionDivide]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionDivide]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionDivide]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:3]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];
    STAssertEqualObjects(@"3", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}
//}}}

// {{{ function
// 01.プラスマイナスの後に演算子
// 02.プラスマイナスの後に数値
// 03.演算結果にプラスマイナス後もう一度演算
// 04.Delete１回
// 05.Delete２回
// 06.マイナスの値にDelete１回
// 07.マイナスの値にDelete２回
// 08.Deleteですべて削除後演算
// 09.マイナスの値をDeleteですべて削除後演算
// 10.結果にDelete後演算
// 11.小数Delete後演算
// 12.小数にプラスマイナスの後に演算
// 13.小数点ボタンの後に日付の後に演算
// 14.日付をDelete後演算
// 15.日付にプラスマイナスの後に演算
- (void)test_1_PlusMinus_Plus_1_Equal
{
    // 1 [+/-] + 1 = 0
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlusMinus]];

    STAssertEqualObjects(@"-1", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];

    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_1_PlusMinus_00_Plus_200_Equal
{
    // 1 [+/-] [00] + 200 = 100
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlusMinus]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:DOUBLE_ZERO]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];

    STAssertEqualObjects(@"-100", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];

    STAssertEqualObjects(@"100", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_10_Plus_2_PlusMinus_Equal
{
    // 10 + 2 [+/-] + = 8
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlusMinus]];
    
    STAssertEqualObjects(@"-2", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];

    STAssertEqualObjects(@"8", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_1_Plus_2_Equal_PlusMinus_Plus_3_Equal
{

    // 1 + 2 = [+/-] + 3 = 0
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];

    STAssertEqualObjects(@"3", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlusMinus]];

    STAssertEqualObjects(@"-3", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:3]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];

    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_12345_Delete_Plus_100_Equal
{
    // 12345 [DEL] + 100 = 1,334
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:3]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:4]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:5]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionDelete]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];

    STAssertEqualObjects(@"1,234", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];

    STAssertEqualObjects(@"1,334", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_12345_Delete_Delete_Plus_100_Equal
{
    // 12345 [DEL] [DEL] + 100 = 223
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:3]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:4]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:5]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionDelete]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionDelete]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];

    STAssertEqualObjects(@"123", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];

    STAssertEqualObjects(@"223", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_Minus12345_Delete_Plus_100_Equal
{
    // -12345 [DEL] + 100 = -1,134
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMinus]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:3]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:4]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:5]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionDelete]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];

    STAssertEqualObjects(@"-1,234", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];

    STAssertEqualObjects(@"-1,134", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_Minus12345_Delete_Delete_Plus_100_Equal
{
    // -12345 [DEL] [DEL] + 100 = -23
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMinus]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:3]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:4]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:5]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionDelete]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionDelete]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];

    STAssertEqualObjects(@"-123", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];

    STAssertEqualObjects(@"-23", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_123_Delete_Delete_Delete_Plus_100_Equal
{
    // 123 [DEL] [DEL] [DEL] + 100 = 100
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:3]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionDelete]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionDelete]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionDelete]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];

    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];

    STAssertEqualObjects(@"100", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_Minus123_Delete_Delete_Delete_Plus_100_Equal
{
    // -123 [DEL] [DEL] [DEL] + 100 = 100
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionMinus]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:3]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionDelete]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionDelete]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionDelete]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];

    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];

    STAssertEqualObjects(@"100", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_10_Plus_20_Equal_Delete_Plus_1_Equal
{
    // 10 + 20 = [DEL] + 1 = 4
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];

    STAssertEqualObjects(@"30", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionDelete]];

    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];

    STAssertEqualObjects(@"31", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_10_Plus_20_Equal_Delete_1_Plus_1_Equal
{
    // 10 + 20 = [DEL]1 + 1 = 32
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];

    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionDelete]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    STAssertEqualObjects(@"1", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];

    STAssertEqualObjects(@"2", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_0_Decimal_0000012_Delete_Plus_0_Decimal_000002_Equal
{
    // 0.0000012 [DEL] + 0.000002 = 0.000003
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionDecimal]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];

    STAssertEqualObjects(@"0.0000012", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionDelete]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];

    STAssertEqualObjects(@"0.000001", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionDecimal]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];

    STAssertEqualObjects(@"0.000002", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];

    STAssertEqualObjects(@"0.000003", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_10_Plus_32_Delete_Equal
{
    // 10 + 32 [DEL] = 13
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:3]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionDelete]];
    STAssertEqualObjects(@"3", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];

    STAssertEqualObjects(@"13", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_0_Decimal_0000012_PlusMinus_Plus_0_Decimal_000002_Equal
{
    // 0.0000012 [+/-] + 0.000002 = -0.0000008
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionDecimal]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];

    STAssertEqualObjects(@"0.0000012", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlusMinus]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];

    STAssertEqualObjects(@"-0.0000012", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionDecimal]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:2]];

    STAssertEqualObjects(@"0.000002", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];

    STAssertEqualObjects(@"0.0000008", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_Decimal_2012_07_28_Plus_3_Equal
{
    // [.] 2012/07/28 + 3 = 2012/07/31
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionDecimal]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];

    STAssertEqualObjects(@"2012/07/28", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];

    STAssertEqualObjects(@"2012/07/28", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:3]];

    STAssertEqualObjects(@"3", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];

    STAssertEqualObjects(@"2012/07/31", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_2012_07_28_Delete_Plus_3_Equal
{
    // 2012/07/28 [DEL] + 3 = 3
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionDelete]];

    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];

    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:3]];

    STAssertEqualObjects(@"3", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];

    STAssertEqualObjects(@"3", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_2012_07_28_PlusMinus_Plus_3_Equal
{
    // 2012/07/28 [+/-] + 3 = 2012/07/28
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlusMinus]];

    STAssertEqualObjects(@"2012/07/28", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlus]];

    STAssertEqualObjects(@"2012/07/28", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:3]];

    STAssertEqualObjects(@"3", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionEqual]];

    STAssertEqualObjects(@"2012/07/31", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_PlusMinus
{
    [_viewController pressCalcKey:(UIButton *)[_view viewWithTag:FunctionPlusMinus]];
    STAssertEqualObjects(@"-0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}
//}}}

@end
