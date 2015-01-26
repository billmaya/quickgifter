//
//  PersonEditDateTypeController.h
//  QuickGifter
//
//  Created by Bill Maya on 9/12/09.
//  Copyright 2009 Wampum & Womantam Creations. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PersonEditDateTypeController : UIViewController
	<UITableViewDelegate, UITableViewDataSource> {
	
	NSArray *types;
	NSMutableDictionary *editingItem;
	UITableView *tableView;
	}
	
@property (nonatomic, retain) NSArray *types;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSMutableDictionary *editingItem;

@end
