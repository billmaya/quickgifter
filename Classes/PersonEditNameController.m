//
//  PersonEditNameController.m
//  QuickGifter
//
//  Created by Bill Maya on 8/15/09.
//  Copyright 2009 Wampum & Womantam Creations. All rights reserved.
//

#import "PersonEditNameController.h"


@implementation PersonEditNameController

@synthesize editingItem, editingContent, tableView;

- (IBAction)cancel:(id)sender {
	
    // cancel edits, restore all values from the copy
    newItem = NO;
	
	[self.navigationController popViewControllerAnimated:YES]; 
}

- (IBAction)save:(id)sender {
	
    // save edits to the editing item and add new item to the content.
    [editingItem setValue:personEditNameCell.textField.text forKey:@"fullname"];
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

	self.title = @"Editing Name";
	
    if (editingItem == nil) { // Create new item
        
		NSMutableArray *emptyGiftArray = [NSMutableArray array];
		NSMutableArray *emptyDateArray = [NSMutableArray array];
		NSMutableArray *emptySizeArray = [NSMutableArray array];
		NSMutableArray *emptyLikeArray = [NSMutableArray array];
		NSMutableArray *emptyPlaceArray = [NSMutableArray array];
		
		NSDictionary *giftDict = [NSDictionary dictionaryWithObjectsAndKeys:@"Gift Ideas", @"name", emptyGiftArray, @"content", nil];
		NSDictionary *dateDict = [NSDictionary dictionaryWithObjectsAndKeys:@"Important Dates", @"name", emptyDateArray, @"content", nil];
		NSDictionary *sizeDict = [NSDictionary dictionaryWithObjectsAndKeys:@"Sizes", @"name", emptySizeArray, @"content", nil];
		NSDictionary *likeDict = [NSDictionary dictionaryWithObjectsAndKeys:@"Likes", @"name", emptyLikeArray, @"content", nil];
		NSDictionary *placeDict = [NSDictionary dictionaryWithObjectsAndKeys:@"Fav Places", @"name", emptyPlaceArray, @"content", nil];
		
		NSArray *detailsArray = [[NSArray alloc] initWithObjects: giftDict, dateDict, sizeDict, likeDict, placeDict, nil];
		
		self.editingItem = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"", @"fullname", detailsArray, @"info", nil];
		
        newItem = YES; // Set a flag. When the user saves, add the item; if user cancels, no action needed
	}
	
	if (!personEditNameCell) {
        personEditNameCell = [[PersonEditNameCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"PersonNameCell"];
    }
    personEditNameCell.textField.placeholder = @"Name";
    personEditNameCell.textField.text = @""; // Populate if going to allow editing of name
    [personEditNameCell.textField becomeFirstResponder]; // Starts editing; shows keyboard
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
	[tableView release];
    [super dealloc];
}

#pragma mark -
#pragma mark TableView Data Source Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
	
    return 1;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
	
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	return personEditNameCell;
}

#pragma mark -
#pragma mark TableView Delegate Methods

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [aTableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
