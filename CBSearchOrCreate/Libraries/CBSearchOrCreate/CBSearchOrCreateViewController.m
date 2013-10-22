//
//  CBSearchOrCreateViewController.m
//  CBSearchOrCreate
//
//  Created by Peter Willemsen on 21-10-13.
//  Copyright (c) 2013 CodeBuffet. All rights reserved.
//

#import "CBSearchOrCreateViewController.h"
#import "CBSearchOrCreateCell.h"

#import "UISearchBar+ReturnType.h"
#import <OHAttributedLabel.h>

@interface CBSearchOrCreateViewController ()
{
    NSArray *items;
    UINib *cellNib;
    UIPopoverController *popover;
}

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *emptyView;
@property (weak, nonatomic) IBOutlet UILabel *hintLabel;
@property (weak, nonatomic) IBOutlet OHAttributedLabel *errorLabel;

@end

@implementation CBSearchOrCreateViewController
@synthesize itemsForSearchText;
@synthesize userCreatedItemWithText, userSelectedItem;
@synthesize itemType;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    items = @[];
    [self initTable];
    if ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) && [[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        CGRect f = self.containerView.frame;
        f.origin.y += 20;
        self.containerView.frame = f;
    }
}

+ (CBSearchOrCreateViewController *) viewController
{
    return [[[NSBundle mainBundle] loadNibNamed:@"CBSearchOrCreateXIB" owner:self options:nil] objectAtIndex:0];
}

- (void)presentSearchOrCreateViewControllerFromRect:(CGRect)rect andParentVC:(UIViewController *)parent
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        popover = [[UIPopoverController alloc] initWithContentViewController:self];
        popover.popoverContentSize = CGSizeMake(300, 320);
        [popover presentPopoverFromRect:rect inView:parent.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
    else {
        [parent presentViewController:self animated:YES completion:nil];
    }
}

- (void)setItemType:(NSString *)itemType_
{
    itemType = itemType_;
    self.hintLabel.text = [NSString stringWithFormat:@"Hint: Pressing return on your keyboard will also create a new %@", itemType.lowercaseString];
}

- (void) initTable
{
    cellNib = [UINib nibWithNibName:@"CBSearchOrCreateCellXIB" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"CBSearchOrCreateCell"];
}

- (void)reloadData
{
    items = itemsForSearchText(self.searchBar.text);
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    items = itemsForSearchText(searchText);
    [self.tableView reloadData];
}

- (IBAction)createTap:(id)sender {
    userCreatedItemWithText(self.searchBar.text);
    [self reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    userCreatedItemWithText(searchBar.text);
    [self reloadData];
}

#pragma mark UITableViewDataSource

- (CBSearchOrCreateCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CBSearchOrCreateCell";
    
    CBSearchOrCreateCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[CBSearchOrCreateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    NSString *item = items[indexPath.row];
    
    cell.name.text = item;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger result = items.count;
    self.emptyView.hidden = result > 0;
    if (result == 0) {
        self.searchBar.returnKeyType = UIReturnKeyDone;
        NSString *before = [NSString stringWithFormat:@"%@ '", itemType];
        NSString *after = @"' doesnt exists.\nDo you want to create it?";
        NSMutableAttributedString *attrStr = [NSMutableAttributedString attributedStringWithString:[NSString stringWithFormat:@"%@%@%@", before, self.searchBar.text, after]];
        
        OHParagraphStyle* paragraphStyle = [OHParagraphStyle defaultParagraphStyle];
        paragraphStyle.textAlignment = kCTCenterTextAlignment;
        paragraphStyle.lineBreakMode = kCTLineBreakByWordWrapping;
        
        [attrStr setParagraphStyle:paragraphStyle];
        
        [attrStr setFont:[UIFont fontWithName:@"Helvetica" size:15]];
        [attrStr setTextBold:YES range:NSMakeRange(before.length, self.searchBar.text.length)];
        self.errorLabel.attributedText = attrStr;
    } else {
        self.searchBar.returnKeyType = UIReturnKeySearch;
    }
    return result;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    userSelectedItem(items[indexPath.row]);
}

@end
