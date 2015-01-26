//
//  PersonEditSizeTypeController.h
//  QuickGifter
//
//  Created by Bill Maya on 9/26/09.
//  Copyright 2009 Wampum & Womantam Creations. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PersonEditSizeTypeController : UIViewController
	<UITableViewDelegate, UITableViewDataSource> {
	
	NSArray *types;
	NSMutableDictionary *editingItem;
	UITableView *tableView;
	}
	
@property (nonatomic, retain) NSArray *types;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSMutableDictionary *editingItem;

@end
