//
//  SetupEditController.m
//  QuickGifter
//
//  Created by Bill Maya on 8/7/09.
//  Copyright 2009 Wampum & Womantam Creations. All rights reserved.
//

#import "QuickGifterAppDelegate.h"
#import "SetupEditPlacesController.h"
#import "SetupEditPlacesTypeController.h"


@implementation SetupEditPlacesController

@synthesize details, setupEditPlacesTypeController;
@synthesize editingItem, editingItemCopy, editingContent, sectionName, tableView; //placeTypes, tableView;

// When we set the editing item, we also make a copy in case edits are made and then canceled - then we can
// restore from the copy.

- (void)setEditingItem:(NSString *)anItem {
    [editingItem release];
    editingItem = [anItem retain];
    self.editingItemCopy = editingItem;
}

- (IBAction)cancel:(id)sender {
    // cancel edits, restore all values from the copy
    
	newItem = NO;
	editingItem = editingItemCopy;
	
	[self.navigationController popViewControllerAnimated:YES]; 
}

- (IBAction)save:(id)sender {
	
    // save edits to the editing item and add new item to the content.
	editingItem = [itemCell.textField.text copy];
    if (newItem) {
        [editingContent addObject:editingItem];
        newItem = NO;
    }
    
	[self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)nameFieldDoneEditing:(id)sender
{
	[sender resignFirstResponder];
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
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] 
								   initWithTitle:@"Save" 
								   style:UIBarButtonItemStylePlain 
								   target:self
								   action:@selector(save:)];
	
	self.navigationItem.rightBarButtonItem = saveButton;
	[saveButton release];
	
	UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] 
									 initWithTitle:@"Cancel" 
									 style:UIBarButtonItemStylePlain 
									 target:self
									 action:@selector(cancel:)];
	
	self.navigationItem.leftBarButtonItem = cancelButton;
	[cancelButton release];
	
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
	
	self.title = [NSString stringWithFormat:@"Editing %@", sectionName];
	
    if (editingItem == nil) { // Create new item
		self.editingItem = [NSMutableString stringWithString:@""];
        newItem = YES; // Set a flag. When the user saves, add the item; if user cancels, no action needed
    }
    /*if (!categoryCell) {
        categoryCell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"CategoryCell"];
    }
    categoryCell.textLabel.text = @"Type of Place";*/
	
    if (!itemCell) {
        itemCell = [[SetupEditCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ItemCell"];
    }
    
	itemCell.textField.placeholder = @"Place Name";
	itemCell.textField.text = editingItem;
    [itemCell.textField becomeFirstResponder]; // Starts editing; shows keyboard
	
	[tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    
}

- (NSIndexPath *)tableView:(UITableView *)aTableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return indexPath;
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
	[editingItem release];
	[editingItemCopy release];
	[editingContent release];
	[sectionName release];
	[tableView release];
    [super dealloc];
}

#pragma mark -
#pragma mark TableView Data Source Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
	
    return 1; // Change to "2" to add Category selector
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
	
    return 1;
}

- (UITableViewCellAccessoryType)tableView:(UITableView *)aTableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath {

	return (indexPath.section == 0) ? UITableViewCellAccessoryNone : UITableViewCellAccessoryDisclosureIndicator;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	return (indexPath.section == 0) ? itemCell : categoryCell;
}

#pragma mark -
#pragma mark TableView Delegate Methods

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [aTableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark Other UIViewControllers

- (SetupEditPlacesTypeController *)setupEditPlacesTypeController {
	if (setupEditPlacesTypeController == nil) {
		SetupEditPlacesTypeController *controller = [[SetupEditPlacesTypeController alloc] initWithNibName:@"SetupEditPlacesTypeView" bundle:nil];
		self.setupEditPlacesTypeController = controller;
		[controller release];
	}
	return setupEditPlacesTypeController;
}

@end
