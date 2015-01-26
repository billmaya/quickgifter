//
//  PersonListController.h
//  QuickGifter
//
//  Created by Bill Maya on 5/2/09.
//  Copyright 2009 Wampum & Womantam Creations. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonEditNameController.h"

@interface PersonListController : UIViewController 
	<UIActionSheetDelegate, UITableViewDelegate, UITableViewDataSource> {
		
		NSMutableArray *people;
		UITableView *tableView;
		
		PersonEditNameController *personEditNameController;

}

@property (nonatomic, retain) NSMutableArray *people;
@property (nonatomic, retain) IBOutlet UITableView *tableView;

@property (nonatomic, retain) PersonEditNameController *personEditNameController;

-(IBAction)createPerson;
-(IBAction)importPerson;
-(IBAction)importAllPeople;

@end
