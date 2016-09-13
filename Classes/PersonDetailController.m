//
//  PersonDetailController.m
//  QuickGifter
//
//  Created by Bill Maya on 5/10/09.
//  Copyright 2009 Wampum & Womantam Creations. All rights reserved.
//

#import "PersonDetailController.h"
#import "PersonDetailCell.h"
#import "PersonDetailGiftCell.h"

@implementation PersonDetailController

@synthesize person, details, tableView;
@synthesize personEditDateController;
@synthesize personEditSizeController;
@synthesize personEditGiftController;
@synthesize personEditLikeController;
@synthesize personEditPlaceController;

- (IBAction)edit:(id)sender
{
	PersonEditDateController *childController = [[PersonEditDateController alloc]
											initWithNibName:@"PersonEditDateView" bundle:nil];
	
	[[self navigationController] pushViewController:childController animated:YES];
	[childController release];
}

// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}


/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

#pragma mark -
#pragma mark UIViewController Methods

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	self.title = [self.person objectForKey:@"fullname"];
	self.details = [self.person objectForKey:@"info"];
	
    // Display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
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
#pragma mark Table View Data Source Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return [details count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	
	// The number of rows in each section depends on the number of sub-items in each item in the data property list. 
    NSInteger count = [[[details objectAtIndex:section] valueForKeyPath:@"content.@count"] intValue];
    if (self.editing) count++; // If we're in editing mode, we add a placeholder row for creating new items.
	
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

	PersonDetailGiftCell *cell = (PersonDetailGiftCell *)[tableView dequeueReusableCellWithIdentifier:@"PersonDetailGiftCell"];
	if (cell == nil) {
        cell = [[[PersonDetailGiftCell alloc] initWithFrame:CGRectZero] autorelease];
		cell.editingAccessoryType = UITableViewCellAccessoryNone;
	}
	 
    // The DetailCell has two modes of display - either a type/name pair or a prompt for creating a new item of a type
    // The type derives from the section, the name from the item.
    NSDictionary *section = [details objectAtIndex:indexPath.section];
    if (section) {
        NSArray *content = [section valueForKey:@"content"];
        if (content && indexPath.row < [content count]) {
            NSDictionary *item = (NSDictionary *)[content objectAtIndex:indexPath.row];
            cell.type.text = [item valueForKey:@"Type"];
            cell.name.text = [item valueForKey:@"Name"];
            cell.promptMode = NO;
        } else {
            cell.prompt.text = [NSString stringWithFormat:@"Add new %@", [section valueForKey:@"name"]];
            cell.promptMode = YES;
        }
    } else {
        cell.type.text = @"";
        cell.name.text = @"";
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	return 50;
} 

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	return [[details objectAtIndex:section] objectForKey:@"name"];
}

/*
 // The accessory view is on the right side of each cell. We'll use a "disclosure" indicator in editing mode,
 // to indicate to the user that selecting the row will navigate to a new view where details can be edited.
 - (UITableViewCellAccessoryType)tableView:(UITableView *)aTableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath {
 return (self.editing) ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
 }
 */

// The editing style for a row is the kind of button displayed to the left of the cell when in editing mode.
- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	// No editing style if not editing or the index path is nil.
    if (self.editing == NO || !indexPath) return UITableViewCellEditingStyleNone;
    // Determine the editing style based on whether the cell is a placeholder for adding content or already 
    // existing content. Existing content can be deleted.
    NSDictionary *section = [details objectAtIndex:indexPath.section];
    if (section) {
        NSArray *content = [section valueForKey:@"content"];
        if (content) {
            if (indexPath.row >= [content count]) {
                return UITableViewCellEditingStyleInsert;
            } else {
                return UITableViewCellEditingStyleDelete;
            }
        }
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
        NSDictionary *section = [details objectAtIndex:indexPath.section];
        if (section) {
            // Make a local reference to the editing view controller.
            PersonEditDateController *controller = self.personEditDateController;
            // Pass the item being edited to the editing controller.
            NSMutableArray *content = [section valueForKey:@"content"];
            if (content && indexPath.row < [content count]) {
                // The row selected is one with existing content, so that content will be edited.
            } else {
                // The row selected is a placeholder for adding content. The editor should create a new item.
            }
            // Additional information for the editing controller.
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
	
    // Calculate the index paths for all of the placeholder rows based on the number of items in each section.
    NSArray *indexPaths = [NSArray arrayWithObjects:
		[NSIndexPath indexPathForRow:[[[details objectAtIndex:0] valueForKeyPath:@"content.@count"] intValue] inSection:0],
		[NSIndexPath indexPathForRow:[[[details objectAtIndex:1] valueForKeyPath:@"content.@count"] intValue] inSection:1],
		[NSIndexPath indexPathForRow:[[[details objectAtIndex:2] valueForKeyPath:@"content.@count"] intValue] inSection:2], 
		[NSIndexPath indexPathForRow:[[[details objectAtIndex:3] valueForKeyPath:@"content.@count"] intValue] inSection:3], 
		[NSIndexPath indexPathForRow:[[[details objectAtIndex:4] valueForKeyPath:@"content.@count"] intValue] inSection:4], nil];
	
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
        NSDictionary *section = [details objectAtIndex:indexPath.section];
        if (section) {
            NSMutableArray *content = [section valueForKey:@"content"];
            if (content && indexPath.row < [content count]) {
                [content removeObjectAtIndex:indexPath.row];
            }
        }
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
		
        NSDictionary *section = [details objectAtIndex:indexPath.section];
        if (section) {
			
			NSString *name = [section valueForKey:@"name"];
			if ([name isEqualToString:@"Important Dates"]) {
				PersonEditDateController *controller = self.personEditDateController; // Make a local reference to the editing view controller.
				
				controller.editingItem = nil; // A "nil" indicates create a new item.
				NSMutableArray *content = [section valueForKey:@"content"];
				controller.editingContent = content; // group to which new item should be added.
				controller.sectionName = [section valueForKey:@"name"];
				
				[self.navigationController pushViewController:controller animated:YES];
			} else if ([name isEqualToString:@"Sizes"]) {
				PersonEditSizeController *controller = self.personEditSizeController;
				
				controller.editingSize = nil;
				NSMutableArray *content = [section valueForKey:@"content"];
				controller.editingContent = content;
				controller.sectionName = [section valueForKey:@"name"];
				
				[self.navigationController pushViewController:controller animated:YES];
			} else if ([name isEqualToString:@"Likes"]) {
				PersonEditLikeController *controller = self.personEditLikeController;
				
				controller.editingLike = nil;
				NSMutableArray *content = [section valueForKey:@"content"];
				controller.editingContent = content;
				
				[self.navigationController pushViewController:controller animated:YES];
			} else if ([name isEqualToString:@"Gift Ideas"]) {
				PersonEditGiftController *controller = self.personEditGiftController;
				
				controller.editingName = nil;
				NSMutableArray *content = [section valueForKey:@"content"];
				controller.editingContent = content; 
				
				[self.navigationController pushViewController:controller animated:YES];
			} else { // Fav Places
				PersonEditPlaceController *controller = self.personEditPlaceController;
				
				controller.editingPlace = nil;
				NSMutableArray *content = [section valueForKey:@"content"];
				controller.editingContent = content;
				
				[self.navigationController pushViewController:controller animated:YES];
			}
        }
    }
}

#pragma mark -
#pragma mark Other UIViewControllers

- (PersonEditDateController *)personEditDateController {
    // Instantiate the editing view controller if necessary.
    if (personEditDateController == nil) {
        PersonEditDateController *controller = [[PersonEditDateController alloc] initWithNibName:@"PersonEditDateView" bundle:nil];
        self.personEditDateController = controller;
        [controller release];
    }
    return personEditDateController;
}

- (PersonEditSizeController *)personEditSizeController {
	if (personEditSizeController == nil) {
		PersonEditSizeController *controller = [[PersonEditSizeController alloc] initWithNibName:@"PersonEditSizeView" bundle:nil];
		self.personEditSizeController = controller;
		[controller release];
	}
	return personEditSizeController;
}

- (PersonEditGiftController *)personEditGiftController {
	if (personEditGiftController == nil) {
		PersonEditGiftController *controller = [[PersonEditGiftController alloc] initWithNibName:@"PersonEditGiftView" bundle:nil];
		self.personEditGiftController = controller;
		[controller release];
	}
	return personEditGiftController;
}

- (PersonEditLikeController *)personEditLikeController {
	if (personEditLikeController == nil) {
		PersonEditLikeController *controller = [[PersonEditLikeController alloc] initWithNibName:@"PersonEditLikeView" bundle:nil];
		self.personEditLikeController = controller;
		[controller release];
	}
	return personEditLikeController;
}

- (PersonEditPlaceController *)personEditPlaceController {
	if (personEditPlaceController == nil) {
		PersonEditPlaceController *controller = [[PersonEditPlaceController alloc] initWithNibName:@"PersonEditPlaceView" bundle:nil];
		self.personEditPlaceController = controller;
		[controller release];
	}
	return personEditPlaceController;
}

@end
