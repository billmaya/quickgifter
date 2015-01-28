//
//  SetupPeopleDatesViewController.m
//  QuickGifter
//
//  Created by Bill Maya on 7/1/09.
//  Copyright 2009 Wampum & Womantam Creations. All rights reserved.
//

#import "SetupDetailPlacesController.h"
#import "SetupDetailPlacesCell.h"


@implementation SetupDetailPlacesController

@synthesize caption, tableView;
@synthesize categoryItems, categories;
@synthesize setupEditPlacesController;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	self.title = self.caption;
	self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
	[super viewDidLoad];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)viewWillAppear:(BOOL)animated {
    [tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
}

#pragma mark -
#pragma mark Table View Data Source Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return [categories count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	
	NSString *key = [categories objectAtIndex:section];
	NSArray *categorySection = [categoryItems objectForKey:key];
	
	NSInteger count = [categorySection count];
	if (self.editing) count++; // If we're in editing mode, we add a placeholder row for creating new items.
	
	return count;	
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	NSUInteger section = [indexPath section];
	NSString *key = [categories objectAtIndex:section];
	NSArray *categorySection = [categoryItems objectForKey:key];

	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SectionsTableIdentifier"];
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"SectionsTableIdentifier"] autorelease];
	}
	
	if (indexPath.row >= [categorySection count]) {
		cell.textLabel.text = [NSString stringWithFormat:@"Add new %@", self.caption];
	} else {
		cell.textLabel.text = [categorySection objectAtIndex:indexPath.row];
	}
	
	return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	NSString *key = [categories objectAtIndex:section];
	return key;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
	return categories;
}


// The editing style for a row is the kind of button displayed to the left of the cell when in editing mode.
- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	// No editing style if not editing or the index path is nil.
    if (self.editing == NO || !indexPath) return UITableViewCellEditingStyleNone;
    // Determine the editing style based on whether the cell is a placeholder for adding content or already 
    // existing content. Existing content can be deleted.
    
	NSUInteger section = [indexPath section];
	NSString *key = [categories objectAtIndex:section];
	NSArray *categorySection = [categoryItems objectForKey:key];
	
	if (indexPath.row >= [categorySection count]) {
		return UITableViewCellEditingStyleInsert;
	} else {
		return UITableViewCellEditingStyleDelete; // Comment out UITableView...Delete to prevent Fav Place deletes  
	}
	
    return UITableViewCellEditingStyleNone;
}

#pragma mark Table Selection 

// Called after selection. In editing mode, this will navigate to a new view controller.
- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.editing) {
        // Don't maintain the selection. We will navigate to a new view so there's no reason to keep the selection here.
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
    } else {
        // This will give the user visual feedback that the cell was selected but fade out to indicate that no
        // action is taken.
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

#pragma mark Editing

// Set the editing state of the view controller. We pass this down to the table view and also modify the content
// of the table to insert a placeholder row for adding content when in editing mode.
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
	
    [super setEditing:editing animated:animated];
	
	NSArray *indexPaths = [NSArray arrayWithObjects:
	[NSIndexPath indexPathForRow:[[categoryItems objectForKey:@"A"] count] inSection:0], 
	[NSIndexPath indexPathForRow:[[categoryItems objectForKey:@"B"] count] inSection:1],
	[NSIndexPath indexPathForRow:[[categoryItems objectForKey:@"C"] count] inSection:2],
	[NSIndexPath indexPathForRow:[[categoryItems objectForKey:@"D"] count] inSection:3],
	[NSIndexPath indexPathForRow:[[categoryItems objectForKey:@"E"] count] inSection:4],
	[NSIndexPath indexPathForRow:[[categoryItems objectForKey:@"F"] count] inSection:5],
	[NSIndexPath indexPathForRow:[[categoryItems objectForKey:@"G"] count] inSection:6], 
	[NSIndexPath indexPathForRow:[[categoryItems objectForKey:@"H"] count] inSection:7],
	[NSIndexPath indexPathForRow:[[categoryItems objectForKey:@"I"] count] inSection:8],
	[NSIndexPath indexPathForRow:[[categoryItems objectForKey:@"J"] count] inSection:9],
	[NSIndexPath indexPathForRow:[[categoryItems objectForKey:@"K"] count] inSection:10],
	[NSIndexPath indexPathForRow:[[categoryItems objectForKey:@"L"] count] inSection:11],
	[NSIndexPath indexPathForRow:[[categoryItems objectForKey:@"M"] count] inSection:12], 
	[NSIndexPath indexPathForRow:[[categoryItems objectForKey:@"N"] count] inSection:13],
	[NSIndexPath indexPathForRow:[[categoryItems objectForKey:@"O"] count] inSection:14],
	[NSIndexPath indexPathForRow:[[categoryItems objectForKey:@"P"] count] inSection:15],
	[NSIndexPath indexPathForRow:[[categoryItems objectForKey:@"Q"] count] inSection:16],
	[NSIndexPath indexPathForRow:[[categoryItems objectForKey:@"R"] count] inSection:17],
	[NSIndexPath indexPathForRow:[[categoryItems objectForKey:@"S"] count] inSection:18], 
	[NSIndexPath indexPathForRow:[[categoryItems objectForKey:@"T"] count] inSection:19],
	[NSIndexPath indexPathForRow:[[categoryItems objectForKey:@"U"] count] inSection:20],
	[NSIndexPath indexPathForRow:[[categoryItems objectForKey:@"V"] count] inSection:21],
	[NSIndexPath indexPathForRow:[[categoryItems objectForKey:@"W"] count] inSection:22],
	[NSIndexPath indexPathForRow:[[categoryItems objectForKey:@"X"] count] inSection:23],
	[NSIndexPath indexPathForRow:[[categoryItems objectForKey:@"Y"] count] inSection:24],
	[NSIndexPath indexPathForRow:[[categoryItems objectForKey:@"Z"] count] inSection:25],nil];	

  	[tableView beginUpdates];
	[tableView setEditing:editing animated:YES];
    
	if (editing) {
        // Show the placeholder rows
        [tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
    } else {
        // Hide the placeholder rows.
        [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
    }
	
    [tableView endUpdates];
}


// Update the data model according to edit actions delete or insert.
- (void)tableView:(UITableView *)aTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle 
forRowAtIndexPath:(NSIndexPath *)indexPath {
	
    if (editingStyle == UITableViewCellEditingStyleDelete) {
		
		NSUInteger section = [indexPath section];
		NSString *key = [categories objectAtIndex:section];
		NSMutableArray *categorySection = [[NSMutableArray alloc] init];
		categorySection = [categoryItems objectForKey:key]; 
		
		[categorySection removeObjectAtIndex:indexPath.row]; 
		
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
		
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
		
		SetupEditPlacesController *controller = self.setupEditPlacesController;
			
		controller.editingItem = nil; // "nil" indicates create new item
		
		NSUInteger section = [indexPath section];
		NSString *key = [categories objectAtIndex:section];
		NSMutableArray *categorySection = [categoryItems objectForKey:key]; 
		
		controller.editingContent = categorySection; // array to add new item to 
		controller.sectionName = self.caption;
			
		[self.navigationController pushViewController:controller animated:YES];
    }
}

#pragma mark -
#pragma mark Other UIViewControllers


- (SetupEditPlacesController *)setupEditPlacesController {
	if (setupEditPlacesController == nil) {
		SetupEditPlacesController *controller = [[SetupEditPlacesController alloc] initWithNibName:@"SetupEditPlacesView" bundle:nil];
		self.setupEditPlacesController = controller;
		[controller release];
	}
	return setupEditPlacesController;
}

@end
