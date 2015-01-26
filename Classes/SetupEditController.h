//
//  SetupEditController.h
//  QuickGifter
//
//  Created by Bill Maya on 8/7/09.
//  Copyright 2009 Wampum & Womantam Creations. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetupEditCell.h"

@interface SetupEditController : UIViewController 
	 <UITableViewDelegate, UITableViewDataSource> {

		 BOOL *newItem;
		 NSMutableDictionary *editingItem;
		 NSDictionary *editingItemCopy;
		 NSMutableArray *editingContent;
		 
		 NSString *sectionName;
		 
		 UITextField *itemField;
		 UITextField *categoryField;
		 UITableView *tableView;
		 
		 SetupEditCell *itemCell;
		 UITableViewCell *categoryCell;
}

@property (nonatomic, retain) NSMutableDictionary *editingItem;
@property (nonatomic, copy) NSDictionary *editingItemCopy;
@property (nonatomic, retain) NSMutableArray *editingContent;
@property (nonatomic, copy) NSString *sectionName;
@property (nonatomic, retain) IBOutlet UITableView *tableView;

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;

@end
