//
//  CBSearchOrCreateExampleViewController.m
//  CBSearchOrCreate
//
//  Created by Peter Willemsen on 22-10-13.
//  Copyright (c) 2013 CodeBuffet. All rights reserved.
//

#import "CBSearchOrCreateExampleViewController.h"
#import "CBSearchOrCreateViewController.h"

@interface CBSearchOrCreateExampleViewController ()
{
    NSMutableArray *demoItems;
}

@end

@implementation CBSearchOrCreateExampleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)openTap:(UIButton*)sender {
    // This code is for both iPad and iPhone
    CBSearchOrCreateViewController *vc = [CBSearchOrCreateViewController viewController];
    
    [vc setItemsForSearchText:^NSArray *(NSString *text) {
        if (text.length == 0) {
            return demoItems;
        }
        return [demoItems filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF contains[c] %@", text]];
    }];
    [vc setUserCreatedItemWithText:^(NSString *text) {
        [demoItems addObject:text];
    }];
    [vc setUserSelectedItem:^(NSString *item) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@", item]]];
    }];
    
    vc.itemType = @"Awesome Site";
    
    [vc reloadData];
    [vc presentSearchOrCreateViewControllerFromRect:sender.frame andParentVC:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    demoItems = [NSMutableArray arrayWithArray:@[@"wayser.com", @"codebuffet.co", @"54limited.com", @"yamm.ca"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
