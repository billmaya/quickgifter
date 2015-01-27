//
//  PersonEditLikeController.m
//  QuickGifter
//
//  Created by Bill Maya on 8/4/09.
//  Copyright 2009 Wampum & Womantam Creations. All rights reserved.
//

#import "QuickGifterAppDelegate.h"
#import "PersonEditLikeController.h"


@implementation PersonEditLikeController

@synthesize dependentPicker, details, categoryItems, categories, items;
@synthesize detailField;
@synthesize editingLike, editingContent, editingType;

- (IBAction)save:(id)sender
{
	
	// Gets selection from category/item picker
	NSInteger categoryRow = [dependentPicker selectedRowInComponent:categoryComponent];
	NSInteger itemRow = [dependentPicker selectedRowInComponent:itemComponent];
	
	NSString *category = [self.categories objectAtIndex:categoryRow];
	NSString *item, *combined;
	if (itemRow < 0) {
		item = @"";
		combined = [[NSString alloc] initWithFormat:@"%@", category];
	} else {
		item = [self.items objectAtIndex:itemRow];
		combined = [[NSString alloc] initWithFormat:@"%@ - %@", category, item];
	}
	
	// save edits to the editing item and add new item to the content.
	if ([detailField.text length] == 0) {
		[editingLike setValue:combined forKey:@"Name"];
		[editingLike setValue:@"" forKey:@"Type"];
	} else {
		[editingLike setValue:detailField.text forKey:@"Name"];
		[editingLike setValue:combined   forKey:@"Type"];
	}
	
    if (newItem) {
		@try {
			[editingContent addObject:editingLike];
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
	
	[self.navigationController popViewControllerAnimated:YES]; 
}

- (IBAction)textFieldDoneEditing:(id)sender
{
	[sender resignFirstResponder];
}

- (IBAction)backgroundClick:(id)sender
{
	[detailField resignFirstResponder];
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
    
	self.title = @"Editing Likes";
	
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
	
	self.details = ((QuickGifterAppDelegate *)[UIApplication sharedApplication].delegate).details;
	
	NSMutableDictionary *catItems = [[NSMutableDictionary alloc] init];
	
	for (NSDictionary *item in details) {
		NSString *name = [item objectForKey:@"name"];
		if ([name isEqualToString: @"Gift Idea/Like Categories"] == YES) {
			NSArray *content = [item objectForKey:@"content"];
			for (NSDictionary *dictionaryItem in content) {
				NSString *categoryName = [dictionaryItem objectForKey:@"name"];
				NSArray *categoryItemItems = [dictionaryItem objectForKey:@"items"];
				NSMutableArray *category = [[NSMutableArray alloc] init];
				for (NSDictionary *itemEntry in categoryItemItems) {
					[category addObject:[itemEntry objectForKey:@"name"]];
				}
				[catItems setValue:category forKey:categoryName];
				[category release];
			}
			break;
		}
	}
	
	self.categoryItems = [[[NSDictionary alloc] initWithDictionary:catItems] autorelease];
	self.categories = [[self.categoryItems allKeys] sortedArrayUsingSelector:@selector(compare:)];
	self.items = [self.categoryItems objectForKey:[self.categories objectAtIndex:0]];
	
	[super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
	
    if (editingLike == nil) { // Create new item
		self.editingLike = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"", @"Name", @"", @"Type", nil];
        newItem = YES; // Set flag. Add item when user saves; if user cancels, no action needed
	}
	detailField.text = @"";
	[detailField becomeFirstResponder];
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
	[dependentPicker release];
	[categoryItems release];
	[categories release];
	[items release];
    [super dealloc];
}

#pragma mark -
#pragma mark Picker Data Source Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
	if (component == categoryComponent)
		return [self.categories count];
	
	return [self.items count];
}

#pragma mark Picker Delegate Methods

- (NSString *)pickerView:(UIPickerView *)pickerView
			 titleForRow:(NSInteger)row
			forComponent:(NSInteger)component
{
	if (component == categoryComponent)
		return [self.categories objectAtIndex:row];
	
	return [self.items objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView
	  didSelectRow:(NSInteger)row
	   inComponent:(NSInteger)component
{
	if (component == categoryComponent)
	{
		NSString *selectedCategory = [self.categories objectAtIndex:row];
		NSArray *array = [categoryItems objectForKey:selectedCategory];
		self.items = array;
		[dependentPicker selectRow:0 inComponent:itemComponent animated:YES];
		[dependentPicker reloadComponent:itemComponent];
	}
}

- (CGFloat)pickerView:(UIPickerView *)pickerView
	widthForComponent:(NSInteger)component
{
	//if (component == itemComponent)
	//	return 90;
	//return	200;
	return 145;
}

@end
