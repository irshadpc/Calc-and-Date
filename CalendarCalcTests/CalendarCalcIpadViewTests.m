//
//  CalendarCalcIpadViewTests.m
//  CalendarCalc
//
//  Created by Junichi Ishida on 2012/08/06.
//
//

#import "CalendarCalcIpadViewTests.h"
#import "NSDate+Util.h"

@implementation CalendarCalcIpadViewTests
/*
enum {
    DOT = 301,
    EQUAL,
    PLUS,
    MINUS,
    MULTI,
    DIVIDE,
    CLEAR,
    PLUS_MINUS,
    DELETE,
    DATE_BUTTON,
    ZERO = 900,
    ONE,
    TWO,
    THREE,
    FOUR,
    FIVE,
    SIX,
    SEVEN,
    EIGHT,
    NINE,
    DOUBLE_ZERO = 910,
};

- (void) setUp {
    delegate = [[UIApplication sharedApplication] delegate];
    viewController = delegate.ipadViewController;
    calendarCalcView = viewController.view;
}

- (void) testAppDelegate {
    STAssertNotNil(delegate, @"Cannot find the application delegate");
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
- (void) testPlus1 {
    // 1 + 1 = 2
    NSLog(@"1 + 1 = 2");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"1"], @"plus1-1 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"1"], @"plus1-1 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"2"], @"plus1-1 failed. :%@", [viewController.resultText text]);
    
    // 2 + 1 = 3
    NSLog(@"2 + 1 = 3");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"3"], @"plus1-2 failed. :%@", [viewController.resultText text]);
    
    // 0 + 1 = 1
    NSLog(@"0 + 1 = 1");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"1"], @"plus1-3 failed. :%@", [viewController.resultText text]);
    
    // 10 + 1 = 11
    NSLog(@"10 + 1 = 11");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"11"], @"plus1-4 failed. :%@", [viewController.resultText text]);
    
    // 1 + 10 = 11
    NSLog(@"1 + 10 = 11");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"11"], @"plus1-5 failed. :%@", [viewController.resultText text]);
    
    // 10 + 10 = 20
    NSLog(@"10 + 10 = 20");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"20"], @"plus1-6 failed. :%@", [viewController.resultText text]);
    
    // 1 + 2 + 3 = 6
    NSLog(@"1 + 2 + 3 = 6");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"3"], @"plus1-7-1 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:THREE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"6"], @"plus1-7-2 failed. :%@", [viewController.resultText text]);
    
    // 10 + 20 + 30 = 60
    NSLog(@"10 + 20 + 30 = 60");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"30"], @"plus1-8-1 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:THREE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"60"], @"plus1-8-2 failed. :%@", [viewController.resultText text]);
    
    // 10 + 20 + = 60
    // NSLog(@"10 + 20 + = 60");
    // [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    // [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    // [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    // [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    // [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    // [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    // [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    // [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    // STAssertTrue([[viewController.resultText text] isEqualToString:@"30"], @"plus1-9-1 failed. :%@", [viewController.resultText text]);
    // [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    // STAssertTrue([[viewController.resultText text] isEqualToString:@"60"], @"plus1-9-2 failed. :%@", [viewController.resultText text]);
    
    // 10 + 20 = = 50
    NSLog(@"10 + 20 = = 50");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"30"], @"plus1-10-1 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"50"], @"plus1-10-2 failed. :%@", [viewController.resultText text]);
    
    // 10 + 2012/07/28 + 2012/07/30 = 12
    NSLog(@"10 + 2012/07/28 + 2012/07/30 = 12");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    [viewController inputOutDate:[NSDate dateWithDay:28 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    //STAssertTrue([[viewController.resultText text] isEqualToString:@"2012/07/28"], @"plus1-11-1 failed. :%@", [viewController.resultText text]);
    STAssertTrue([[viewController.resultText text] isEqualToString:@"2012/08/07"], @"plus1-11-1 failed. :%@", [viewController.resultText text]);
    [viewController inputOutDate:[NSDate dateWithDay:30 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    //STAssertTrue([[viewController.resultText text] isEqualToString:@"12"], @"plus1-11-2 failed. :%@", [viewController.resultText text]);
    STAssertTrue([[viewController.resultText text] isEqualToString:@"8"], @"plus1-11-2 failed. :%@", [viewController.resultText text]);
    
    // 10 + 2012/07/28 + 12 + 3 + 2012/08/15 = 3
    NSLog(@"10 + 2012/07/28 + 12 + 3 + 2012/08/15 = 3");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    [viewController inputOutDate:[NSDate dateWithDay:28 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    //STAssertTrue([[viewController.resultText text] isEqualToString:@"2012/07/28"], @"plus1-12-1 failed. :%@", [viewController.resultText text]);
    STAssertTrue([[viewController.resultText text] isEqualToString:@"2012/08/07"], @"plus1-12-1 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    //STAssertTrue([[viewController.resultText text] isEqualToString:@"2012/08/09"], @"plus1-12-2 failed. :%@", [viewController.resultText text]);
    STAssertTrue([[viewController.resultText text] isEqualToString:@"2012/08/19"], @"plus1-12-2 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:THREE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    //STAssertTrue([[viewController.resultText text] isEqualToString:@"2012/08/12"], @"plus1-12-3 failed. :%@", [viewController.resultText text]);
    STAssertTrue([[viewController.resultText text] isEqualToString:@"2012/08/22"], @"plus1-12-3 failed. :%@", [viewController.resultText text]);
    [viewController inputOutDate:[NSDate dateWithDay:15 month:8 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    //STAssertTrue([[viewController.resultText text] isEqualToString:@"13"], @"plus1-12-4 failed. :%@", [viewController.resultText text]);
    STAssertTrue([[viewController.resultText text] isEqualToString:@"7"], @"plus1-12-4 failed. :%@", [viewController.resultText text]);
    
    // + 2 + 3 = 5
    NSLog(@"+ 3 + 3 = 6");
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"2"], @"plus1-13-1 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:THREE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"5"], @"plus1-13-2 failed. :%@", [viewController.resultText text]);
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
- (void) testMinus1 {
    // 1 - 1 = 0
    NSLog(@"1 - 1 = 0");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MINUS]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0"], @"minus1-1 failed. :%@", [viewController.resultText text]);
    
    // 2 - 1 = 1
    NSLog(@"2 - 1 = 1");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MINUS]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"1"], @"minus1-2 failed. :%@", [viewController.resultText text]);
    
    // 0 - 1 = -1
    NSLog(@"0 - 1 = -1");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MINUS]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"-1"], @"minus1-3 failed. :%@", [viewController.resultText text]);
    
    // 10 - 1 = 9
    NSLog(@"10 - 1 = 9");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MINUS]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"9"], @"minus1-4 failed. :%@", [viewController.resultText text]);
    
    // 1 - 10 = -9
    NSLog(@"1 - 10 = -9");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MINUS]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"-9"], @"minus1-5 failed. :%@", [viewController.resultText text]);
    
    // 10 - 10 = 0
    NSLog(@"10 - 10 = 0");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MINUS]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0"], @"minus1-6 failed. :%@", [viewController.resultText text]);
    
    // 1 - 2 - 3 = -4
    NSLog(@"1 - 2 - 3 = -4");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MINUS]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MINUS]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"-1"], @"minus1-7-1 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:THREE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"-4"], @"minus1-7-2 failed. :%@", [viewController.resultText text]);
    
    // 10 - 20 - 30 = -40
    NSLog(@"10 - 20 - 30 = -40");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MINUS]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MINUS]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"-10"], @"minus1-8-1 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:THREE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"-40"], @"minus1-8-2 failed. :%@", [viewController.resultText text]);
    
    // 10 - 20 - = 0
    // NSLog(@"10 - 20 - = 0");
    // [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    // [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    // [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    // [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    // [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MINUS]];
    // [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    // [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    // [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MINUS]];
    // STAssertTrue([[viewController.resultText text] isEqualToString:@"-10"], @"minus1-9-1 failed. :%@", [viewController.resultText text]);
    // [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    // STAssertTrue([[viewController.resultText text] isEqualToString:@"0"], @"minus1-9-2 failed. :%@", [viewController.resultText text]);
    
    // 10 - 20 = = -30
    NSLog(@"10 - 20 = = -30");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MINUS]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"-10"], @"minus1-10-1 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"-30"], @"minus1-10-2 failed. :%@", [viewController.resultText text]);
    
    // 10 - 2012/07/28 - 2012/07/30 = 12
    NSLog(@"10 - 2012/07/28 - 2012/07/30 = 12");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MINUS]];
    [viewController inputOutDate:[NSDate dateWithDay:28 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MINUS]];
    //STAssertTrue([[viewController.resultText text] isEqualToString:@"2012/07/28"], @"minus1-11-1 failed. :%@", [viewController.resultText text]);
    STAssertTrue([[viewController.resultText text] isEqualToString:@"2012/07/18"], @"minus1-11-1 failed. :%@", [viewController.resultText text]);
    [viewController inputOutDate:[NSDate dateWithDay:30 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    //STAssertTrue([[viewController.resultText text] isEqualToString:@"12"], @"minus1-11-2 failed. :%@", [viewController.resultText text]);
    STAssertTrue([[viewController.resultText text] isEqualToString:@"-12"], @"minus1-11-2 failed. :%@", [viewController.resultText text]);
    
    // 10 - 2012/07/28 - 12 - 3 - 2012/08/15 = 43
    NSLog(@"10 - 2012/07/28 - 12 - 3 - 2012/08/15 = 43");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MINUS]];
    [viewController inputOutDate:[NSDate dateWithDay:28 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MINUS]];
    //STAssertTrue([[viewController.resultText text] isEqualToString:@"2012/07/28"], @"minus1-12-1 failed. :%@", [viewController.resultText text]);
    STAssertTrue([[viewController.resultText text] isEqualToString:@"2012/07/18"], @"minus1-12-1 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MINUS]];
    //STAssertTrue([[viewController.resultText text] isEqualToString:@"2012/07/16"], @"minus1-12-2 failed. :%@", [viewController.resultText text]);
    STAssertTrue([[viewController.resultText text] isEqualToString:@"2012/07/06"], @"minus1-12-2 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:THREE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MINUS]];
    //STAssertTrue([[viewController.resultText text] isEqualToString:@"2012/07/13"], @"minus1-12-3 failed. :%@", [viewController.resultText text]);
    STAssertTrue([[viewController.resultText text] isEqualToString:@"2012/07/03"], @"minus1-12-3 failed. :%@", [viewController.resultText text]);
    [viewController inputOutDate:[NSDate dateWithDay:15 month:8 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    //STAssertTrue([[viewController.resultText text] isEqualToString:@"43"], @"minus1-12-4 failed. :%@", [viewController.resultText text]);
    STAssertTrue([[viewController.resultText text] isEqualToString:@"-43"], @"minus1-12-4 failed. :%@", [viewController.resultText text]);
    
    // - 2 - 3 = -5
    NSLog(@"- 2 - 3 = -5");
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MINUS]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MINUS]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"-2"], @"minus1-13-1 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:THREE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"-5"], @"minus1-13-2 failed. :%@", [viewController.resultText text]);
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
- (void) testMulti1 {
    // 1 * 2 = 2
    NSLog(@"1 * 2 = 2");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MULTI]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"2"], @"multi1-1 failed. :%@", [viewController.resultText text]);
    
    // 2 * 2 = 4
    NSLog(@"2 * 2 = 4");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MULTI]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"4"], @"multi1-2 failed. :%@", [viewController.resultText text]);
    
    // 0 * 2 = 0
    NSLog(@"0 * 2 = 0");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MULTI]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0"], @"multi1-3 failed. :%@", [viewController.resultText text]);
    
    // 20 * 2 = 40
    NSLog(@"20 * 2 = 40");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MULTI]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"40"], @"multi1-4 failed. :%@", [viewController.resultText text]);
    
    // 2 * 20 = 40
    NSLog(@"2 * 20 = 40");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MULTI]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"40"], @"multi1-5 failed. :%@", [viewController.resultText text]);
    
    // 20 * 20 = 400
    NSLog(@"20 * 20 = 400");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MULTI]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"400"], @"multi1-6 failed. :%@", [viewController.resultText text]);
    
    // 2 * 2 * 3 = 12
    NSLog(@"2 * 2 * 3 = 12");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MULTI]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MULTI]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"4"], @"multi1-7-1 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:THREE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"12"], @"multi1-7-2 failed. :%@", [viewController.resultText text]);
    
    // 20 * 20 * 30 = 12000
    NSLog(@"20 * 20 * 30 = 12000");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MULTI]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MULTI]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"400"], @"multi1-8-1 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:THREE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"12,000"], @"multi1-8-2 failed. :%@", [viewController.resultText text]);
    
    // 20 * 20 * = 160000
    // NSLog(@"20 * 20 * = 160000");
    // [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    // [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    // [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    // [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    // [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MULTI]];
    // [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    // [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    // [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MULTI]];
    // STAssertTrue([[viewController.resultText text] isEqualToString:@"400"], @"multi1-9-1 failed. :%@", [viewController.resultText text]);
    // [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    // STAssertTrue([[viewController.resultText text] isEqualToString:@"160,000"], @"multi1-9-2 failed. :%@", [viewController.resultText text]);
    
    // 20 * 20 = = 8000
    NSLog(@"20 * 20 = = 8000");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MULTI]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"400"], @"multi1-10-1 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"8,000"], @"multi1-10-2 failed. :%@", [viewController.resultText text]);
    
    // 10 * 2012/07/28 + 2012/07/30 = 20
    NSLog(@"10 * 2012/07/28 + 2012/07/30 = 20");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MULTI]];
    [viewController inputOutDate:[NSDate dateWithDay:28 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"2012/07/28"], @"multi1-11-1 failed. :%@", [viewController.resultText text]);
    [viewController inputOutDate:[NSDate dateWithDay:30 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"20"], @"multi1-11-2 failed. :%@", [viewController.resultText text]);
    
    // 10 * 2012/07/28 + 12 + 3 + 2012/08/15 = 30
    NSLog(@"10 * 2012/07/28 + 12 + 3 + 2012/08/15 = 30");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MULTI]];
    [viewController inputOutDate:[NSDate dateWithDay:28 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"2012/07/28"], @"multi1-12-1 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"2012/08/09"], @"multi1-12-2 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:THREE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"2012/08/12"], @"multi1-12-3 failed. :%@", [viewController.resultText text]);
    [viewController inputOutDate:[NSDate dateWithDay:15 month:8 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"30"], @"multi1-12-4 failed. :%@", [viewController.resultText text]);
    
    // * 2 * 3 = 0
    NSLog(@"* 2 * 3 = 0");
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MULTI]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MULTI]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0"], @"multi1-13-1 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:THREE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0"], @"multi1-13-2 failed. :%@", [viewController.resultText text]);
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
- (void) testDivide1 {
    // 1 / 2 = 0.5
    NSLog(@"1 / 2 = 0.5");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DIVIDE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0.5"], @"divide1-1 failed. :%@", [viewController.resultText text]);
    
    // 2 / 2 = 1
    NSLog(@"2 / 2 = 1");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DIVIDE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"1"], @"divide1-2 failed. :%@", [viewController.resultText text]);
    
    // 0 - 2 = 0
    NSLog(@"0 - 2 = 0");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DIVIDE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0"], @"divide1-3 failed. :%@", [viewController.resultText text]);
    
    // 20 / 2 = 10
    NSLog(@"20 / 2 = 10");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DIVIDE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"10"], @"divide1-4 failed. :%@", [viewController.resultText text]);
    
    // 2 / 20 = 0.1
    NSLog(@"2 / 20 = 0.1");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DIVIDE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0.1"], @"divide1-5 failed. :%@", [viewController.resultText text]);
    
    // 20 / 20 = 1
    NSLog(@"20 / 20 = 1");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DIVIDE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"1"], @"divide1-6 failed. :%@", [viewController.resultText text]);
    
    // 2 / 2 / 3 = 0.333333
    NSLog(@"2 / 2 / 3 = 0.333333");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DIVIDE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DIVIDE]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"1"], @"divide1-7-1 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:THREE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0.33333333333"], @"divide1-7-2 failed. :%@", [viewController.resultText text]);
    
    // 20 / 20 / 30 = 0.033333
    NSLog(@"20 / 20 / 30 = 0.03333");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DIVIDE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DIVIDE]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"1"], @"divide1-8-1 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:THREE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0.03333333333"], @"divide1-8-2 failed. :%@", [viewController.resultText text]);
    
    // 40 / 20 / = 1
    // NSLog(@"40 / 20 / = 1");
    // [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    // [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    // [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:FOUR]];
    // [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    // [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DIVIDE]];
    // [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    // [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    // [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DIVIDE]];
    // STAssertTrue([[viewController.resultText text] isEqualToString:@"2"], @"divide1-9-1 failed. :%@", [viewController.resultText text]);
    // [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    // STAssertTrue([[viewController.resultText text] isEqualToString:@"1"], @"divide1-9-2 failed. :%@", [viewController.resultText text]);
    
    // 40 / 20 = = 0.1
    NSLog(@"40 / 20 = = 0.1");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:FOUR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DIVIDE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"2"], @"divide1-10-1 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0.1"], @"divide1-10-2 failed. :%@", [viewController.resultText text]);
    
    // 10 / 2012/07/28 + 2012/07/30 = 5
    NSLog(@"10 / 2012/07/28 + 2012/07/30 = 5");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DIVIDE]];
    [viewController inputOutDate:[NSDate dateWithDay:28 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"2012/07/28"], @"divide1-11-1 failed. :%@", [viewController.resultText text]);
    [viewController inputOutDate:[NSDate dateWithDay:30 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"5"], @"divide1-11-2 failed. :%@", [viewController.resultText text]);
    
    // 10 / 2012/07/28 + 12 + 3 + 2012/08/15 = 3.333333
    NSLog(@"10 / 2012/07/28 + 12 + 3 + 2012/08/15 = 3.333333");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DIVIDE]];
    [viewController inputOutDate:[NSDate dateWithDay:28 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"2012/07/28"], @"divide1-12-1 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"2012/08/09"], @"divide1-12-2 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:THREE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"2012/08/12"], @"divide1-12-3 failed. :%@", [viewController.resultText text]);
    [viewController inputOutDate:[NSDate dateWithDay:15 month:8 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"3.33333333333"], @"divide1-12-4 failed. :%@", [viewController.resultText text]);
    
    // / 2 / 3 = 0
    NSLog(@"/ 2 / 3 = 0");
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DIVIDE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DIVIDE]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0"], @"divide1-13-1 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:THREE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0"], @"divide1-13-2 failed. :%@", [viewController.resultText text]);
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
- (void) testDatePlus1 {
    // 2012/07/28 + 2012/08/15 = 18
    NSLog(@"2012/07/28 + 2012/08/15 = 18");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController inputOutDate:[NSDate dateWithDay:28 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    [viewController inputOutDate:[NSDate dateWithDay:15 month:8 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"18"], @"datePlus1-1 failed. :%@", [viewController.resultText text]);
    
    // 2012/08/15 + 2012/07/28 = 18
    NSLog(@"2012/08/15 + 2012/07/28 = 18");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController inputOutDate:[NSDate dateWithDay:15 month:8 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    [viewController inputOutDate:[NSDate dateWithDay:28 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"18"], @"datePlus1-2 failed. :%@", [viewController.resultText text]);
    
    // 2012/07/28 + 1 = 2012/07/29
    NSLog(@"2012/07/28 + 1 = 2012/07/29");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController inputOutDate:[NSDate dateWithDay:28 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"2012/07/29"], @"datePlus1-3 failed. :%@", [viewController.resultText text]);
    
    // 1 + 2012/07/28 + 2012/07/29 = 2
    NSLog(@"1 + 2012/07/28 + 2012/07/29 = 2");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    [viewController inputOutDate:[NSDate dateWithDay:28 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    //STAssertTrue([[viewController.resultText text] isEqualToString:@"2012/07/28"], @"datePlus1-4 failed. :%@", [viewController.resultText text]);
    STAssertTrue([[viewController.resultText text] isEqualToString:@"2012/07/29"], @"datePlus1-4 failed. :%@", [viewController.resultText text]);
    [viewController inputOutDate:[NSDate dateWithDay:29 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    //STAssertTrue([[viewController.resultText text] isEqualToString:@"2"], @"datePlus1-4 failed. :%@", [viewController.resultText text]);
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0"], @"datePlus1-4 failed. :%@", [viewController.resultText text]);
    
    // 2012/07/28 + 2012/07/29 = = 1
    NSLog(@"2012/07/28 + 2012/07/29 = = 1");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController inputOutDate:[NSDate dateWithDay:28 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    [viewController inputOutDate:[NSDate dateWithDay:29 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"1"], @"datePlus1-5-1 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"1"], @"datePlus1-5-2 failed. :%@", [viewController.resultText text]);
    
    // 2012/07/28 + 2 = = 2012/08/01
    NSLog(@"2012/07/28 + 2 = = 2012/08/01");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController inputOutDate:[NSDate dateWithDay:28 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"2012/07/30"], @"datePlus1-6-1 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"2012/08/01"], @"datePlus1-6-2 failed. :%@", [viewController.resultText text]);
    
    // + 2012/07/28 + 2012/07/30 = 2
    NSLog(@"+ 2012/07/28 + 2012/07/30 = 2");
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    [viewController inputOutDate:[NSDate dateWithDay:28 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"2012/07/28"], @"datePlus1-7-1 failed. :%@", [viewController.resultText text]);
    [viewController inputOutDate:[NSDate dateWithDay:30 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"2"], @"datePlus1-7-2 failed. :%@", [viewController.resultText text]);
    
    // + 2012/07/28 + 2 = 2012/07/30
    NSLog(@"+ 2012/07/28 + 2 = 2012/07/30");
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    [viewController inputOutDate:[NSDate dateWithDay:28 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"2012/07/30"], @"datePlus1-8-1 failed. :%@", [viewController.resultText text]);
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
- (void) testDateMinus1 {
    // 2012/07/28 - 2012/08/15 = -18
    NSLog(@"2012/07/28 - 2012/08/15 = -18");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController inputOutDate:[NSDate dateWithDay:28 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MINUS]];
    [viewController inputOutDate:[NSDate dateWithDay:15 month:8 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"-18"], @"dateMinus1-1 failed. :%@", [viewController.resultText text]);
    
    // 2012/08/15 + 2012/07/28 = -18
    NSLog(@"2012/08/15 - 2012/07/28 = -18");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController inputOutDate:[NSDate dateWithDay:15 month:8 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MINUS]];
    [viewController inputOutDate:[NSDate dateWithDay:28 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"-18"], @"dateMinus1-2 failed. :%@", [viewController.resultText text]);
    
    // 2012/07/28 - 1 = 2012/07/27
    NSLog(@"2012/07/28 - 1 = 2012/07/27");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController inputOutDate:[NSDate dateWithDay:28 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MINUS]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"2012/07/27"], @"dateMinus1-3 failed. :%@", [viewController.resultText text]);
    
    // 1 - 2012/07/28 - 2012/07/29 = 2
    NSLog(@"1 - 2012/07/28 - 2012/07/29 = 2");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MINUS]];
    [viewController inputOutDate:[NSDate dateWithDay:28 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MINUS]];
    //STAssertTrue([[viewController.resultText text] isEqualToString:@"2012/07/28"], @"dateMinus1-4-1 failed. :%@", [viewController.resultText text]);
    STAssertTrue([[viewController.resultText text] isEqualToString:@"2012/07/27"], @"dateMinus1-4-1 failed. :%@", [viewController.resultText text]);
    [viewController inputOutDate:[NSDate dateWithDay:29 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    //STAssertTrue([[viewController.resultText text] isEqualToString:@"2"], @"dateMinus1-4-2 failed. :%@", [viewController.resultText text]);
    STAssertTrue([[viewController.resultText text] isEqualToString:@"-2"], @"dateMinus1-4-2 failed. :%@", [viewController.resultText text]);
    
    // 2012/07/28 - 2012/07/29 = = -1
    NSLog(@"2012/07/28 - 2012/07/29 = = -1");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController inputOutDate:[NSDate dateWithDay:28 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MINUS]];
    [viewController inputOutDate:[NSDate dateWithDay:29 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"-1"], @"dateMinus1-5-1 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"-1"], @"dateMinus1-5-2 failed. :%@", [viewController.resultText text]);
    
    // 2012/07/28 - 2 = = 2012/07/24
    NSLog(@"2012/07/28 - 2 = = 2012/07/24");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController inputOutDate:[NSDate dateWithDay:28 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MINUS]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"2012/07/26"], @"dateMinus1-6-1 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"2012/07/24"], @"dateMinus1-6-2 failed. :%@", [viewController.resultText text]);
    
    // - 2012/07/28 - 2012/07/30 = 2
    NSLog(@"- 2012/07/28 - 2012/07/30 = 2");
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MINUS]];
    [viewController inputOutDate:[NSDate dateWithDay:28 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MINUS]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"2012/07/28"], @"dateMinus1-7-1 failed. :%@", [viewController.resultText text]);
    [viewController inputOutDate:[NSDate dateWithDay:30 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    //STAssertTrue([[viewController.resultText text] isEqualToString:@"2"], @"dateMinus1-7-2 failed. :%@", [viewController.resultText text]);
    STAssertTrue([[viewController.resultText text] isEqualToString:@"-2"], @"dateMinus1-7-2 failed. :%@", [viewController.resultText text]);
    
    // - 2012/07/28 - 2 = 2012/07/26
    NSLog(@"- 2012/07/28 - 2 = 2012/07/26");
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MINUS]];
    [viewController inputOutDate:[NSDate dateWithDay:28 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MINUS]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"2012/07/26"], @"dateMinus1-8-1 failed. :%@", [viewController.resultText text]);
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
- (void) testDateMulti1 {
    // 2012/07/28 * 2012/08/15 = 0
    NSLog(@"2012/07/28 * 2012/08/15 = 0");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController inputOutDate:[NSDate dateWithDay:28 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MULTI]];
    [viewController inputOutDate:[NSDate dateWithDay:15 month:8 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0"], @"dateMulti1-1 failed. :%@", [viewController.resultText text]);
    
    // 2012/08/15 * 2012/07/28 = 0
    NSLog(@"2012/08/15 * 2012/07/28 = 0");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController inputOutDate:[NSDate dateWithDay:15 month:8 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MULTI]];
    [viewController inputOutDate:[NSDate dateWithDay:28 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0"], @"dateMulti1-2 failed. :%@", [viewController.resultText text]);
    
    // 2012/07/28 * 1 = 0
    NSLog(@"2012/07/28 * 1 = 0");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController inputOutDate:[NSDate dateWithDay:28 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MULTI]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0"], @"dateMulti1-3 failed. :%@", [viewController.resultText text]);
    
    // 1 * 2012/07/28 + 2012/07/30 = 2
    NSLog(@"1 * 2012/07/28 + 2012/07/30 = 2");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MULTI]];
    [viewController inputOutDate:[NSDate dateWithDay:28 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"2012/07/28"], @"dateMulti1-4 failed. :%@", [viewController.resultText text]);
    [viewController inputOutDate:[NSDate dateWithDay:30 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"2"], @"dateMulti1-4 failed. :%@", [viewController.resultText text]);
    
    // 2012/07/28 * 2012/07/29 = = 0
    NSLog(@"2012/07/28 * 2012/07/29 = = 0");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController inputOutDate:[NSDate dateWithDay:28 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MULTI]];
    [viewController inputOutDate:[NSDate dateWithDay:29 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0"], @"dateMulti1-5-1 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0"], @"dateMulti1-5-2 failed. :%@", [viewController.resultText text]);
    
    // 2012/07/28 * 2 = = 0
    NSLog(@"2012/07/28 * 2 = = 0");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController inputOutDate:[NSDate dateWithDay:28 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MULTI]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0"], @"dateMulti1-6-1 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0"], @"dateMulti1-6-2 failed. :%@", [viewController.resultText text]);
    
    // * 2012/07/28 * 2012/07/30 = 0
    NSLog(@"* 2012/07/28 * 2012/07/30 = 0");
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MULTI]];
    [viewController inputOutDate:[NSDate dateWithDay:28 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MULTI]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0"], @"dateMulti1-7-1 failed. :%@", [viewController.resultText text]);
    [viewController inputOutDate:[NSDate dateWithDay:30 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0"], @"dateMulti1-7-2 failed. :%@", [viewController.resultText text]);
    
    // * 2012/07/28 * 2012/07/30 + 3 = 0
    NSLog(@"* 2012/07/28 * 2012/07/30 + 3 = 3");
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MULTI]];
    [viewController inputOutDate:[NSDate dateWithDay:28 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MULTI]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0"], @"dateMulti1-8-1 failed. :%@", [viewController.resultText text]);
    [viewController inputOutDate:[NSDate dateWithDay:30 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0"], @"dateMulti1-8-2 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:THREE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"3"], @"dateMulti1-8-3 failed. :%@", [viewController.resultText text]);
    
    // * 2012/07/28 * 2 = 0
    NSLog(@"* 2012/07/28 * 2 = 0");
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MULTI]];
    [viewController inputOutDate:[NSDate dateWithDay:28 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MULTI]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0"], @"dateMulti1-9-1 failed. :%@", [viewController.resultText text]);
    
    // * 2012/07/28 * 2 + 3 = 3
    NSLog(@"* 2012/07/28 * 2 + 3 = 3");
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MULTI]];
    [viewController inputOutDate:[NSDate dateWithDay:28 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MULTI]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0"], @"dateMulti1-10-1 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MULTI]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0"], @"dateMulti1-10-2 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:THREE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"3"], @"dateMulti1-10-3 failed. :%@", [viewController.resultText text]);
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
- (void) testDateDivide1 {
    // 2012/07/28 / 2012/08/15 = 0
    NSLog(@"2012/07/28 / 2012/08/15 = 0");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController inputOutDate:[NSDate dateWithDay:28 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DIVIDE]];
    [viewController inputOutDate:[NSDate dateWithDay:15 month:8 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0"], @"dateDivide1-1 failed. :%@", [viewController.resultText text]);
    
    // 2012/08/15 / 2012/07/28 = 0
    NSLog(@"2012/08/15 / 2012/07/28 = 0");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController inputOutDate:[NSDate dateWithDay:15 month:8 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DIVIDE]];
    [viewController inputOutDate:[NSDate dateWithDay:28 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0"], @"dateDivide1-2 failed. :%@", [viewController.resultText text]);
    
    // 2012/07/28 / 1 = 0
    NSLog(@"2012/07/28 / 1 = 0");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController inputOutDate:[NSDate dateWithDay:28 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DIVIDE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0"], @"dateDivide1-3 failed. :%@", [viewController.resultText text]);
    
    // 1 / 2012/07/28 + 2012/07/30 = 0.5
    NSLog(@"1 / 2012/07/28 + 2012/07/30 = 0.5");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DIVIDE]];
    [viewController inputOutDate:[NSDate dateWithDay:28 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"2012/07/28"], @"dateDivide1-4-1 failed. :%@", [viewController.resultText text]);
    [viewController inputOutDate:[NSDate dateWithDay:30 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0.5"], @"dateDivide1-4-2 failed. :%@", [viewController.resultText text]);
    
    // 2012/07/28 / 2012/07/29 = = 0
    NSLog(@"2012/07/28 / 2012/07/29 = = 0");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController inputOutDate:[NSDate dateWithDay:28 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DIVIDE]];
    [viewController inputOutDate:[NSDate dateWithDay:29 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0"], @"dateDivide1-5-1 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0"], @"dateDivide1-5-2 failed. :%@", [viewController.resultText text]);
    
    // 2012/07/28 / 2 = = 0
    NSLog(@"2012/07/28 / 2 = = 0");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController inputOutDate:[NSDate dateWithDay:28 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DIVIDE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0"], @"dateDivide1-6-1 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0"], @"dateDivide1-6-2 failed. :%@", [viewController.resultText text]);
    
    // / 2012/07/28 / 2012/07/30 = 0
    NSLog(@"/ 2012/07/28 / 2012/07/30 = 0");
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DIVIDE]];
    [viewController inputOutDate:[NSDate dateWithDay:28 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DIVIDE]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0"], @"dateDivide1-7-1 failed. :%@", [viewController.resultText text]);
    [viewController inputOutDate:[NSDate dateWithDay:30 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0"], @"dateDivide1-7-2 failed. :%@", [viewController.resultText text]);
    
    // / 2012/07/28 / 2012/07/30 + 3 = 3
    NSLog(@"/ 2012/07/28 / 2012/07/30 + 3 = 3");
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DIVIDE]];
    [viewController inputOutDate:[NSDate dateWithDay:28 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DIVIDE]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0"], @"dateDivide1-8-1 failed. :%@", [viewController.resultText text]);
    [viewController inputOutDate:[NSDate dateWithDay:30 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0"], @"dateDivide1-8-2 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:THREE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"3"], @"dateDivide1-8-3 failed. :%@", [viewController.resultText text]);
    
    // / 2012/07/28 / 2 = 0
    NSLog(@"/ 2012/07/28 / 2 = 0");
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DIVIDE]];
    [viewController inputOutDate:[NSDate dateWithDay:28 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DIVIDE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0"], @"dateDivide1-9-1 failed. :%@", [viewController.resultText text]);
    
    // / 2012/07/28 / 2 + 3 = 3
    NSLog(@"* 2012/07/28 * 2 + 3 = 3");
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DIVIDE]];
    [viewController inputOutDate:[NSDate dateWithDay:28 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DIVIDE]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0"], @"dateDivide1-10-1 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DIVIDE]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0"], @"dateDivide1-10-2 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:THREE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"3"], @"dateDivide1-10-3 failed. :%@", [viewController.resultText text]);
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
- (void) testReverse {
    // 1 [+/-] + 1 = 0
    NSLog(@"1 [+/-] + 1 = 0");
    // [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    // [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS_MINUS]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"-1"], @"function1-1-1 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0"], @"function1-1-2 failed. :%@", [viewController.resultText text]);
    
    // 1 [+/-] [00] + 200 = 100
    NSLog(@"1 [+/-] [00] + 200 = 100");
    // [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    // [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS_MINUS]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DOUBLE_ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"-100"], @"function1-2-1 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"100"], @"function1-2-2 failed. :%@", [viewController.resultText text]);
    
    // 1 + 2 = [+/-] + 3 = 0
    NSLog(@"1 + 2 = [+/-] + 3 = 0");
    // [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    // [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"3"], @"function1-3-1 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS_MINUS]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"-3"], @"function1-3-2 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:THREE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0"], @"dateDivide1-3-3 failed. :%@", [viewController.resultText text]);
    
    // 12345 [DEL] + 100 = 1,334
    NSLog(@"12345 [DEL] + 100 = 1,334");
    // [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    // [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:THREE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:FOUR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:FIVE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DELETE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"1,234"], @"function1-4-1 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"1,334"], @"function1-4-2 failed. :%@", [viewController.resultText text]);
    
    // 12345 [DEL] [DEL] + 100 = 223
    NSLog(@"12345 [DEL] [DEL] + 100 = 223");
    // [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    // [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:THREE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:FOUR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:FIVE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DELETE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DELETE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"123"], @"function1-5-1 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"223"], @"function1-5-2 failed. :%@", [viewController.resultText text]);
    
    // -12345 [DEL] + 100 = -1,134
    NSLog(@"-12345 [DEL] + 100 = -1,134");
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MINUS]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:THREE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:FOUR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:FIVE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DELETE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"-1,234"], @"function1-6-1 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"-1,134"], @"function1-6-2 failed. :%@", [viewController.resultText text]);
    
    // -12345 [DEL] [DEL] + 100 = -23
    NSLog(@"-12345 [DEL] [DEL] + 100 = -23");
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MINUS]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:THREE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:FOUR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:FIVE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DELETE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DELETE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"-123"], @"function1-7-1 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"-23"], @"function1-7-2 failed. :%@", [viewController.resultText text]);
    
    // 123 [DEL] [DEL] [DEL] + 100 = 100
    NSLog(@"123 [DEL] [DEL] [DEL] + 100 = 100");
    // [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    // [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:THREE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DELETE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DELETE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DELETE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0"], @"function1-8-1 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"100"], @"function1-8-2 failed. :%@", [viewController.resultText text]);
    
    // -123 [DEL] [DEL] [DEL] + 100 = 100
    NSLog(@"-123 [DEL] [DEL] [DEL] + 100 = 100");
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MINUS]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:THREE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DELETE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DELETE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DELETE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0"], @"function1-9-1 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"100"], @"function1-9-2 failed. :%@", [viewController.resultText text]);
    
    // 10 + 20 = [DEL] + 1 = 31
    NSLog(@"10 + 20 = [DEL] + 1 = 31");
    // [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    // [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"30"], @"function1-10-1 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DELETE]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0"], @"function1-10-2 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"31"], @"function1-10-3 failed. :%@", [viewController.resultText text]);
    
    // 0.0000012 [DEL] + 0.000002 = 0.000003
    NSLog(@"0.0000012 [DEL] + 0.000002 = 0.000003 ");
    // [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    // [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DOT]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0.0000012"], @"function1-11-1 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DELETE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0.000001"], @"function1-11-2 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DOT]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0.000002"], @"function1-11-3 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0.000003"], @"function1-11-4 failed. :%@", [viewController.resultText text]);
    
    // 0.0000012 [+/-] + 0.000002 = -0.0000008
    NSLog(@"0.0000012 [+/-] + 0.000002 = 0.0000008");
    // [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    // [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DOT]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0.0000012"], @"function1-12-1 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS_MINUS]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"-0.0000012"], @"function1-12-2 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DOT]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0.000002"], @"function1-12-3 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0.0000008"], @"function1-12-4 failed. :%@", [viewController.resultText text]);
    
    // [.] 2012/07/28 + 3 = 2012/07/31
    NSLog(@"[.] 2012/07/28 + 3 = 2012/07/31");
    // [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    // [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DOT]];
    [viewController inputOutDate:[NSDate dateWithDay:28 month:7 year:2012]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"2012/07/28"], @"function1-13-1 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"2012/07/28"], @"function1-13-2 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:THREE]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"3"], @"function1-13-3 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"2012/07/31"], @"function1-13-4 failed. :%@", [viewController.resultText text]);
    
    // 2012/07/28 [DEL] + 3 = 3
    NSLog(@"2012/07/28 [DEL] + 3 = 3");
    // [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    // [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController inputOutDate:[NSDate dateWithDay:28 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DELETE]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0"], @"function1-14-1 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0"], @"function1-14-2 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:THREE]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"3"], @"function1-14-3 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"3"], @"function1-14-4 failed. :%@", [viewController.resultText text]);
    
    // 2012/07/28 [+/-] + 3 = 2012/07/28
    NSLog(@"2012/07/28 [DEL] + 3 = 3");
    // [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    // [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController inputOutDate:[NSDate dateWithDay:28 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS_MINUS]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"2012/07/28"], @"function1-15-1 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"2012/07/28"], @"function1-15-2 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:THREE]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"3"], @"function1-15-3 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"2012/07/31"], @"function1-15-4 failed. :%@", [viewController.resultText text]);
}
//}}}

// {{{ point
// 01.小数と整数
// 02.整数と小数
// 03.小数と小数
// 04.小数点以下１桁と小数点以下２桁
// 05.小数点以下２桁と小数点以下２桁
// 06.小数点以下１桁での３項
// 07.小数点以下２桁での３項
// 08.イコール２度連続
// 09.小数と日付加算の複合(日付差)
// 10.小数と日付加算の複合(日付加算および日付差)
// 11.小数点最大桁と小数点最大桁(繰り上がり)
// 12.小数点ボタンを押した後に演算
- (void) testPoint1 {
    // 0.1 + 1 = 1.1
    NSLog(@"0.1 + 1 = 1.1");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DOT]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0.1"], @"point1-1-1 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"1"], @"point1-1-2 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"1.1"], @"point1-1-3 failed. :%@", [viewController.resultText text]);
    
    // 2 - 0.2 = 1.8
    NSLog(@"2 - 0.2 = 1.8");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MINUS]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"2"], @"point1-2-1 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DOT]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0.2"], @"point1-2-2 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"1.8"], @"point1-2-3 failed. :%@", [viewController.resultText text]);
    
    // 0.3 * 0.2 = 0.06
    NSLog(@"0.3 * 0.2 = 0.06");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DOT]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:THREE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MULTI]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0.3"], @"point1-3-1 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DOT]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0.2"], @"point1-3-2 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0.06"], @"point1-3-3 failed. :%@", [viewController.resultText text]);
    
    // 1.1 + 3.14 = 4.24
    NSLog(@"1.1 + 3.14 = 4.24");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DOT]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"1.1"], @"point1-4-1 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:THREE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DOT]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:FOUR]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"3.14"], @"point1-4-2 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"4.24"], @"point1-4-3 failed. :%@", [viewController.resultText text]);
    
    // 0.42 / 0.12 = 3.5
    NSLog(@"0.42 / 0.12 = 3.5");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DOT]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:FOUR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DIVIDE]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0.42"], @"point1-5-1 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DOUBLE_ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DOT]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0.12"], @"point1-5-2 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"3.5"], @"point1-5-3 failed. :%@", [viewController.resultText text]);
    
    // 1.3 + 0.9 - 3.4 = -1.2
    NSLog(@"1.3 + 0.9 - 3.4 = -1.2");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DOT]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:THREE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"1.3"], @"point1-6-1 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DOT]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:NINE]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0.9"], @"point1-6-2 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MINUS]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"2.2"], @"point1-6-3 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:THREE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DOT]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:FOUR]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"3.4"], @"point1-6-4 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"-1.2"], @"point1-6-5 failed. :%@", [viewController.resultText text]);
    
    // 2.24 * 0.12 / 1.04 = 0.25846154
    NSLog(@"2.24 * 0.12 / 1.04 = 0.25846154");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DOT]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:FOUR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MULTI]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"2.24"], @"point1-7-1 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DOT]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0.12"], @"point1-7-2 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DIVIDE]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0.2688"], @"point1-7-3 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DOT]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:FOUR]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"1.04"], @"point1-7-3 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0.25846153846"], @"point1-7-4 failed. :%@", [viewController.resultText text]);
    
    // 0.2 + 1.034 = = 2.268
    NSLog(@"0.2 + 1.034 = = 2.268");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DOT]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0.2"], @"point1-8-1 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DOT]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:THREE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:FOUR]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"1.034"], @"point1-8-2 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"1.234"], @"point1-8-3 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"2.268"], @"point1-8-4 failed. :%@", [viewController.resultText text]);
    
    // 1.5 * 2012/07/28 + 2012/07/30 = 3
    NSLog(@"1.5 * 2012/07/28 + 2012/07/30 = 3");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DOT]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:FIVE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:MULTI]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"1.5"], @"point1-9-1 failed. :%@", [viewController.resultText text]);
    [viewController inputOutDate:[NSDate dateWithDay:28 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"2012/07/28"], @"point1-9-2 failed. :%@", [viewController.resultText text]);
    [viewController inputOutDate:[NSDate dateWithDay:30 month:7 year:2012]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"2012/07/30"], @"point1-9-3 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"3"], @"point1-9-4 failed. :%@", [viewController.resultText text]);
    
    // 0.0006 / 2012/07/28 + 12 + 3 + 2012/08/15 = 0.0002
    NSLog(@"0.0006 / 2012/07/28 + 12 + 3 + 2012/08/15 = 0.0002");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DOT]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:SIX]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DIVIDE]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0.0006"], @"point1-10-1 failed. :%@", [viewController.resultText text]);
    [viewController inputOutDate:[NSDate dateWithDay:28 month:7 year:2012]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"2012/07/28"], @"point1-10-2 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ONE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:TWO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"2012/08/09"], @"point1-10-3 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:THREE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"2012/08/12"], @"point1-10-4 failed. :%@", [viewController.resultText text]);
    [viewController inputOutDate:[NSDate dateWithDay:15 month:8 year:2012]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"2012/08/15"], @"point1-10-5 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0.0002"], @"point1-10-6 failed. :%@", [viewController.resultText text]);
    
    // 0.00000000005 + 0.00000000008 = 0.00000000013
    NSLog(@"0.00000000005 + 0.00000000008 = 0.00000000013");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DOT]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:FIVE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0.00000000005"], @"point1-11-1 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DOT]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DOUBLE_ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DOUBLE_ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DOUBLE_ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DOUBLE_ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DOUBLE_ZERO]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EIGHT]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0.00000000008"], @"point1-11-2 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"0.00000000013"], @"point1-11-3 failed. :%@", [viewController.resultText text]);
    
    // 5 [.] + 3 = 8
    NSLog(@"5 [.] + 3 = 8");
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    //[viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:CLEAR]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:FIVE]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:DOT]];
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:PLUS]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"5"], @"point1-12-1 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:THREE]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"3"], @"point1-12-2 failed. :%@", [viewController.resultText text]);
    [viewController pressNumberButton:(UIButton *)[calendarCalcView viewWithTag:EQUAL]];
    STAssertTrue([[viewController.resultText text] isEqualToString:@"8"], @"point1-12-3 failed. :%@", [viewController.resultText text]);
}
//}}}
*/
@end
