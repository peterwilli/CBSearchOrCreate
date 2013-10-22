/*
 
 Simple hack for exposing returnKeyType for UISearchBar without private APIs
 For you from CodeBuffet ;)
 
 
 Enjoy!
 
 ~PW
 
*/

#import <UIKit/UIKit.h>

@interface UISearchBar (ReturnType)

@property (nonatomic, readwrite) UIReturnKeyType returnKeyType;

@end
