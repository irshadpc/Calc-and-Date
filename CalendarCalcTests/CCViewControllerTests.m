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
    // 10 + 20 = [DEL] + 1 = 31
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
