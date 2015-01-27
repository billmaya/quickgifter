//
//  PersonListController.m
//  QuickGifter
//
//  Created by Bill Maya on 5/2/09.
//  Copyright 2009 Wampum & Womantam Creations. All rights reserved.
//

#import "QuickGifterAppDelegate.h"
#import "PersonListController.h"
#import "PersonDetailController.h"
#import "PersonEditDateController.h"

@implementation PersonListController

@synthesize people, tableView;
@synthesize personEditNameController;

- (IBAction)createPerson
{
	UIAlertView *alert = [[UIAlertView alloc]
						  initWithTitle:@"Button Selected" 
						  message:@"Create"
						  delegate:self 
						  cancelButtonTitle:@"OK" 
						  otherButtonTitles:nil];
	
	[alert show];
	[alert release];
}

- (IBAction)importPerson
{
	UIAlertView *alert = [[UIAlertView alloc]
						  initWithTitle:@"Button Selected" 
						  message:@"Import One"
						  delegate:self 
						  cancelButtonTitle:@"OK" 
						  otherButtonTitles:nil];
	
	[alert show];
	[alert release];
}

- (IBAction)importAllPeople {
	UIAlertView *alert = [[UIAlertView alloc]
						  initWithTitle:@"Button Selected" 
						  message:@"Import All" 
						  delegate:self 
						  cancelButtonTitle:@"OK" 
						  otherButtonTitles:nil];
	
	[alert show];
	[alert release];
}

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
}self.Title
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	self.people = ((QuickGifterAppDelegate *)[UIApplication sharedApplication].delegate).people;
		
	UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"People" style:UIBarButtonItemStylePlain target:nil action:nil];
	self.navigationItem.backBarButtonItem = backButton;
	[backButton release];
	
	// Display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
	/* Don't remove
	UIBarButtonItem *infoButton = [[UIBarButtonItem alloc] initWithTitle:@"About" style:UIBarButtonItemStylePlain target:nil action:nil];
	self.navigationItem.leftBarButtonItem = infoButton;
	[infoButton release];
	*/
	 
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [tableView reloadData];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
}

#pragma mark -
#pragma mark ActionSheet Delegate Methods

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
	if (!(buttonIndex == [actionSheet cancelButtonIndex]))
	{
		switch (buttonIndex)
		{
			case 0: // Create
				[self createPerson];
				break;
				
			case 1: // Import One
				[self importPerson];
				break;
				
			case 2: // Import All
				[self importAllPeople];
				break;
		}
	}
}

#pragma mark -
#pragma mark Table Data Source Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	NSInteger count = [self.people count]; // WJTM - 10.15.09 - added "self."
    if (self.editing) count++; 
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *TopLevelCellIdentifier = @"MyPerson";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TopLevelCellIdentifier];
	if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TopLevelCellIdentifier] autorelease];
	}
	
	
	if (indexPath.row >= [self.people count]) { // WJTM - 10.15.09 - added "self."
		cell.textLabel.text = @"Add new Person";
	} else {
		NSDictionary *person = [self.people objectAtIndex:indexPath.row]; // PList imp.
		NSString *fname = [person objectForKey:@"fullname"];
		cell.textLabel.text = fname;
	}
	
	return cell;
}

// The editing style for a row is the kind of button displayed to the left of the cell when in editing mode.
- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	if (self.editing == NO || !indexPath) return UITableViewCellEditingStyleNone;
	
	if (indexPath.row >= [people count]) {
		return UITableViewCellEditingStyleInsert;
	} else {
		return UITableViewCellEditingStyleDelete;
	}
	
	return UITableViewCellEditingStyleNone;
}

#pragma mark -
#pragma mark Table Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSUInteger row = [indexPath row];

	PersonDetailController *childController = [[PersonDetailController alloc]
											   initWithNibName:@"PersonDetailView" bundle:nil];
	
	childController.person = [self.people objectAtIndex:row];
	
	[[self navigationController] pushViewController:childController animated:YES];
	[childController release];
}

- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath {
	
	return UITableViewCellAccessoryDetailDisclosureButton;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {

	// How would you call didSelectrowAtIndexPath (lines 190-201) from here?
	
	NSUInteger row = [indexPath row];
	
	PersonDetailController *childController = [[PersonDetailController alloc]
											   initWithNibName:@"PersonDetailView" bundle:nil];
	
	childController.person = [self.people objectAtIndex:row];
	
	[[self navigationController] pushViewController:childController animated:YES];
	[childController release];
}

#pragma mark Editing

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
	
    [super setEditing:editing animated:animated];
	
    NSIndexPath *ip = [NSIndexPath indexPathForRow:[people count] inSection:0];
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

- (void)tableView:(UITableView *)aTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle 
forRowAtIndexPath:(NSIndexPath *)indexPath {
	
    if (editingStyle == UITableViewCellEditingStyleDelete) {
		[people removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];		
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
		
		// Uncomment to go to person Create screen
		PersonEditNameController *controller = self.personEditNameController;
		
		controller.editingItem = nil; // "nil" indicates create new item
		controller.editingContent = self.people; // group to add new item to
		
		[self.navigationController pushViewController:controller animated:YES];
		 
		/*// Uncomment when Create/Import/Import All action sheetfeature added
		UIActionSheet *createImportSheet = [[UIActionSheet alloc]
											initWithTitle:@"Create New Person or Import Existing Contacts?" 
											delegate:self 
											cancelButtonTitle:@"Cancel"
											destructiveButtonTitle:nil
											otherButtonTitles:@"Create", @"Import One", @"Import All", nil];
		
		[createImportSheet showInView:self.tabBarController.view];
		[createImportSheet release]; */
    }
}

#pragma mark -
#pragma mark Other UIViewControllers

- (PersonEditNameController *)personEditNameController {
	if (personEditNameController == nil) {
		PersonEditNameController *controller = [[PersonEditNameController alloc] initWithNibName:@"SetupEditView" bundle:nil];
		self.personEditNameController = controller;
		[controller release];
	}
	return personEditNameController;
}

@end
