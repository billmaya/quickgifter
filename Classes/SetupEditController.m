//
//  SetupEditController.m
//  QuickGifter
//
//  Created by Bill Maya on 8/7/09.
//  Copyright 2009 Wampum & Womantam Creations. All rights reserved.
//

#import "SetupEditController.h"


@implementation SetupEditController

@synthesize editingItem, editingItemCopy, editingContent, sectionName, tableView;

// When we set the editing item, we also make a copy in case edits are made and then canceled - then we can
// restore from the copy.
- (void)setEditingItem:(NSMutableDictionary *)anItem {
    [editingItem release];
    editingItem = [anItem retain];
    self.editingItemCopy = editingItem;
}

- (IBAction)cancel:(id)sender {
    // cancel edits, restore all values from the copy
    newItem = NO;
    [editingItem setValuesForKeysWithDictionary:editingItemCopy];
	
	[self.navigationController popViewControllerAnimated:YES]; 
}

- (IBAction)save:(id)sender {
    // save edits to the editing item and add new item to the content.
    [editingItem setValue:itemCell.textField.text forKey:@"name"];
    //[editingItem setValue:typeCell.text forKey:@"Type"];
    if (newItem) {
        [editingContent addObject:editingItem];
        newItem = NO;
    }
    
	[self.navigationController popViewControllerAnimated:YES];
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
        self.editingItem = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"", @"name", nil];
        newItem = YES; // Set a flag. When the user saves, add the item; if user cancels, no action needed
    }
    if (!categoryCell) {
        categoryCell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"CategoryCell"];
    }
    categoryCell.textLabel.text = @"Category";
	
    [tableView reloadData];
	
    if (!itemCell) {
        itemCell = [[SetupEditCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"ItemCell"];
    }
    
	//itemCell.textField.placeholder = sectionName;
	
	if ([sectionName isEqualToString: @"Important Dates"] == YES) {
		itemCell.textField.placeholder = @"Date Name";
	} else if ([sectionName isEqualToString: @"Clothing"] == YES) {
		itemCell.textField.placeholder = @"Clothing Name";
	} else {
		itemCell.textField.placeholder = sectionName;
	}
	
    itemCell.textField.text = [editingItem valueForKey:@"name"];
    [itemCell.textField becomeFirstResponder]; // Starts editing; shows keyboard
}

- (void)viewWillDisappear:(BOOL)animated {
    
}

- (NSIndexPath *)tableView:(UITableView *)aTableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        // In future version allow modification of Gift-Category
    }
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

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	return (indexPath.section == 0) ? itemCell : categoryCell;
	
	/*
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SetupEdit"];
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"SetupEdit"] autorelease];
	}

	if (indexPath.section == 0) {
		cell.text = @"Item";
	} else {
		cell.text = @"Category";
	}
	
	return cell;
	*/
}

#pragma mark -
#pragma mark TableView Delegate Methods

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [aTableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
