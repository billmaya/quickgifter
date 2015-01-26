//
//  PersonEditNameController.h
//  QuickGifter
//
//  Created by Bill Maya on 8/15/09.
//  Copyright 2009 Wampum & Womantam Creations. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonEditNameCell.h"


@interface PersonEditNameController : UIViewController 
	<UITableViewDelegate, UITableViewDataSource> {

		BOOL *newItem;
		NSMutableDictionary *editingItem;
		NSMutableArray *editingContent;
		UITableView *tableView;
		
		PersonEditNameCell *personEditNameCell;
		
}

@property (nonatomic, retain) NSMutableDictionary *editingItem;
@property (nonatomic, retain) NSMutableArray *editingContent;
@property (nonatomic, retain) IBOutlet UITableView *tableView;

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;

@end
