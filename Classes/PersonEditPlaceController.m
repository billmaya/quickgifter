//
//  PersonEditStoreController.m
//  QuickGifter
//
//  Created by Bill Maya on 8/4/09.
//  Copyright 2009 Wampum & Womantam Creations. All rights reserved.
//

#import "QuickGifterAppDelegate.h"
#import "PersonEditPlaceController.h"


@implementation PersonEditPlaceController

@synthesize tableView, details;
@synthesize categoryItems, categories;
@synthesize editingPlace, editingContent;

- (IBAction)save:(id)sender
{

	if (newItem) {
		[editingContent addObject:editingPlace];
		newItem = NO;
	}
	
	[self.navigationController popViewControllerAnimated:YES]; 
}

- (IBAction)cancel:(id)sender
{
	newItem = NO; // cancel edits, restore values from the copy
    //[editingItem setValuesForKeysWithDictionary:editingItemCopy];
	
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
	
	self.title = @"Editing Places";
	
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
	
	/*/ BEGIN - Setup-FavPlaces PList Implementation
	self.details = ((QuickGifterAppDelegate *)[UIApplication sharedApplication].delegate).details;

	NSMutableArray *allPlaces = [[NSMutableArray alloc] init];
	
	for (NSDictionary *item in details) {
		NSString *name = [item objectForKey:@"name"];
		if ([name isEqualToString: @"People Categories"] == YES) {
			NSArray *content = [item objectForKey:@"content"];
			for (NSDictionary *dictionaryItem in content) {
				NSString *categoryName = [dictionaryItem objectForKey:@"name"];
				if ([categoryName isEqualToString:@"Fav Places"] == YES) {
					
					NSArray *placeItems = [dictionaryItem objectForKey:@"items"];
					for (NSDictionary *item in placeItems) {
						[allPlaces addObject:[item objectForKey:@"name"]];
					}
					[allPlaces sortUsingSelector:@selector(compare:)];
					break;
				}
			}
			break;
		}
	}
	
	NSMutableDictionary *places = [[NSMutableDictionary alloc] init];
	NSString *alphabet = [[NSString alloc] initWithString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZ"];
	
	for (int x = 0; x < 26; x++) {
		NSString *letter = [alphabet substringWithRange:NSMakeRange(x, 1)];
		[places setObject:[NSMutableArray array] forKey:letter];
	}
	
	for (NSString *place in allPlaces) {
		NSString *first = [[place substringWithRange:NSMakeRange(0, 1)] uppercaseString];
		NSMutableArray *letterArray = [places objectForKey:first];
		[letterArray addObject:place];
	}
	
	self.categoryItems = [[[NSDictionary alloc] initWithDictionary:places] autorelease];
	self.categories = [[self.categoryItems allKeys] sortedArrayUsingSelector:@selector(compare:)];
	// END */
	
	// BEGIN - FavPlaces PList Implementation
	self.categoryItems = ((QuickGifterAppDelegate *)[UIApplication sharedApplication].delegate).favplaces;
	self.categories = [[self.categoryItems allKeys] sortedArrayUsingSelector:@selector(compare:)];
	// END 
	
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
	
    if (editingPlace == nil) { // Create new item
		self.editingPlace = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"", @"Name", @"", @"Type", nil];
        newItem = YES; // Set flag. Add item when user saves; if user cancels, no action needed
	}
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
	
	[categoryItems release];
	[categories release];
    [super dealloc];
}

#pragma mark -
#pragma mark TableView Data Source Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
	
	return [categories count];
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
	
	NSString *key = [categories objectAtIndex:section];
	NSArray *categorySection = [categoryItems objectForKey:key];
	return [categorySection count];
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSUInteger section = [indexPath section];
	NSString *key = [categories objectAtIndex:section];
	NSArray *categorySection = [categoryItems objectForKey:key];
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonEditDate"];
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"PersonEditDate"] autorelease];
	}

	cell.textLabel.text = [categorySection objectAtIndex:indexPath.row];
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

#pragma mark -
#pragma mark TableView Delegate Methods

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSUInteger section = [indexPath section];
	NSString *key = [categories objectAtIndex:section];
	NSArray *categorySection = [categoryItems objectForKey:key];
	
	[editingPlace setValue:[categorySection objectAtIndex:indexPath.row] forKey:@"Name"];
}

@end
