//
//  PersonDetailController.h
//  QuickGifter
//
//  Created by Bill Maya on 5/10/09.
//  Copyright 2009 Wampum & Womantam Creations. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonEditDateController.h"
#import "PersonEditSizeController.h"
#import "PersonEditGiftController.h"
#import "PersonEditLikeController.h"
#import "PersonEditPlaceController.h"


@interface PersonDetailController : UIViewController 
	<UITableViewDataSource, UITableViewDelegate> {

	NSMutableDictionary *person;
	NSMutableArray *details;
	UITableView *tableView;
		
	PersonEditDateController *personEditDateController;
	PersonEditSizeController *personEditSizeController;
	PersonEditGiftController *personEditGiftController;
	PersonEditLikeController *personEditLikeController;
	PersonEditPlaceController *personEditPlaceController;

		
}

@property (nonatomic, retain) NSMutableDictionary *person;
@property (nonatomic, retain) NSMutableArray *details;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) PersonEditDateController *personEditDateController;
@property (nonatomic, retain) PersonEditSizeController *personEditSizeController;
@property (nonatomic, retain) PersonEditGiftController *personEditGiftController;
@property (nonatomic, retain) PersonEditLikeController *personEditLikeController;
@property (nonatomic, retain) PersonEditPlaceController *personEditPlaceController;

- (IBAction)edit:(id)sender;

@end
