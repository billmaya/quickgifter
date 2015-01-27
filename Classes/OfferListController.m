//
//  OfferListController.m
//  QuickGifter
//
//  Created by Bill Maya on 8/25/09.
//  Copyright 2009 Wampum & Womantam Creations. All rights reserved.
//

#import "OfferListController.h"
#import "OfferDetailController.h"

#define kOfferTitleTag	1

@implementation OfferListController

@synthesize offers, tableView;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    
	NSString *offerText = @"Register to win!";  //@"Register to win a $50 iTunes gift card!";
	NSDictionary *offer1 = [[NSDictionary alloc] initWithObjectsAndKeys:offerText, @"Text", nil];
	NSArray *array = [[NSArray alloc] initWithObjects:offer1, nil];
	self.offers = array;
	
	[offerText release];
	[offer1 release];
	[array release];
	
	[super viewDidLoad];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

#pragma mark -
#pragma mark Table Data Source Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	return [self.offers count];
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *TopLevelCellIdentifier = @"Offer";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TopLevelCellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero] autorelease];
		
		CGRect offerTitleRect = CGRectMake(80, 10, 190, 70);
		UILabel *offerTitleLabel = [[UILabel alloc] initWithFrame:offerTitleRect];
		offerTitleLabel.font = [UIFont fontWithName:@"Helvetica" size:20.0];
		offerTitleLabel.numberOfLines = 2;
		offerTitleLabel.tag = kOfferTitleTag;
		[cell.contentView addSubview:offerTitleLabel];
		[offerTitleLabel release];
	}
	
	NSUInteger row = [indexPath row];
	NSDictionary *rowData = [self.offers objectAtIndex:row];
	
	UILabel *title = (UILabel *)[cell.contentView viewWithTag:kOfferTitleTag];
	title.text = [rowData objectForKey:@"Text"];
	
	//UIImage *offerImage = [UIImage imageNamed:@"present.jpg"];
	UIImage *offerImage = [UIImage imageNamed:@"62QG.png"];

	[[cell imageView] setImage:offerImage];
	//cell.textLabel.text = [rowData objectForKey:@"Text"];
	
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	return 88;
} 

/*- (UIImage *)scale:(UIImage *)image toSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext
	();
    UIGraphicsEndImageContext();
    return scaledImage;
	
}*/

#pragma mark -
#pragma mark Table Delegate Methods

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	OfferDetailController *childController = [[OfferDetailController alloc]
											  initWithNibName:@"OfferDetailView" bundle:nil];
	
	[[self navigationController] pushViewController:childController animated:YES];
	[childController release];
}

- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath {
	
	return UITableViewCellAccessoryDetailDisclosureButton;
}

- (void)tableView:(UITableView *)aTableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
	
	// How would you call didSelectRowAtIndexPath (lines 121-132) from here?
	
	OfferDetailController *childController = [[OfferDetailController alloc]
											  initWithNibName:@"OfferDetailView" bundle:nil];
	
	[[self navigationController] pushViewController:childController animated:YES];
	[childController release];
}

@end
