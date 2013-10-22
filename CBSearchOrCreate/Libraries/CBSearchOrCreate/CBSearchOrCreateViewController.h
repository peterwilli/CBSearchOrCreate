//
//  CBSearchOrCreateViewController.h
//  CBSearchOrCreate
//
//  Created by Peter Willemsen on 21-10-13.
//  Copyright (c) 2013 CodeBuffet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CBSearchOrCreateViewController : UIViewController <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>

+ (CBSearchOrCreateViewController *) viewController;

- (void) presentSearchOrCreateViewControllerFromRect: (CGRect) rect andParentVC: (UIViewController*) parent;
- (void) reloadData;

@property (nonatomic, copy) NSArray* (^itemsForSearchText)(NSString* text);
@property (nonatomic, copy) void (^userCreatedItemWithText)(NSString* text);
@property (nonatomic, copy) void (^userSelectedItem)(NSString* item);

@property (nonatomic, retain) NSString *itemType;

@end
