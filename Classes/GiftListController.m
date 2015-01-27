//
//  GiftListController.m
//  QuickGifter
//
//  Created by Bill Maya on 8/17/09.
//  Copyright 2009 Wampum & Womantam Creations. All rights reserved.
//

#import "QuickGifterAppDelegate.h"
#import "GiftListController.h"

#import "PersonDetailGiftCell.h"


@implementation GiftListController

@synthesize tableView, peopleGifts, peoples, gifts;
@synthesize peopleDetail;

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
	
	peopleDetail = ((QuickGifterAppDelegate *)[UIApplication sharedApplication].delegate).people;
	
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
	
	if (self.peopleGifts == nil) { // WJTM - 10.15.09 - added if/else
		self.peopleGifts = [[NSMutableDictionary alloc] init];
	} else {
		[self.peopleGifts removeAllObjects];
	}
	
	for (NSDictionary *person in peopleDetail) {
		NSString *fullname = [[person objectForKey:@"fullname"] copy]; // WJTM - 10.15.09 - added "copy]"
		NSMutableArray *personsGifts = [[NSMutableArray alloc] init]; // Array for person's gifts
		
		// Info array from individual dictionary entry in People.plist
		NSArray *info = [[NSArray arrayWithArray:[person objectForKey:@"info"]] copy]; // WJTM - 10.15.09 - added "copy]"
		for (NSDictionary *category in info) {
			NSString *name= [[category objectForKey:@"name"] copy]; // WJTM - 10.15.09 - added "copy]"
			if ([name isEqualToString: @"Gift Ideas"] == YES) {
				// Content array from individual gift category
				NSArray *content = [NSArray arrayWithArray:[category objectForKey:@"content"]]; 
				for (NSDictionary *giftItem in content) {
					[personsGifts addObject:[giftItem objectForKey:@"Name"]];
				}
				[peopleGifts setValue:personsGifts forKey:[fullname copy]]; // WJTM - 10.15.09 - added "copy]"
				[fullname release]; // WJTM - 10.15.09 - added
				
				break;
			}
			[name release]; // WJTM - 10.15.09 - added
		}
		[info release]; // WJTM - 10.15.09 - added
		[personsGifts release];
	}
	if ([peopleGifts count] != 0) {
		self.peoples = [[self.peopleGifts allKeys] sortedArrayUsingSelector:@selector(compare:)];
		self.gifts = [self.peopleGifts objectForKey:[self.peoples objectAtIndex:0]];
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
	[tableView release];
	[peopleGifts release];
	[peoples release];
	[gifts release];
    [super dealloc];
}

#pragma mark -
#pragma mark TableView Data Source Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
	
	NSInteger count = [self.peoples count];
    return count; 
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
	
    NSString *key = [self.peoples objectAtIndex:section];
	NSArray *gift = [self.peopleGifts objectForKey:key];
	NSInteger count = [gift count];
	return count;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	PersonDetailGiftCell *cell = (PersonDetailGiftCell *)[tableView dequeueReusableCellWithIdentifier:@"PersonEditDate"];
	if (cell == nil)
	{
		cell = [[[PersonDetailGiftCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"PersonEditDate"] autorelease];
	}
	
	NSString *key = [self.peoples objectAtIndex:indexPath.section];
	NSArray *gift = [self.peopleGifts objectForKey:key];
	
	cell.name.text = [gift objectAtIndex:indexPath.row];
	cell.type.text = @"";
	cell.prompt.text = @"";
	cell.promptMode = NO;
	
	return cell;
}
 
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	return [self.peoples objectAtIndex:section];
}

#pragma mark -
#pragma mark TableView Delegate Methods

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
