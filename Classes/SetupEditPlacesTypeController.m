//
//  PersonEditDateTypeController.m
//  QuickGifter
//
//  Created by Bill Maya on 9/12/09.
//  Copyright 2009 Wampum & Womantam Creations. All rights reserved.
//

#import "SetupEditPlacesTypeController.h"


@implementation SetupEditPlacesTypeController

@synthesize types, editingItem, tableView;


- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle {
 
	if (self = [super initWithNibName:nibName bundle:bundle]) {
		self.title = @"Place Types";
	}
	return self;
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[types release];
    [editingItem release];
    [tableView release];
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated {
    // Remove any previous selection.
    NSIndexPath *tableSelection = [tableView indexPathForSelectedRow];
	[tableView deselectRowAtIndexPath:tableSelection animated:NO];
    [tableView reloadData];
}

// Return a checkmark accessory for only the currently designated type of the editing item.
- (UITableViewCellAccessoryType)tableView:(UITableView *)aTableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath {
		
    return ([[types objectAtIndex:indexPath.row] isEqualToString:[editingItem valueForKey:@"type"]]) ? 
	UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
}

// Selection updates the editing item's type and navigates to the previous view controller.
- (NSIndexPath *)tableView:(UITableView *)aTableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
		
    [editingItem setValue:[types objectAtIndex:indexPath.row] forKey:@"type"];
    [self.navigationController popViewControllerAnimated:YES];
    return indexPath;
}

// The table uses standard UITableViewCells. The text for a cell is simply the string value of the matching type.
- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DateTypeCell"];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"DateTypeCell"] autorelease];
    }
	
    cell.textLabel.text = [types objectAtIndex:indexPath.row];
    return cell;
}

// The table has one row for each possible type.
- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
    return [types count];
}


@end
