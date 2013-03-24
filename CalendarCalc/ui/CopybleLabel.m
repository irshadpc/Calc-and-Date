//
//  CCCopybleLabel.m
//  CalendarCalc
//
//  Created by Junichi Ishida on 2012/07/29.
//
//

#import "CopybleLabel.h"

@implementation CopybleLabel

////////////////////////////////////////////////////////////////////////////////
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(copy:)) {
        return YES;
    } else {
        return [super canPerformAction:action
                            withSender:sender];
    }
}

////////////////////////////////////////////////////////////////////////////////
- (BOOL)canBecomeFirstResponder
{
    return YES;
}

////////////////////////////////////////////////////////////////////////////////
- (void)copy:(id)sender
{
    [[UIPasteboard generalPasteboard] setString:self.text];
    [self resignFirstResponder];
}

////////////////////////////////////////////////////////////////////////////////
- (void)touchesEnded:(NSSet *)touches
           withEvent:(UIEvent *)event
{
    if ([self isFirstResponder]) {
        [[UIMenuController sharedMenuController] setMenuVisible:NO
                                                       animated:YES];
        
        [[UIMenuController sharedMenuController] update];
        [self resignFirstResponder];
    } else if ([self becomeFirstResponder]) {
        [[UIMenuController sharedMenuController] setTargetRect:CGRectMake(self.bounds.origin.x,
                                                                          self.bounds.origin.y,
                                                                          self.bounds.size.width,
                                                                          self.bounds.size.height / 2)
                                                        inView:self];
        
        [[UIMenuController sharedMenuController] setMenuVisible:YES
                                                       animated:YES];
    }
}
@end
