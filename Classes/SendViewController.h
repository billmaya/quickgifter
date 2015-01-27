//
//  SendViewController.h
//  QuickGifter
//
//  Created by Bill Maya on 5/2/09.
//  Copyright 2009 Wampum & Womantam Creations. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface SendViewController : UIViewController 
	<UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate> {

		NSMutableArray *people;
		UITableView *tableView;
		
		IBOutlet UILabel *message;
		
		NSDictionary *person;

}

@property (nonatomic, retain) NSMutableArray *people;
@property (nonatomic, retain) IBOutlet UITableView *tableView;

@property (nonatomic, retain) IBOutlet UILabel *message;

@property (nonatomic, retain) NSDictionary *person;

-(IBAction)showPicker:(id)sender;
-(void)displayComposerSheet;
-(void)launchMailAppOnDevice;

@end
