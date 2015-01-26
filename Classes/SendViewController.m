//
//  SendViewController.m
//  QuickGifter
//
//  Created by Bill Maya on 5/2/09.
//  Copyright 2009 Wampum & Womantam Creations. All rights reserved.
//

#import "QuickGifterAppDelegate.h"
#import "SendViewController.h"

#define CRLN @"\r\n"
#define DIVIDER @" - "
#define TM @"\u2122"

@implementation SendViewController

@synthesize people, tableView;
@synthesize message;
@synthesize person;

-(IBAction)showPicker:(id)sender
{
	// This sample can run on devices running iPhone OS 2.0 or later  
	// The MFMailComposeViewController class is only available in iPhone OS 3.0 or later. 
	// So, we must verify the existence of the above class and provide a workaround for devices running 
	// earlier versions of the iPhone OS. 
	// We display an email composition interface if MFMailComposeViewController exists and the device can send emails.
	// We launch the Mail application on the device, otherwise.
	
	Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
	if (mailClass != nil)
	{
		// We must always check whether the current device is configured for sending emails
		if ([mailClass canSendMail])
		{
			[self displayComposerSheet];
		}
		else
		{
			[self launchMailAppOnDevice];
		}
	}
	else
	{
		[self launchMailAppOnDevice];
	}
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
 
	//self.people = ((QuickGifterAppDelegate *)[UIApplication sharedApplication].delegate).people;
	[super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    
	
	self.people = ((QuickGifterAppDelegate *)[UIApplication sharedApplication].delegate).people;
	[tableView reloadData];
}

- (void)viewDidUnload 
{

	self.message = nil;
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
	[message release];
    [super dealloc];
}

#pragma mark -
#pragma mark Table Data Source Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	NSInteger count = [people count];
    if (self.editing) count++; 
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *TopLevelCellIdentifier = @"MyPerson";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TopLevelCellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:TopLevelCellIdentifier] autorelease];
	}

	self.person = [self.people objectAtIndex:indexPath.row];
	NSString *fname = [person objectForKey:@"fullname"];
	cell.textLabel.text = fname;

	return cell;
}

// The editing style for a row is the kind of button displayed to the left of the cell when in editing mode.
- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	return UITableViewCellEditingStyleNone;
}

#pragma mark -
#pragma mark Table Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	self.person = [self.people objectAtIndex:indexPath.row];
}

#pragma mark -
#pragma mark Compose Mail

// Displays an email composition interface inside the application. Populates all the Mail fields. 
-(void)displayComposerSheet 
{
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
	
	NSMutableString *subject = [NSMutableString stringWithString:[self.person objectForKey:@"fullname"]];
	[subject appendString:@" QuickGifter"];
	//[subject appendString:TM];
	[subject appendString:@" Info"];
	
	[picker setSubject:subject];
	
	//[picker setSubject:[@"QuickGifter Info for " stringByAppendingString:[self.person objectForKey:@"fullname"]]];
	
	NSArray *toRecipients = [[NSArray alloc] init];
	NSArray *ccRecipients = [[NSArray alloc] init];
	NSArray *bccRecipients = [[NSArray alloc] init];
	
	[picker setToRecipients:toRecipients];
	[picker setCcRecipients:ccRecipients];	
	[picker setBccRecipients:bccRecipients];
	
	NSMutableString *personGiftInfo = [NSMutableString stringWithString:@""];
	
	[personGiftInfo appendString:@"Sent from QuickGifter"];
	[personGiftInfo appendString:TM];
	[personGiftInfo appendString:@" v1.0 - www.quickgifter.com"];
	[personGiftInfo appendString:CRLN];
	[personGiftInfo appendString:CRLN];
	
	for (NSDictionary *personInArray in people) {
		NSString *fullname = [personInArray objectForKey:@"fullname"];
		
		if ([fullname isEqualToString:[person objectForKey:@"fullname"]] == YES) {
			NSArray *info = [NSArray arrayWithArray:[personInArray objectForKey:@"info"]]; 
			for (NSDictionary *category in info) {
				NSString *name= [[category objectForKey:@"name"] uppercaseString];
				
				[personGiftInfo appendString:name];
				[personGiftInfo appendString:CRLN];
				[personGiftInfo appendString:CRLN];
				
				NSArray *content = [NSArray arrayWithArray:[category objectForKey:@"content"]]; 
				for (NSDictionary *item in content) {
					[personGiftInfo appendString:[item objectForKey:@"Name"]];
					if ([[item objectForKey:@"Type"] length] != 0) {
						[personGiftInfo appendString:DIVIDER];
						[personGiftInfo appendString:[item objectForKey:@"Type"]];
					}
					[personGiftInfo appendString:CRLN];
				}
				[personGiftInfo appendString:CRLN];
			}
			break;
		} 
	}
	
	[picker setMessageBody:personGiftInfo isHTML:NO];
	
	[self presentModalViewController:picker animated:YES];
    [picker release];
	//[personGiftInfo release]; // Why does releasing here throw EXE_BAD_ACCESS?
}


// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{	
	message.hidden = NO;
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MFMailComposeResultCancelled:
			message.text = @"Result: canceled";
			break;
		case MFMailComposeResultSaved:
			message.text = @"Result: saved";
			break;
		case MFMailComposeResultSent:
			message.text = @"Result: sent";
			break;
		case MFMailComposeResultFailed:
			message.text = @"Result: failed";
			break;
		default:
			message.text = @"Result: not sent";
			break;
	}
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark Workaround

// Launches the Mail application on the device.
-(void)launchMailAppOnDevice
{
	NSString *recipients = @"mailto:first@example.com?cc=second@example.com,third@example.com&subject=Hello from California!";
	NSString *body = @"&body=It is raining in sunny California!";
	
	NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
	email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
}

@end
