//
//  GiftsViewController.m
//  QuickGifter
//
//  Created by Bill Maya on 5/2/09.
//  Copyright 2009 Wampum & Womantam Creations. All rights reserved.
//

#import "QuickGifterAppDelegate.h"
#import "PersonEditDateController.h"
#import "PersonEditDateTypeController.h"

@implementation PersonEditDateController

@synthesize details;
@synthesize editingItem, editingContent, sectionName, dateTypes;
@synthesize datePicker;
@synthesize tableView;
@synthesize personEditDateTypeController;

- (IBAction)save:(id)sender
{
	
	NSDate *selected = [datePicker date];
	NSDateFormatter *df = [[ NSDateFormatter alloc] init];
	
	[df setDateFormat:@"MMMM dd, yyyy"];
	NSString *dateStr = [df stringFromDate:selected];

	if ([typeCell.textLabel.text length] == 0) {
		[editingItem setValue:@"?????" forKey:@"Type"];
	} else {
		[editingItem setValue:typeCell.textLabel.text forKey:@"Type"];
	}
    [editingItem setValue:dateStr   forKey:@"Name"];
	
    if (newItem) {
		@try {
			[editingContent addObject:editingItem];
			newItem = NO;
		}
		@catch (NSException* ex) {
			NSLog(@"addObject failed: %@", ex);
		}
    }
	
	[self.navigationController popViewControllerAnimated:YES]; 
}

- (IBAction)cancel:(id)sender
{
	
	newItem = NO; // cancel edits, restore values from the copy
    //[editingItem setValuesForKeysWithDictionary:editingItemCopy];
	
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
	
	self.title = @"Editing Dates";
	
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
	
	NSDate *now = [[NSDate alloc] init];
	[datePicker setDate:now animated:YES];
	[now release];
	
	self.details = ((QuickGifterAppDelegate *)[UIApplication sharedApplication].delegate).details;
	
	for (NSDictionary *item in details) {
		NSString *name = [item objectForKey:@"name"];
		if ([name isEqualToString: @"People Categories"] == YES) {
			NSArray *content = [item objectForKey:@"content"];
			for (NSDictionary *dictionaryItem in content) {
				NSString *categoryName = [dictionaryItem objectForKey:@"name"];
				if ([categoryName isEqualToString:@"Important Dates"] == YES) {
					
					NSArray *categoryItemItems = [dictionaryItem objectForKey:@"items"];
					NSMutableArray *category = [[NSMutableArray alloc] init];
					for (NSDictionary *itemEntry in categoryItemItems) {
						[category addObject:[itemEntry objectForKey:@"name"]];
					}
					self.dateTypes = category;
					[category release];
					break;
				}
			}
			break;
		}
	}
	
	[super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
	
    if (editingItem == nil) { // Create new item
		self.editingItem = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"", @"Name", @"Select Date Type", @"Type", nil];
        newItem = YES; // Set flag. Add item when user saves; if user cancels, no action needed
	}
	
	if (!typeCell) {
        //typeCell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"TypeCell"];
        typeCell = [[UITableViewCell alloc] initWithStyle:UITableViewStyleGrouped reuseIdentifier:@"TypeCell"];
    }
	typeCell.textLabel.text = [editingItem valueForKey:@"Type"];
	
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
#pragma mark TableView Data Source Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
	
    return 1; 
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
	
    //return [testDates count]; // temp commented out
	return 1;
}

- (UITableViewCellAccessoryType)tableView:(UITableView *)aTableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath {
    
	return UITableViewCellAccessoryDisclosureIndicator;
	//return (indexPath.section == 0) ? UITableViewCellAccessoryNone : UITableViewCellAccessoryDisclosureIndicator;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	return typeCell;
}

#pragma mark -
#pragma mark TableView Delegate Methods

- (NSIndexPath *)tableView:(UITableView *)aTableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
    if (indexPath.section == 0) {
        if (!personEditDateTypeController) {
            PersonEditDateTypeController *controller = [[PersonEditDateTypeController alloc] initWithNibName:@"PersonEditDateTypeView" bundle:nil];
            self.personEditDateTypeController = controller;
            [controller release];
        }
		
		personEditDateTypeController.types = dateTypes;
        personEditDateTypeController.editingItem = editingItem;
        [editingItem setValue:typeCell.textLabel.text forKey:@"Type"];
        [self.navigationController pushViewController:personEditDateTypeController animated:YES];
    }
    return indexPath;
}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [aTableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
