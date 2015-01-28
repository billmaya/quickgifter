//
//  SetupViewController.m
//  QuickGifter
//
//  Created by Bill Maya on 5/2/09.
//  Copyright 2009 Wampum & Womantam Creations. All rights reserved.
//

#import "QuickGifterAppDelegate.h"
#import "SetupViewController.h"
#import "SetupDetailController.h"
#import "SetupDetailPlacesController.h"

#define PeopleCategory 1
#define FavPlacesItem 2

@implementation SetupViewController

@synthesize details;
@synthesize favplaces;

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

#pragma mark -
#pragma mark UIViewController Methods

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
	self.title = @"Setup";

	self.details = ((QuickGifterAppDelegate *)[UIApplication sharedApplication].delegate).details;
	self.favplaces = ((QuickGifterAppDelegate *)[UIApplication sharedApplication].delegate).favplaces;
	
	UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Setup" style:UIBarButtonItemStylePlain target:nil action:nil];
	self.navigationItem.backBarButtonItem = backButton;
	[backButton release];
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

	NSInteger count = [[[details objectAtIndex:section] valueForKeyPath:@"content.@count"] intValue];
	return count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	
	return [[details objectAtIndex:section] objectForKey:@"name"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SectionsTableIdentifier"];
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"SectionsTableIdentifier"] autorelease];
	}
	
	NSDictionary *section = [details objectAtIndex:indexPath.section];
	if (section) {
		NSArray *content = [section valueForKey:@"content"];
		if (content) {
			NSDictionary *item = (NSDictionary *)[content objectAtIndex:indexPath.row];
			cell.textLabel.text = [item valueForKey:@"name"];
		}
	}
	
	return cell;
}

#pragma mark -
#pragma mark Table Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

	if (indexPath.section == PeopleCategory && indexPath.row == FavPlacesItem) {
		
		SetupDetailPlacesController *childController = [[SetupDetailPlacesController alloc]
														initWithNibName:@"SetupDetailPlacesView" bundle:nil];
		
		childController.caption = @"Fav Places";
		childController.categoryItems = favplaces;
		childController.categories = [[childController.categoryItems allKeys] sortedArrayUsingSelector:@selector(compare:)];
		
		[[self navigationController] pushViewController:childController animated:YES];
		[childController release];
	} else {
		NSDictionary *section = [details objectAtIndex:indexPath.section];
		if (section) {
			NSArray *content = [section valueForKey:@"content"];
			if (content) {
				NSDictionary *item = (NSDictionary *)[content objectAtIndex:indexPath.row];
				if (item) {
					NSMutableArray *items = [item objectForKey:@"items"];
				
					SetupDetailController *childController = [[SetupDetailController alloc]
																initWithNibName:@"SetupDetailView" bundle:nil];
				
					childController.caption = [item valueForKey:@"name"];
					childController.details = items;
				
					[[self navigationController] pushViewController:childController animated:YES];
					[childController release];
				}
			}
		}
	}
	
}

- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath {
	
	return UITableViewCellAccessoryDisclosureIndicator;
}

@end
