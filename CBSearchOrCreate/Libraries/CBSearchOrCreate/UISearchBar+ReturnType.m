#import "UISearchBar+ReturnType.h"

@implementation UISearchBar (ReturnType)

UITextField *textField;

- (UITextField *) traverseForTextViewInViews: (NSArray*) views
{
    // Traverse over all views recursively until we find the tresure TextField hidden deep the UISearchBar ocean!
    for(UIView *subView in views) {
        if([subView conformsToProtocol:@protocol(UITextInputTraits)]) {
            return (UITextField *) subView;
        }
        UITextField *tv = [self traverseForTextViewInViews:subView.subviews];
        if (tv) {
            return tv;
        }
    }
    return nil;
}

#pragma mark Custom Setters & Getters

- (void)setReturnKeyType:(UIReturnKeyType)returnKeyType
{
    if (!textField) {
        textField = [self traverseForTextViewInViews:self.subviews];
    }
    textField.returnKeyType = returnKeyType;
    [self reloadInputViews];
    [textField reloadInputViews];
}

- (UIReturnKeyType)returnKeyType
{
    if (!textField) {
        textField = [self traverseForTextViewInViews:self.subviews];
    }
    return textField.returnKeyType;
}

@end
