//
//  SetupPeopleDatesViewController.m
//  QuickGifter
//
//  Created by Bill Maya on 7/1/09.
//  Copyright 2009 Wampum & Womantam Creations. All rights reserved.
//

#import "SetupDetailController.h"
#import "SetupDetailPlacesCell.h"


@implementation SetupDetailController

@synthesize caption;
@synthesize details;
@synthesize tableView;
@synthesize setupEditController;

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
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	NSInteger count = [details count];
	if (self.editing) count++; // If we're in editing mode, we add a placeholder row for creating new items.
	return count;	
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SectionsTableIdentifier"];
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"SectionsTableIdentifier"] autorelease];
	}
	
	if (indexPath.row >= [details count]) {
		cell.textLabel.text = [NSString stringWithFormat:@"Add new %@", self.caption]; // UITableViewCell
	} else {
		NSDictionary *item = [details objectAtIndex:indexPath.row];
		cell.textLabel.text = [item valueForKey:@"name"]; // UITableViewCell
	}
	
	return cell;
}

// The editing style for a row is the kind of button displayed to the left of the cell when in editing mode.
- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	// No editing style if not editing or the index path is nil.
    if (self.editing == NO || !indexPath) return UITableViewCellEditingStyleNone;
    // Determine the editing style based on whether the cell is a placeholder for adding content or already 
    // existing content. Existing content can be deleted.
    
	if (indexPath.row >= [details count]) {
		return UITableViewCellEditingStyleInsert;
	} else {
		return UITableViewCellEditingStyleDelete;
	}
	
    return UITableViewCellEditingStyleNone;
}

#pragma mark Table Selection 

// Called after selection. In editing mode, this will navigate to a new view controller.
- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.editing) {
        // Don't maintain the selection. We will navigate to a new view so there's no reason to keep the selection here.
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        // Go to edit view
        NSDictionary *item = [details objectAtIndex:indexPath.row];
        if (item) {
			SetupEditController *controller = self.setupEditController;
			[self.navigationController pushViewController:controller animated:YES];
        }
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
	
	NSIndexPath *ip = [NSIndexPath indexPathForRow:[details count] inSection:0];
	NSArray *indexPaths = [NSArray arrayWithObjects:ip, nil];

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
		
		[details removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        SetupEditController *controller = self.setupEditController;

        controller.editingItem = nil; // "nil" indicates create new item
        controller.editingContent = self.details; // group to add new item to
        controller.sectionName = self.caption;
			
        [self.navigationController pushViewController:controller animated:YES];
    }
}

#pragma mark -
#pragma mark Other UIViewControllers

- (SetupEditController *)setupEditController {
	if (setupEditController == nil) {
		SetupEditController *controller = [[SetupEditController alloc] initWithNibName:@"SetupEditView" bundle:nil];
		self.setupEditController = controller;
		[controller release];
	}
	return setupEditController;
}

@end
