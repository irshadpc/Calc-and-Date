//
//  CCViewControllerTests.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/25.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CCViewControllerTests.h"
#import "CCViewController.h"
#import "CCViewController+UnitTest.h"
#import "NSDate+AdditionalConvenienceConstructor.h"

@interface CCViewControllerTests () {
  @private
    CCViewController *_viewController;
    UIView *_view;
}

@end

@implementation CCViewControllerTests

enum {
    DOUBLE_ZERO = 10
};

enum {
    DECIMAL = 301,
    EQUAL,
    PLUS,
    MINUS,
    MULTIPLY,
    DIVIDE,
    CLEAR,
    PLUS_MINUS,
    DELETE,

    FUNCTIONMAX,
};

- (void)setUp
{
    _viewController = [[CCViewController alloc] initWithNibName:@"CCViewController_iPhone" bundle:nil];
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
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];

    STAssertEqualObjects(@"2", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_2_Plus_1_Equal
{
    // 2 + 1 = 3
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];

    STAssertEqualObjects(@"3", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_0_Plus_1_Equal
{
    // 0 + 1 = 1
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];

    STAssertEqualObjects(@"1", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_10_Plus_1_Equal
{
    // 10 + 1 = 11
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];

    STAssertEqualObjects(@"11", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_1_Plus_10_Equal
{
    // 1 + 10 = 11
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];

    STAssertEqualObjects(@"11", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_10_Plus_10_Equal
{
    // 10 + 10 = 20
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];

    STAssertEqualObjects(@"20", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_1_Plus_2_Plus_3_Equal
{
    // 1 + 2 + 3 = 6
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];

    STAssertEqualObjects(@"3", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:3]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];

    STAssertEqualObjects(@"6", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_10_Plus_20_Plus_30_Equal
{
    // 10 + 20 + 30 = 60
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];
    
    STAssertEqualObjects(@"30", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:3]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];

    STAssertEqualObjects(@"60", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_10_Plus_20_Plus_Equal
{
    // 10 + 20 + = 60
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];
    
    STAssertEqualObjects(@"30", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];

    STAssertEqualObjects(@"60", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_10_Plus_20_Equal_Equal
{
    // 10 + 20 = = 50
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];

    STAssertEqualObjects(@"30", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];

    STAssertEqualObjects(@"50", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_10_Plus_2012_07_28_Plus_2012_07_30_Equal
{
    // 10 + 2012/07/28 + 2012/07/30 = 12
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];

    STAssertEqualObjects(@"2012/08/07", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:30]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];

    STAssertEqualObjects(@"8", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_10_Plus_2012_07_28_Plus_12_Plus_3_Plus_2012_08_15_Equal
{
    // 10 + 2012/07/28 + 12 + 3 + 2012/08/15 = 3
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];

    STAssertEqualObjects(@"2012/08/07", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];

    STAssertEqualObjects(@"2012/08/19", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:3]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];

    STAssertEqualObjects(@"2012/08/22", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:8 day:15]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];

    STAssertEqualObjects(@"7", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_Plus_2_Plus_3_Equal
{
    // + 2 + 3 = 5
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];

    STAssertEqualObjects(@"2", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:3]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    
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
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MINUS]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];

    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_2_Minus_1_Equal
{
    // 2 - 1 = 1
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MINUS]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"1", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_0_Minus_1_Equal
{
    // 0 - 1 = -1
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MINUS]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"-1", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_10_Minus_1_Equal
{
    // 10 - 1 = 9
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MINUS]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"9", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_1_Minus_10_Equal
{
    // 1 - 10 = -9
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MINUS]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"-9", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_10_Minus_10_Equal
{
    // 10 - 10 = 0
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MINUS]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_1_Minus_2_Minus_3_Equal
{
    // 1 - 2 - 3 = -4
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MINUS]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MINUS]];
    STAssertEqualObjects(@"-1", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:3]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"-4", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_10_Minus_20_Minus_30_Equal
{
    // 10 - 20 - 30 = -40
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MINUS]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MINUS]];
    STAssertEqualObjects(@"-10", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:3]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"-40", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_10_Minus_20_Minus_Equal
{
    // 10 - 20 - = 0
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MINUS]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MINUS]];
    STAssertEqualObjects(@"-10", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_10_Minus_20_Equal_Equal
{
    // 10 - 20 = = -30
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MINUS]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"-10", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"-30", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_10_Minus_2012_07_28_Minus_2012_07_30_Equal
{
    // 10 - 2012/07/28 - 2012/07/30 = 12
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MINUS]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MINUS]];
    STAssertEqualObjects(@"2012/07/18", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:30]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"-12", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_10_Minus_2012_07_28_Minus_12_Minus_3_Minus_2012_08_15_Equal
{
    // 10 - 2012/07/28 - 12 - 3 - 2012/08/15 = 43
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MINUS]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MINUS]];
    STAssertEqualObjects(@"2012/07/18", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MINUS]];
    STAssertEqualObjects(@"2012/07/06", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:3]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MINUS]];
    STAssertEqualObjects(@"2012/07/03", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:8 day:15]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"-43", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_Minus_2_Minus_3_Equal
{
    // - 2 - 3 = -5
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MINUS]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MINUS]];
    STAssertEqualObjects(@"-2", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:3]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
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
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MULTIPLY]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"2", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_2_Multiply_2_Equal
{
    // 2 * 2 = 4
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MULTIPLY]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"4", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_0_Multiply_2_Equal
{
    // 0 * 2 = 0
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MULTIPLY]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_20_Multiply_2_Equal
{
    // 20 * 2 = 40
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MULTIPLY]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"40", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_2_Multiply_20_Equal
{
    // 2 * 20 = 40
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MULTIPLY]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"40", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_20_Multiply_20_Equal
{
    // 20 * 20 = 400
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MULTIPLY]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"400", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_2_Multiply_2_Multiply_3_Equal
{
    // 2 * 2 * 3 = 12
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MULTIPLY]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MULTIPLY]];
    STAssertEqualObjects(@"4", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:3]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"12", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_20_Multiply_20_Multiply_30_Equal
{
    // 20 * 20 * 30 = 12000
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MULTIPLY]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MULTIPLY]];
    STAssertEqualObjects(@"400", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:3]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"12,000", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_20_Multiply_20_Multiply_Equal
{
    // 20 * 20 * = 160000
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MULTIPLY]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MULTIPLY]];
    STAssertEqualObjects(@"400", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"160,000", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_20_Multiply_20_Equal_Equal
{
    // 20 * 20 = = 8000
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MULTIPLY]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"400", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"8,000", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_20_Mlutiply_2012_07_28_Plus_2012_07_30_Equal
{
    // 10 * 2012/07/28 + 2012/07/30 = 20
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MULTIPLY]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];
    STAssertEqualObjects(@"2012/07/28", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:30]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"20", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_10_Multiply_2012_07_28_Plus_12_Plus_3_2012_08_15_Equal
{
    // 10 * 2012/07/28 + 12 + 3 + 2012/08/15 = 30
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MULTIPLY]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];
    STAssertEqualObjects(@"2012/07/28", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];
    STAssertEqualObjects(@"2012/08/09", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:3]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];
    STAssertEqualObjects(@"2012/08/12", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:8 day:15]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"30", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_Multiply_2_Multiply_3_Equal
{
    // * 2 * 3 = 0
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MULTIPLY]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MULTIPLY]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:3]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
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
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:DIVIDE]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"0.5", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_2_Divide_2_Equal
{
    // 2 / 2 = 1
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:DIVIDE]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"1", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_0_Divide_2_Equal
{
    // 0 / 2 = 0
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:DIVIDE]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_20_Divide_2_Equal
{
    // 20 / 2 = 10
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:DIVIDE]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"10", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_2_Divide_20_Equal
{
    // 2 / 20 = 0.1
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:DIVIDE]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"0.1", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_20_Divide_20_Equal
{
    // 20 / 20 = 1
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:DIVIDE]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"1", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_2_Divide_2_Divide_3_Equal
{
    // 2 / 2 / 3 = 0.333333
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:DIVIDE]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:DIVIDE]];
    STAssertEqualObjects(@"1", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:3]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"0.33333333333", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_20_Divide_20_Divide_30_Equal
{
    // 20 / 20 / 30 = 0.033333
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:DIVIDE]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:DIVIDE]];
    STAssertEqualObjects(@"1", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:3]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"0.03333333333", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_40_Divide_20_Divide_Equal
{
    // 40 / 20 / = 1
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:CLEAR]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:CLEAR]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:4]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:DIVIDE]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:DIVIDE]];
    STAssertEqualObjects(@"2", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"1", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_40_Divide_20_Equal_Equal
{
    // 40 / 20 = = 0.1
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:4]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:DIVIDE]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"2", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"0.1", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_10_Divide_2012_07_28_Plus_2012_07_30_Equal
{
    // 10 / 2012/07/28 + 2012/07/30 = 5
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:DIVIDE]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];
    STAssertEqualObjects(@"2012/07/28", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:30]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"5", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_10_Divide_2012_07_28_Plus_12_Plus_3_2012_08_15_Equal
{
    // 10 / 2012/07/28 + 12 + 3 + 2012/08/15 = 3.333333
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:DIVIDE]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];
    STAssertEqualObjects(@"2012/07/28", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];
    STAssertEqualObjects(@"2012/08/09", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:3]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];
    STAssertEqualObjects(@"2012/08/12", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:8 day:15]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"3.33333333333", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_Divide_2_Divide_3_Equal
{
    // / 2 / 3 = 0
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:DIVIDE]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:DIVIDE]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:3]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
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
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:8 day:15]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"18", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_2012_08_15_Plus_2012_07_28_Equal
{
    // 2012/08/15 + 2012/07/28 = 18
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:8 day:15]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"18", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_2012_07_28_Plus_1_Equal
{
    // 2012/07/28 + 1 = 2012/07/29
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"2012/07/29", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_1_Plus_2012_07_28_Plus_2012_07_29_Equal
{
    // 1 + 2012/07/28 + 2012/07/29 = 2
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];
    STAssertEqualObjects(@"2012/07/29", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:29]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_2012_07_28_Plus_2012_07_29_Equal_Equal
{
    // 2012/07/28 + 2012/07/29 = = 1
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:29]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"1", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"1", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_2012_07_28_Plus_2_Equal_Equal
{
    // 2012/07/28 + 2 = = 2012/08/01
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"2012/07/30", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"2012/08/01", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_Plus_2012_07_28_Plus_2012_07_30_Equal
{
    // + 2012/07/28 + 2012/07/30 = 2
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];
    STAssertEqualObjects(@"2012/07/28", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:30]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"2", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_Plus_2012_07_28_Plus_2_Equal
{
    // + 2012/07/28 + 2 = 2012/07/30
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
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
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MINUS]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:8 day:15]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"-18", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_2012_08_15_Minus_2012_07_28_Equal
{
    // 2012/08/15 - 2012/07/28 = -18
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:8 day:15]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MINUS]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"-18", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_2012_07_28_Minus_1_Equal
{
    // 2012/07/28 - 1 = 2012/07/27
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MINUS]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"2012/07/27", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_1_Minus_2012_07_28_Minus_2012_07_29_Equal
{
    // 1 - 2012/07/28 - 2012/07/29 = 2
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MINUS]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MINUS]];
    STAssertEqualObjects(@"2012/07/27", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:29]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"-2", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_2012_07_28_Minus_2012_07_29_Equal_Equal
{
    // 2012/07/28 - 2012/07/29 = = -1
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MINUS]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:29]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"-1", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"-1", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_2012_07_28_Minus_2_Equal_Equal
{
    // 2012/07/28 - 2 = = 2012/07/24
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MINUS]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"2012/07/26", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"2012/07/24", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_Minus_2012_07_28_Minus_2012_07_30_Equal
{
    // - 2012/07/28 - 2012/07/30 = 2
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MINUS]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MINUS]];
    STAssertEqualObjects(@"2012/07/28", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:30]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"-2", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_Minus_2012_07_28_Minus_2_Equal
{
    // - 2012/07/28 - 2 = 2012/07/26
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MINUS]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MINUS]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
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
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MULTIPLY]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:8 day:15]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_2012_08_15_Multiply_2012_07_28_Equal
{
    // 2012/08/15 * 2012/07/28 = 0
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:8 day:15]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MULTIPLY]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_2012_07_28_Multiply_1_Equal
{
    // 2012/07/28 * 1 = 0
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MULTIPLY]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_1_Multiply_2012_07_28_Plus_2012_07_30_Equal
{
    // 1 * 2012/07/28 + 2012/07/30 = 2
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MULTIPLY]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];
    STAssertEqualObjects(@"2012/07/28", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:30]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"2", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_2012_07_28_Multiply_2012_07_29_Equal_Equal
{
    // 2012/07/28 * 2012/07/29 = = 0
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MULTIPLY]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:29]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_2012_07_28_Multiply_2_Equal_Equal
{
    // 2012/07/28 * 2 = = 0
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MULTIPLY]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_Multiply_2012_07_28_Multiply_2012_07_30_Equal
{
    // * 2012/07/28 * 2012/07/30 = 0
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MULTIPLY]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MULTIPLY]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:30]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_Multiply_2012_07_28_Multiply_2012_07_30_Plus_3_Equal
{
    // * 2012/07/28 * 2012/07/30 + 3 = 0
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MULTIPLY]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MULTIPLY]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:30]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:3]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"3", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_Multiply_2012_07_28_Multiply_2_Equal
{
    // * 2012/07/28 * 2 = 0
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MULTIPLY]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MULTIPLY]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_Multiply_2012_07_28_Multiply_2_Plus_3_Equal
{
    // * 2012/07/28 * 2 + 3 = 3
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MULTIPLY]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MULTIPLY]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MULTIPLY]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:3]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
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
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:DIVIDE]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:8 day:15]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_2012_08_15_Divide_2012_07_28_Equal
{
    // 2012/08/15 / 2012/07/28 = 0
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:8 day:15]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:DIVIDE]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_2012_07_28_Divide_1_Equal
{
    // 2012/07/28 / 1 = 0
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:DIVIDE]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_1_Divide_2012_07_28_Plus_2012_07_30_Equal
{
    // 1 / 2012/07/28 + 2012/07/30 = 0.5
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:DIVIDE]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];
    STAssertEqualObjects(@"2012/07/28", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:30]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"0.5", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_2012_07_28_Divide_2012_07_29_Equal_Equal
{
    // 2012/07/28 / 2012/07/29 = = 0
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:DIVIDE]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:29]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_2012_07_28_Divide_2_Equal_Equal
{
    // 2012/07/28 / 2 = = 0
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:DIVIDE]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_Divide_2012_07_28_Divide_2012_07_30_Equal
{
    // / 2012/07/28 / 2012/07/30 = 0
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:DIVIDE]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:DIVIDE]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:30]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_Divide_2012_07_28_Divide_2012_07_30_Plus_3_Equal
{
    // / 2012/07/28 / 2012/07/30 + 3 = 3
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:DIVIDE]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:DIVIDE]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:30]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:3]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"3", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_Divide_2012_07_28_Divide_2_Equal
{
    // / 2012/07/28 / 2 = 0
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:DIVIDE]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:DIVIDE]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_Divide_2012_07_28_Divide_2_Plus_3_Equal
{
    // / 2012/07/28 / 2 + 3 = 3
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:DIVIDE]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:DIVIDE]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:DIVIDE]];
    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:3]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];
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
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS_MINUS]];

    STAssertEqualObjects(@"-1", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];

    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_1_PlusMinus_00_Plus_200_Equal
{
    // 1 [+/-] [00] + 200 = 100
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS_MINUS]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:DOUBLE_ZERO]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];

    STAssertEqualObjects(@"-100", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];

    STAssertEqualObjects(@"100", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_1_Plus_Equal_PlusMinus_Plus_3_Equal
{

    // 1 + 2 = [+/-] + 3 = 0
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];

    STAssertEqualObjects(@"3", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS_MINUS]];

    STAssertEqualObjects(@"-3", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:3]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];

    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_12345_Delete_Plus_100_Equal
{
    // 12345 [DEL] + 100 = 1,334
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:3]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:4]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:5]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:DELETE]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];

    STAssertEqualObjects(@"1,234", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];

    STAssertEqualObjects(@"1,334", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_12345_Delete_Delete_Plus_100_Equal
{
    // 12345 [DEL] [DEL] + 100 = 223
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:3]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:4]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:5]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:DELETE]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:DELETE]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];

    STAssertEqualObjects(@"123", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];

    STAssertEqualObjects(@"223", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_Minus12345_Delete_Plus_100_Equal
{
    // -12345 [DEL] + 100 = -1,134
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MINUS]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:3]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:4]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:5]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:DELETE]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];

    STAssertEqualObjects(@"-1,234", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];

    STAssertEqualObjects(@"-1,134", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_Minus12345_Delete_Delete_Plus_100_Equal
{
    // -12345 [DEL] [DEL] + 100 = -23
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MINUS]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:3]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:4]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:5]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:DELETE]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:DELETE]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];

    STAssertEqualObjects(@"-123", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];

    STAssertEqualObjects(@"-23", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_123_Delete_Delete_Delete_Plus_100_Equal
{
    // 123 [DEL] [DEL] [DEL] + 100 = 100
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:3]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:DELETE]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:DELETE]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:DELETE]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];

    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];

    STAssertEqualObjects(@"100", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_Minus123_Delete_Delete_Delete_Plus_100_Equal
{
    // -123 [DEL] [DEL] [DEL] + 100 = 100
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:MINUS]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:3]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:DELETE]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:DELETE]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:DELETE]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];

    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];

    STAssertEqualObjects(@"100", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_10_Plus_20_Equal_Delete_Plus_1_Equal
{
    // 10 + 20 = [DEL] + 1 = 4
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];

    STAssertEqualObjects(@"30", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:DELETE]];

    STAssertEqualObjects(@"3", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];

    STAssertEqualObjects(@"4", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_10_Plus_20_Equal_Delete_1_Plus_1_Equal
{
    // 10 + 20 = [DEL]1 + 1 = 32
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];

    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:DELETE]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    STAssertEqualObjects(@"31", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];

    STAssertEqualObjects(@"32", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_0_Decimal_0000012_Delete_Plus_0_Decimal_000002_Equal
{
    // 0.0000012 [DEL] + 0.000002 = 0.000003
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:DECIMAL]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];

    STAssertEqualObjects(@"0.0000012", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:DELETE]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];

    STAssertEqualObjects(@"0.000001", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:DECIMAL]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];

    STAssertEqualObjects(@"0.000002", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];

    STAssertEqualObjects(@"0.000003", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_0_Decimal_0000012_PlusMinus_Plus_0_Decimal_000002_Equal
{
    // 0.0000012 [+/-] + 0.000002 = -0.0000008
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:DECIMAL]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:1]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];

    STAssertEqualObjects(@"0.0000012", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS_MINUS]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];

    STAssertEqualObjects(@"-0.0000012", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:DECIMAL]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:0]];
    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:2]];

    STAssertEqualObjects(@"0.000002", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];

    STAssertEqualObjects(@"0.0000008", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_Decimal_2012_07_28_Plus_3_Equal
{
    // [.] 2012/07/28 + 3 = 2012/07/31
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:DECIMAL]];
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];

    STAssertEqualObjects(@"2012/07/28", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];

    STAssertEqualObjects(@"2012/07/28", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:3]];

    STAssertEqualObjects(@"3", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];

    STAssertEqualObjects(@"2012/07/31", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_2012_07_28_Delete_Plus_3_Equal
{
    // 2012/07/28 [DEL] + 3 = 3
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:DELETE]];

    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];

    STAssertEqualObjects(@"0", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:3]];

    STAssertEqualObjects(@"3", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];

    STAssertEqualObjects(@"3", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}

- (void)test_2012_07_28_PlusMinus_Plus_3_Equal
{
    // 2012/07/28 [+/-] + 3 = 2012/07/28
    [_viewController inputOutDate:[NSDate dateWithYear:2012 month:7 day:28]];
    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS_MINUS]];

    STAssertEqualObjects(@"2012/07/28", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:PLUS]];

    STAssertEqualObjects(@"2012/07/28", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressNumberButton:(UIButton *)[_view viewWithTag:3]];

    STAssertEqualObjects(@"3", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);

    [_viewController pressFunctionButton:(UIButton *)[_view viewWithTag:EQUAL]];

    STAssertEqualObjects(@"2012/07/31", [_viewController resultText], @"RESULT: %@", [_viewController resultText]);
}
//}}}

@end
