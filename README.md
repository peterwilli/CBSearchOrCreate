#CBSearchOrCreate
####Useful combined search & creation solution

![image](https://wayser.com/oc/public.php?service=files&t=11cb8b465623ad68e189455a964a3e27&download)

CBSearchOrCreate is a result of a recent design trend I'm trying to promote called "Multipurpose" - the idea of single objects capable of doing multiple tasks - to further simplify interfaces & shrink the amount of buttons, toolbars & menus is a user interface.

~ More controls will follow.

##Features

- As seen in many CodeBuffet products

- iOS 6 & 7 compatible
	
	Automatically adapts the native style
	 
- Easily customizable via the interface builder files
- Works on iPad and iPhone
- Works with any sort of objects thanks to the easy singular callback system
- Free ;)

##Installation

1. Clone this repository	`git clone https://github.com/peterwilli/CBSearchOrCreate.git`
	
2. Copy the library/CBSearchOrCreate/ folder to your project or run the example by opening the workspace
3. Make sure you have the dependencies (easily installable via CocoaPods)	In podfile: `pod "OHAttributedLabel"`
4. The easiest way to open a search or create view is like this:

		NSMutableArray *demoItems = [NSMutableArray arrayWithArray:@[@"wayser.com", @"codebuffet.co", @"54limited.com", @"yamm.ca"]];
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
	    
	    