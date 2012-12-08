//
//  CopybleReadOnlyTextField.m
//  CalendarCalc
//
//  Created by Junichi Ishida on 2012/07/29.
//
//

#import "CopybleLabel.h"

@implementation CopybleLabel

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(copy:)) {
        return YES;
    } else {
        return [super canPerformAction:action
                            withSender:sender];
    }
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (BOOL)becomeFirstResponder {
    if ([super becomeFirstResponder]) {
        self.highlighted = YES;
        return YES;
    }
    return NO;
}

- (void)copy:(id)sender {
    [[UIPasteboard generalPasteboard] setString:self.text];
    self.highlighted = NO;
    [self resignFirstResponder];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([self isFirstResponder]) {
        self.highlighted = NO;
        UIMenuController *menu = [UIMenuController sharedMenuController];
        [menu setMenuVisible:NO animated:YES];
        [menu update];
        [self resignFirstResponder];
    } else if ([self becomeFirstResponder]) {
        UIMenuController *menu = [UIMenuController sharedMenuController];
        [menu setTargetRect:CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, self.bounds.size.height / 2)
                     inView:self];
        [menu setMenuVisible:YES
                    animated:YES];
    }
}
@end
