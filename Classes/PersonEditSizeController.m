//
//  PersonEditSizeController.m
//  QuickGifter
//
//  Created by Bill Maya on 8/4/09.
//  Copyright 2009 Wampum & Womantam Creations. All rights reserved.
//

#import "QuickGifterAppDelegate.h"
#import "PersonEditSizeController.h"
#import "PersonEditSizeTypeController.h"

#define compOne 0
#define compTwo 1
#define compThree 2
#define compFour 3

@implementation PersonEditSizeController

@synthesize details, sizes;
@synthesize componentOne, componentTwo, componentThree, componentFour;
@synthesize editingSize, editingContent, sectionName, editingType, clothingTypes;
@synthesize tableView, sizePicker;
@synthesize personEditSizeTypeController;

- (IBAction)save:(id)sender
{
	
	if (typeCell.textLabel.text != @"Select Clothing Type") {
		NSInteger componentOneRow, componentTwoRow, componentThreeRow, componentFourRow;
		
		switch (sizePicker.numberOfComponents) {
			case 1:
				componentOneRow = [sizePicker selectedRowInComponent:compOne];
				break;
			case 2:
				componentOneRow = [sizePicker selectedRowInComponent:compOne];
				componentTwoRow = [sizePicker selectedRowInComponent:compTwo];
				break;
			case 3:
				componentOneRow = [sizePicker selectedRowInComponent:compOne];
				componentTwoRow = [sizePicker selectedRowInComponent:compTwo];
				componentThreeRow = [sizePicker selectedRowInComponent:compThree];
				break;
			case 4:
				componentOneRow = [sizePicker selectedRowInComponent:compOne];
				componentTwoRow = [sizePicker selectedRowInComponent:compTwo];
				componentThreeRow = [sizePicker selectedRowInComponent:compThree];
				componentFourRow = [sizePicker selectedRowInComponent:compFour];
				break;
			default:
				break;
		}
		
		NSString *category = typeCell.textLabel.text;
		NSMutableString *item;
		
		switch (sizePicker.numberOfComponents) {
			case 1:
				
				item = [self.componentOne objectAtIndex:componentOneRow];
				break;
			case 2:
				
				item = [[self.componentOne objectAtIndex:componentOneRow] stringByAppendingString:@" "];
				item = [item stringByAppendingString:[self.componentTwo objectAtIndex:componentTwoRow]];
				break;
			case 3:
				
				item = [[self.componentOne objectAtIndex:componentOneRow] stringByAppendingString:@" "];
				item = [item stringByAppendingString:[self.componentTwo objectAtIndex:componentTwoRow]];
				item = [item stringByAppendingString:@" "];
				item = [item stringByAppendingString:[self.componentThree objectAtIndex:componentThreeRow]];			
				break;
			case 4:
				
				item = [[self.componentOne objectAtIndex:componentOneRow] stringByAppendingString:@" "];
				
				if ([typeCell.textLabel.text isEqualToString:@"Underwear"]) {
					item = [item stringByAppendingString:[self.componentTwo objectAtIndex:componentTwoRow]];
					item = [item stringByAppendingString:[self.componentThree objectAtIndex:componentThreeRow]];
				} else {
					item = [item stringByAppendingString:[self.componentTwo objectAtIndex:componentTwoRow]];
					item = [item stringByAppendingString:@" "];
					item = [item stringByAppendingString:[self.componentThree objectAtIndex:componentThreeRow]];
				}
					
				item = [item stringByAppendingString:@" "];
				item = [item stringByAppendingString:[self.componentFour objectAtIndex:componentFourRow]];
				break;
			default:
				break;
		}
		
		// save edits to the editing item and add new item to the content.
		[editingSize setValue:item forKey:@"Name"];
		[editingSize setValue:category   forKey:@"Type"];
		
		if (newItem) {
			@try {
				[editingContent addObject:editingSize];
				newItem = NO;
			}
			@catch (NSException* ex) {
				NSLog(@"addObject failed: %@", ex);
			}
			
		}	
		
		[self.navigationController popViewControllerAnimated:YES];
	}
}

- (IBAction)cancel:(id)sender
{
	
	// cancel edits, restore all values from the copy
    newItem = NO;
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
	
	self.title = @"Editing Sizes";
	
	// DYNAMIC IMPLEMENTATION - CLOTHING
	self.sizes = ((QuickGifterAppDelegate *)[UIApplication sharedApplication].delegate).sizes;
	self.details = ((QuickGifterAppDelegate *)[UIApplication sharedApplication].delegate).details;
	
	for (NSDictionary *item in details) {
		NSString *name = [item objectForKey:@"name"];
		if ([name isEqualToString: @"People Categories"] == YES) {
			NSArray *content = [item objectForKey:@"content"];
			for (NSDictionary *dictionaryItem in content) {
				NSString *categoryName = [dictionaryItem objectForKey:@"name"];
				if ([categoryName isEqualToString:@"Clothing"] == YES) {
				
					NSArray *categoryItemItems = [dictionaryItem objectForKey:@"items"];
					NSMutableArray *category = [[NSMutableArray alloc] init];
					for (NSDictionary *itemEntry in categoryItemItems) {
						[category addObject:[itemEntry objectForKey:@"name"]];
					}
					//self.componentOne = category;
					self.clothingTypes = category;
					[category release];
					break;
				}
			}
			break;
		}
	}
	
	self.componentOne = [[NSMutableArray alloc] init];
	self.componentTwo = [[NSMutableArray alloc] init];
	self.componentThree = [[NSMutableArray alloc] init];
	self.componentFour = [[NSMutableArray alloc] init];
	
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
	
    if (editingSize == nil) { // Create new item
		self.editingSize = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"", @"Name", @"Select Clothing Type", @"Type", nil];
        newItem = YES; // Set flag. Add item when user saves; if user cancels, no action needed
	}
	
	if (!typeCell) {
        typeCell = [[UITableViewCell alloc] initWithFrame:CGRectZero];
    }
    typeCell.textLabel.text = [editingSize valueForKey:@"Type"];
    
	self.PopulatePickerArrays;
	
	sizePicker.delegate = nil;
	sizePicker.delegate = self;
	
	[sizePicker reloadAllComponents];
	
	switch (sizePicker.numberOfComponents) {
		case 1:
			[sizePicker selectRow:0 inComponent:compOne animated:YES];
			break;
		case 2:
			[sizePicker selectRow:0 inComponent:compOne animated:YES];
			[sizePicker selectRow:0 inComponent:compTwo animated:YES];
			break;
		case 3:
			[sizePicker selectRow:0 inComponent:compOne animated:YES];
			[sizePicker selectRow:0 inComponent:compTwo animated:YES];
			[sizePicker selectRow:0 inComponent:compThree animated:YES];
			break;
		case 4:
			[sizePicker selectRow:0 inComponent:compOne animated:YES];
			[sizePicker selectRow:0 inComponent:compTwo animated:YES];
			[sizePicker selectRow:0 inComponent:compThree animated:YES];
			[sizePicker selectRow:0 inComponent:compFour animated:YES];
			break;
		default:
			break;
	}
	
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
	[componentOne release];
	[componentTwo release];
	[componentThree release];
	[componentFour release];
	[sizePicker release];
    [super dealloc];
}

#pragma mark -
#pragma mark Picker Data Source Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	
	if ([typeCell.textLabel.text isEqualToString:@"Select Clothing Type"]) {
		
		return 1;
	} 
	else if ([typeCell.textLabel.text isEqualToString:@"Belt"] ||
		     [typeCell.textLabel.text isEqualToString:@"Brassiere"] ||
		     [typeCell.textLabel.text isEqualToString:@"Dress Shirt"] ||
		     [typeCell.textLabel.text isEqualToString:@"Hat"] ||
		     [typeCell.textLabel.text isEqualToString:@"Shirt"] ||
		     [typeCell.textLabel.text isEqualToString:@"Shoes"]) {
		
		return 3;
	}
	else if ([typeCell.textLabel.text isEqualToString:@"Dress"] ||
			 [typeCell.textLabel.text isEqualToString:@"Jacket"] ||
			 [typeCell.textLabel.text isEqualToString:@"Other"] ||
			 [typeCell.textLabel.text isEqualToString:@"Pants"] ||
			 [typeCell.textLabel.text isEqualToString:@"Skirt"] ||
			 [typeCell.textLabel.text isEqualToString:@"T-Shirt"] ||
			 [typeCell.textLabel.text isEqualToString:@"Underwear"]) {
		
		return 4;
	}
	else if (![typeCell.textLabel.text isEqualToString:@"Belt"] &&
			  ![typeCell.textLabel.text isEqualToString:@"Brassiere"] &&
			  ![typeCell.textLabel.text isEqualToString:@"Dress"] &&
			  ![typeCell.textLabel.text isEqualToString:@"Dress Shirt"] &&
			  ![typeCell.textLabel.text isEqualToString:@"Hat"] &&
			  ![typeCell.textLabel.text isEqualToString:@"Jacket"] &&
			  ![typeCell.textLabel.text isEqualToString:@"Pants"] &&
			  ![typeCell.textLabel.text isEqualToString:@"Shirt"] &&
			  ![typeCell.textLabel.text isEqualToString:@"Shoes"] &&
			  ![typeCell.textLabel.text isEqualToString:@"Skirt"] &&
			  ![typeCell.textLabel.text isEqualToString:@"T-Shirt"] &&
			  ![typeCell.textLabel.text isEqualToString:@"Underwear"]) {
		
		return 4;
	}
	else {
		
		return 1;
	}
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component 
{
	
	if (component == compOne)
		return [self.componentOne count];
	
	if (component == compTwo)
		return [self.componentTwo count];
	
	if (component == compThree)
		return [self.componentThree count];
	
	return [self.componentFour count];
}

#pragma mark Picker Delegate Methods

- (NSString *)pickerView:(UIPickerView *)pickerView
			 titleForRow:(NSInteger)row
			forComponent:(NSInteger)component
{
	
	if (component == compOne)
		return [self.componentOne objectAtIndex:row];
	
	if (component == compTwo)
		return [self.componentTwo objectAtIndex:row];
	
	if (component == compThree)
		return [self.componentThree objectAtIndex:row];
	
	return [self.componentFour objectAtIndex:row];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
	
	if ([typeCell.textLabel.text isEqualToString:@"Select Clothing Type"]) {
		
		return 300;
	} else if ([typeCell.textLabel.text isEqualToString:@"Belt"]) {
		
		switch (component) {
			case compOne:
				return 100;
				break;
			case compTwo:
				return 55;
				break;
			case compThree:
				return 100;
				break;
			default:
				break;
		}
	} else if ([typeCell.textLabel.text isEqualToString:@"Brassiere"]) {
		
		switch (component) {
			case compOne:
				return 60;
				break;
			case compTwo:
				return 55;
				break;
			case compThree:
				return 55;
				break;
			default:
				break;
		}
	} else if ([typeCell.textLabel.text isEqualToString:@"Dress"]) {
		
		switch (component) {
			case compOne:
				return 100;
				break;
			case compTwo:
				return 100;
				break;
			case compThree:
				return 55;
				break;
			case compFour:
				return 50;
			default:
				break;
		}
	} else if ([typeCell.textLabel.text isEqualToString:@"Dress Shirt"]) {
		
		switch (component) {
			case compOne:
				return 55;
				break;
			case compTwo:
				return 130;
				break;
			case compThree:
				return 110;
				break;
			default:
				break;
		}
	} else if ([typeCell.textLabel.text isEqualToString:@"Hat"]) { 
	
		switch (component) {
			case compOne:
				return 100;
				break;
			case compTwo:
				return 60;
				break;
			case compThree:
				return 75;
				break;
			default:
				break;
		}
	} else if ([typeCell.textLabel.text isEqualToString:@"Jacket"]) {
		
		switch (component) {
			case compOne:
				return 96;
				break;
			case compTwo:
				return 60;
				break;
			case compThree:
				return 60;
				break;
			case compFour:
				return 68;
			default:
				break;
		}
	} else if ([typeCell.textLabel.text isEqualToString:@"Pants"]) {
		
		switch (component) {
			case compOne:
				return 60;
				break;
			case compTwo:
				return 80;
				break;
			case compThree:
				return 90;
				break;
			case compFour:
				return 65;
				break;
			default:
				break;
		}
	} else if ([typeCell.textLabel.text isEqualToString:@"Other"]) {
							  
		switch (component) {
			case compOne:
				return 100;
				break;
			case compTwo:
				return 100;
				break;
			case compThree:
				return 55;
				break;
			case compFour:
				return 50;
			default:
				break;
		}
	} else if ([typeCell.textLabel.text isEqualToString:@"Shirt"]) {
		
		switch (component) {
			case compOne:
				return 150;
				break;
			case compTwo:
				return 60;
				break;
			case compThree:
				return 55;
				break;
			default:
				break;
		}
	} else if ([typeCell.textLabel.text isEqualToString:@"Shoes"]) {
		
		switch (component) {
			case compOne:
				return 100;
				break;
			case compTwo:
				return 55;
				break;
			case compThree:
				return 55;
				break;
			default:
				break;
		}
	} else if ([typeCell.textLabel.text isEqualToString:@"Skirt"]) {
		
		switch (component) {
			case compOne:
				return 100;
				break;
			case compTwo:
				return 60;
				break;
			case compThree:
				return 73;
				break;
			case compFour:
				return 58;
			default:
				break;
		}
	} else if ([typeCell.textLabel.text isEqualToString:@"T-Shirt"]) {
		
		switch (component) {
			case compOne:
				return 90;
				break;
			case compTwo:
				return 65;
				break;
			case compThree:
				return 73;
				break;
			case compFour:
				return 73;
			default:
				break;
		}
	} else if ([typeCell.textLabel.text isEqualToString:@"Underwear"]) {
		
		switch (component) {
			case compOne:
				return 60;
				break;
			case compTwo:
				return 70;
				break;
			case compThree:
				return 45;
				break;
			case compFour:
				return 60;
			default:
				break;
		}
	} else if (![typeCell.textLabel.text isEqualToString:@"Belt"] &&
				![typeCell.textLabel.text isEqualToString:@"Brassiere"] &&
				![typeCell.textLabel.text isEqualToString:@"Dress"] &&
				![typeCell.textLabel.text isEqualToString:@"Dress Shirt"] &&
				![typeCell.textLabel.text isEqualToString:@"Hat"] &&
				![typeCell.textLabel.text isEqualToString:@"Jacket"] &&
				![typeCell.textLabel.text isEqualToString:@"Pants"] &&
				![typeCell.textLabel.text isEqualToString:@"Shirt"] &&
				![typeCell.textLabel.text isEqualToString:@"Shoes"] &&
				![typeCell.textLabel.text isEqualToString:@"Skirt"] &&
				![typeCell.textLabel.text isEqualToString:@"T-Shirt"] &&
				![typeCell.textLabel.text isEqualToString:@"Underwear"]) {
		
		switch (component) {
			case compOne:
				return 100;
				break;
			case compTwo:
				return 95;
				break;
			case compThree:
				return 55;
				break;
			case compFour:
				return 50;
			default:
				break;
		}
	} 
		
	return 300;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	
	NSMutableString *compOneItem = [self.componentOne objectAtIndex:[sizePicker selectedRowInComponent:compOne]];
	NSMutableString *compTwoItem = [self.componentTwo objectAtIndex:[sizePicker selectedRowInComponent:compTwo]];
	
	if ([typeCell.textLabel.text isEqualToString:@"Belt"]) {
		if (component == compOne) {
			if ([compOneItem isEqualToString:@"Women"] == YES) {
				
				self.componentTwo = [NSArray arrayWithArray:[sizes objectForKey:@"Belt-2-Women"]];
				self.componentThree = [NSArray arrayWithArray:[sizes objectForKey:@"Belt-3-Women"]];
			} else if ([compOneItem isEqualToString:@"Men"] == YES) {
				
				self.componentTwo = [NSArray arrayWithArray:[sizes objectForKey:@"Belt-2-Men"]];
				self.componentThree = [NSArray arrayWithArray:[sizes objectForKey:@"Belt-3-Men"]];				
			} else if ([compOneItem isEqualToString:@"Girls"] == YES ||
					   [compOneItem isEqualToString:@"Boys"] == YES ||
					   [compOneItem isEqualToString:@"Toddlers"] == YES) {
				
				self.componentTwo = [NSArray arrayWithArray:[sizes objectForKey:@"Belt-2-Other"]];
				self.componentThree = [NSArray arrayWithArray:[sizes objectForKey:@"Belt-3-Small"]];
			}
			
			[sizePicker selectRow:0 inComponent:compTwo animated:YES];
			[sizePicker reloadComponent:compTwo];
			
			[sizePicker selectRow:0 inComponent:compThree animated:YES];
			[sizePicker reloadComponent:compThree];
		}
		
		if (component == compTwo && ([compOneItem isEqualToString:@"Girls"] == YES ||
									 [compOneItem isEqualToString:@"Boys"] == YES ||
									 [compOneItem isEqualToString:@"Toddlers"] == YES)) {
			
			if ([compTwoItem isEqualToString:@"S"] == YES) {
				
				self.componentThree = [NSArray arrayWithArray:[sizes objectForKey:@"Belt-3-Small"]];
			} else if ([compTwoItem isEqualToString:@"M"] == YES) {
				
				self.componentThree = [NSArray arrayWithArray:[sizes objectForKey:@"Belt-3-Medium"]];				
			} else if ([compTwoItem isEqualToString:@"L"] == YES) {
				
				self.componentThree = [NSArray arrayWithArray:[sizes objectForKey:@"Belt-3-Large"]];
			}
			
			[sizePicker selectRow:0 inComponent:compThree animated:YES];
			[sizePicker reloadComponent:compThree];
		}
	}
	
	if ([typeCell.textLabel.text isEqualToString:@"Dress"]) {
		if (component ==compOne) {
			if ([compOneItem isEqualToString:@"Women"] == YES) {
				
				self.componentTwo = [NSArray arrayWithArray:[sizes objectForKey:@"Dress-2-Women"]];
				self.componentThree = [NSArray arrayWithArray:[sizes objectForKey:@"Dress-3-Women"]];
				self.componentFour = [NSArray arrayWithArray:[sizes objectForKey:@"Dress-4-Women"]];
			} else if ([compOneItem isEqualToString:@"Girls"] == YES) {
				
				self.componentTwo = [NSArray arrayWithArray:[sizes objectForKey:@"Dress-2-Girls"]];
				self.componentThree = [NSArray arrayWithArray:[sizes objectForKey:@"Dress-3-Girls"]];
				self.componentFour = [NSArray arrayWithArray:[sizes objectForKey:@"Dress-4-Girls"]];				
			} else if ([compOneItem isEqualToString:@"Jr. Girls"] == YES) {
				
				self.componentTwo = [NSArray arrayWithArray:[sizes objectForKey:@"Dress-2-JrGirls"]];
				self.componentThree = [NSArray arrayWithArray:[sizes objectForKey:@"Dress-3-JrGirls"]];
				self.componentFour = [NSArray arrayWithArray:[sizes objectForKey:@"Dress-4-JrGirls"]];				
			} 
			
			[sizePicker selectRow:0 inComponent:compTwo animated:YES];
			[sizePicker reloadComponent:compTwo];
			
			[sizePicker selectRow:0 inComponent:compThree animated:YES];
			[sizePicker reloadComponent:compThree];
			
			[sizePicker selectRow:0 inComponent:compFour animated:YES];
			[sizePicker reloadComponent:compFour];
		}
	}
	
	if ([typeCell.textLabel.text isEqualToString:@"Hat"]) {
		if (component == compOne) {
			if ([compOneItem isEqualToString:@"Adults"] == YES) {
				
				self.componentTwo = [NSArray arrayWithArray:[sizes objectForKey:@"Hat-2-Adults"]];
				self.componentThree = [NSArray arrayWithArray:[sizes objectForKey:@"Hat-3-Adults"]];
			}
			
			if ([compOneItem isEqualToString:@"Kids"] == YES) {
				
				self.componentTwo = [NSArray arrayWithArray:[sizes objectForKey:@"Hat-2-Kids"]];
				self.componentThree = [NSArray arrayWithArray:[sizes objectForKey:@"Hat-3-Kids"]];
			}
			
			[sizePicker selectRow:0 inComponent:compTwo animated:YES];
			[sizePicker reloadComponent:compTwo];
			
			[sizePicker selectRow:0 inComponent:compThree animated:YES];
			[sizePicker reloadComponent:compThree];
		}
	}
	
	if ([typeCell.textLabel.text isEqualToString:@"Shoes"]) {
		if (component == compOne) {
			
			if ([compOneItem isEqualToString:@"Women"] == YES) {
				
				self.componentThree = [NSArray arrayWithArray:[sizes objectForKey:@"Shoes-3-Women"]];
			} else if ([compOneItem isEqualToString:@"Men"] == YES) {
				
				self.componentThree = [NSArray arrayWithArray:[sizes objectForKey:@"Shoes-3-Men"]];
			} else if ([compOneItem isEqualToString:@"Girls"] == YES) {
				
				self.componentThree = [NSArray arrayWithArray:[sizes objectForKey:@"Shoes-3-Girls"]];
			} else if ([compOneItem isEqualToString:@"Boys"] == YES) {
				
				self.componentThree = [NSArray arrayWithArray:[sizes objectForKey:@"Shoes-3-Boys"]];
			} else if ([compOneItem isEqualToString:@"Kids"] == YES) {
				
				self.componentThree = [NSArray arrayWithArray:[sizes objectForKey:@"Shoes-3-Kids"]];
			} else if ([compOneItem isEqualToString:@"Toddlers"] == YES) {
				
				self.componentThree = [NSArray arrayWithArray:[sizes objectForKey:@"Shoes-3-Toddlers"]];
			} else if ([compOneItem isEqualToString:@"Infants"] == YES) {
				
				self.componentThree = [NSArray arrayWithArray:[sizes objectForKey:@"Shoes-3-Infants"]];
			}
			
			[sizePicker selectRow:0 inComponent:compThree animated:YES];
			[sizePicker reloadComponent:compThree];
		}
	}
	
	if (![typeCell.textLabel.text isEqualToString:@"Belt"] &&
		![typeCell.textLabel.text isEqualToString:@"Brassiere"] &&
		![typeCell.textLabel.text isEqualToString:@"Dress"] &&
		![typeCell.textLabel.text isEqualToString:@"Dress Shirt"] &&
		![typeCell.textLabel.text isEqualToString:@"Hat"] &&
		![typeCell.textLabel.text isEqualToString:@"Jacket"] &&
		![typeCell.textLabel.text isEqualToString:@"Pants"] &&
		![typeCell.textLabel.text isEqualToString:@"Shirt"] &&
		![typeCell.textLabel.text isEqualToString:@"Shoes"] &&
		![typeCell.textLabel.text isEqualToString:@"Skirt"] &&
		![typeCell.textLabel.text isEqualToString:@"T-Shirt"] &&
		![typeCell.textLabel.text isEqualToString:@"Underwear"]) {
		
		if (component == compOne) {
			if ([compOneItem isEqualToString:@"Women"] == YES) {
				
				self.componentTwo = [NSArray arrayWithArray:[sizes objectForKey:@"Other-2-Women"]];
				self.componentThree = [NSArray arrayWithArray:[sizes objectForKey:@"Other-3-Women"]];
				self.componentFour = [NSArray arrayWithArray:[sizes objectForKey:@"Other-4-Women"]];
			} else if ([compOneItem isEqualToString:@"Men"] == YES) {
				
				self.componentTwo = [NSArray arrayWithArray:[sizes objectForKey:@"Other-2-Men"]];
				self.componentThree = [NSArray arrayWithArray:[sizes objectForKey:@"Other-3-Men"]];
				self.componentFour = [NSArray arrayWithArray:[sizes objectForKey:@"Other-4-Men"]];				
			} else if ([compOneItem isEqualToString:@"Girls"] == YES) {
				
				self.componentTwo = [NSArray arrayWithArray:[sizes objectForKey:@"Other-2-Girls"]];
				self.componentThree = [NSArray arrayWithArray:[sizes objectForKey:@"Other-3-Girls"]];
				self.componentFour = [NSArray arrayWithArray:[sizes objectForKey:@"Other-4-Girls"]];				
			} else if ([compOneItem isEqualToString:@"Boys"] == YES) {
				
				self.componentTwo = [NSArray arrayWithArray:[sizes objectForKey:@"Other-2-Boys"]];
				self.componentThree = [NSArray arrayWithArray:[sizes objectForKey:@"Other-3-Boys"]];
				self.componentFour = [NSArray arrayWithArray:[sizes objectForKey:@"Other-4-Boys"]];				
			} else if ([compOneItem isEqualToString:@"Jr. Girls"] == YES) {
				
				self.componentTwo = [NSArray arrayWithArray:[sizes objectForKey:@"Other-2-JrGirls"]];
				self.componentThree = [NSArray arrayWithArray:[sizes objectForKey:@"Other-3-JrGirls"]];
				self.componentFour = [NSArray arrayWithArray:[sizes objectForKey:@"Other-4-JrGirls"]];				
			} else if ([compOneItem isEqualToString:@"Jr. Boys"] == YES) {
				
				self.componentTwo = [NSArray arrayWithArray:[sizes objectForKey:@"Other-2-JrBoys"]];
				self.componentThree = [NSArray arrayWithArray:[sizes objectForKey:@"Other-3-JrBoys"]];
				self.componentFour = [NSArray arrayWithArray:[sizes objectForKey:@"Other-4-JrBoys"]];				
			} else if ([compOneItem isEqualToString:@"Infants"] == YES) {
				
				self.componentTwo = [NSArray arrayWithArray:[sizes objectForKey:@"Other-2-Infants"]];
				self.componentThree = [NSArray arrayWithArray:[sizes objectForKey:@"Other-3-Infants"]];
				self.componentFour = [NSArray arrayWithArray:[sizes objectForKey:@"Empty-0"]];				
			} else if ([compOneItem isEqualToString:@"Toddlers"] == YES) {
				
				self.componentTwo = [NSArray arrayWithArray:[sizes objectForKey:@"Other-2-Toddlers"]];
				self.componentThree = [NSArray arrayWithArray:[sizes objectForKey:@"Other-3-Toddlers"]];
				self.componentFour = [NSArray arrayWithArray:[sizes objectForKey:@"Empty-0"]];				
			}
			
			[sizePicker selectRow:0 inComponent:compTwo animated:YES];
			[sizePicker reloadComponent:compTwo];
			
			[sizePicker selectRow:0 inComponent:compThree animated:YES];
			[sizePicker reloadComponent:compThree];
			
			[sizePicker selectRow:0 inComponent:compFour animated:YES];
			[sizePicker reloadComponent:compFour];
		}
	}
	
	
}

#pragma mark -
#pragma mark TableView Data Source Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
	
    return 1; 
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
	
	return 1;
}

#ifndef __IPHONE_3_0
- (UITableViewCellAccessoryType)tableView:(UITableView *)aTableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath {
    
	return UITableViewCellAccessoryDisclosureIndicator;
}
#endif

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	#ifdef __IPHONE_3_0
	typeCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	#endif
	return typeCell;
}

#pragma mark -
#pragma mark TableView Delegate Methods

- (NSIndexPath *)tableView:(UITableView *)aTableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
    if (indexPath.section == 0) {
        if (!personEditSizeTypeController) {
            PersonEditSizeTypeController *controller = [[PersonEditSizeTypeController alloc] initWithNibName:@"PersonEditSizeTypeView" bundle:nil];
            self.personEditSizeTypeController = controller;
            [controller release];
        }
		
		personEditSizeTypeController.types = clothingTypes;
        personEditSizeTypeController.editingItem = editingSize;
        [editingSize setValue:typeCell.textLabel.text forKey:@"Type"];
        [self.navigationController pushViewController:personEditSizeTypeController animated:YES];
    }
    return indexPath;
}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [aTableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 
#pragma mark Custom Picker Columns

- (void) PopulatePickerArrays {
	
	self.componentOne = [[NSMutableArray alloc] init]; // ???
	
	NSString *selection = typeCell.textLabel.text;
	
	if ([selection isEqualToString:@"Belt"] ||
		[selection isEqualToString:@"Brassiere"] ||
		[selection isEqualToString:@"Dress Shirt"] ||
		[selection isEqualToString:@"Hat"] ||
		[selection isEqualToString:@"Shirt"] ||
		[selection isEqualToString:@"Shoes"]) {
		
		if ([selection isEqualToString:@"Belt"]) {
			self.componentOne = [NSArray arrayWithArray:[sizes objectForKey:@"Belt-1"]];
			self.componentTwo = [NSArray arrayWithArray:[sizes objectForKey:@"Belt-2-Women"]];
			self.componentThree = [NSArray arrayWithArray:[sizes objectForKey:@"Belt-3-Women"]];
		}
		
		if ([selection isEqualToString:@"Brassiere"]) {
			self.componentOne = [NSArray arrayWithArray:[sizes objectForKey:@"Brassiere-1"]];
			self.componentTwo = [NSArray arrayWithArray:[sizes objectForKey:@"Brassiere-2"]];
			self.componentThree = [NSArray arrayWithArray:[sizes objectForKey:@"Brassiere-3"]];
		}
		
		if ([selection isEqualToString:@"Dress Shirt"]) {
			self.componentOne = [NSArray arrayWithArray:[sizes objectForKey:@"Dress Shirt-1"]];
			self.componentTwo = [NSArray arrayWithArray:[sizes objectForKey:@"Dress Shirt-2"]];
			self.componentThree = [NSArray arrayWithArray:[sizes objectForKey:@"Dress Shirt-3"]];
		}
		
		if ([selection isEqualToString:@"Hat"]) {
			self.componentOne = [NSArray arrayWithArray:[sizes objectForKey:@"Hat-1"]];
			self.componentTwo = [NSArray arrayWithArray:[sizes objectForKey:@"Hat-2-Adults"]];
			self.componentThree = [NSArray arrayWithArray:[sizes objectForKey:@"Hat-3-Adults"]];
		}
		
		if ([selection isEqualToString:@"Shirt"]) {
			self.componentOne = [NSArray arrayWithArray:[sizes objectForKey:@"Shirt-1"]];
			self.componentTwo = [NSArray arrayWithArray:[sizes objectForKey:@"Shirt-2"]];
			self.componentThree = [NSArray arrayWithArray:[sizes objectForKey:@"Shirt-3"]];
		}
		
		if ([selection isEqualToString:@"Shoes"]) {
			self.componentOne = [NSArray arrayWithArray:[sizes objectForKey:@"Shoes-1"]];
			self.componentTwo = [NSArray arrayWithArray:[sizes objectForKey:@"Shoes-2"]];
			self.componentThree = [NSArray arrayWithArray:[sizes objectForKey:@"Shoes-3-Women"]];
		}
	} else if ([selection isEqualToString:@"Dress"] ||
			   [selection isEqualToString:@"Jacket"] ||
			   [selection isEqualToString:@"Other"] ||
			   [selection isEqualToString:@"Pants"] ||
			   [selection isEqualToString:@"Skirt"] ||
			   [selection isEqualToString:@"T-Shirt"] ||
			   [selection isEqualToString:@"Underwear"]) {
		
		if ([selection isEqualToString:@"Dress"]) {
			self.componentOne = [NSArray arrayWithArray:[sizes objectForKey:@"Dress-1"]];
			self.componentTwo = [NSArray arrayWithArray:[sizes objectForKey:@"Dress-2-Women"]];
			self.componentThree = [NSArray arrayWithArray:[sizes objectForKey:@"Dress-3-Women"]];
			self.componentFour = [NSArray arrayWithArray:[sizes objectForKey:@"Dress-4-Women"]];
		}
		
		if ([selection isEqualToString:@"Jacket"]) {
			self.componentOne = [NSArray arrayWithArray:[sizes objectForKey:@"Jacket-1"]];
			self.componentTwo = [NSArray arrayWithArray:[sizes objectForKey:@"Jacket-2"]];
			self.componentThree = [NSArray arrayWithArray:[sizes objectForKey:@"Jacket-3"]];
			self.componentFour = [NSArray arrayWithArray:[sizes objectForKey:@"Jacket-4"]];
		}
		
		if ([selection isEqualToString:@"Other"]) {
			self.componentOne = [NSArray arrayWithArray:[sizes objectForKey:@"Other-1"]];
			self.componentTwo = [NSArray arrayWithArray:[sizes objectForKey:@"Other-2-Women"]];
			self.componentThree = [NSArray arrayWithArray:[sizes objectForKey:@"Other-3-Women"]];
			self.componentFour = [NSArray arrayWithArray:[sizes objectForKey:@"Other-4-Women"]];
		}
		
		if ([selection isEqualToString:@"Pants"]) {
			self.componentOne = [NSArray arrayWithArray:[sizes objectForKey:@"Pants-1"]];
			self.componentTwo = [NSArray arrayWithArray:[sizes objectForKey:@"Pants-2"]];
			self.componentThree = [NSArray arrayWithArray:[sizes objectForKey:@"Pants-3"]];
			self.componentFour = [NSArray arrayWithArray:[sizes objectForKey:@"Pants-4"]];
		}
		
		if ([selection isEqualToString:@"Skirt"]) {
			self.componentOne = [NSArray arrayWithArray:[sizes objectForKey:@"Skirt-1"]];
			self.componentTwo = [NSArray arrayWithArray:[sizes objectForKey:@"Skirt-2"]];
			self.componentThree = [NSArray arrayWithArray:[sizes objectForKey:@"Skirt-3"]];
			self.componentFour = [NSArray arrayWithArray:[sizes objectForKey:@"Skirt-4"]];
		}
		
		if ([selection isEqualToString:@"T-Shirt"]) {
			self.componentOne = [NSArray arrayWithArray:[sizes objectForKey:@"T-Shirt-1"]];
			self.componentTwo = [NSArray arrayWithArray:[sizes objectForKey:@"T-Shirt-2"]];
			self.componentThree = [NSArray arrayWithArray:[sizes objectForKey:@"T-Shirt-3"]];
			self.componentFour = [NSArray arrayWithArray:[sizes objectForKey:@"T-Shirt-5"]];			
		}
		
		if ([selection isEqualToString:@"Underwear"]) {
			self.componentOne = [NSArray arrayWithArray:[sizes objectForKey:@"Underwear-1"]];
			self.componentTwo = [NSArray arrayWithArray:[sizes objectForKey:@"Underwear-2"]];
			self.componentThree = [NSArray arrayWithArray:[sizes objectForKey:@"Underwear-3"]];
			self.componentFour = [NSArray arrayWithArray:[sizes objectForKey:@"Underwear-4"]];
		}
	} else {
		
		if ([selection isEqualToString:@"Select Clothing Type"]) {
			self.componentOne = [NSArray arrayWithArray:[sizes objectForKey:@"Empty-0"]];
			//self.componentTwo = [NSArray arrayWithArray:[sizes objectForKey:@"Empty-0"]];
			//self.componentThree = [NSArray arrayWithArray:[sizes objectForKey:@"Empty-0"]];
			//self.componentFour = [NSArray arrayWithArray:[sizes objectForKey:@"Empty-0"]];
			
		} else {
			self.componentOne = [NSArray arrayWithArray:[sizes objectForKey:@"Other-1"]];
			self.componentTwo = [NSArray arrayWithArray:[sizes objectForKey:@"Other-2-Women"]];
			self.componentThree = [NSArray arrayWithArray:[sizes objectForKey:@"Other-3-Women"]];
			self.componentFour = [NSArray arrayWithArray:[sizes objectForKey:@"Other-4-Women"]];
		}
	}

	//[selection release];
}

@end
