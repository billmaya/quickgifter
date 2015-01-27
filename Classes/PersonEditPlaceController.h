//
//  PersonEditStoreController.h
//  QuickGifter
//
//  Created by Bill Maya on 8/4/09.
//  Copyright 2009 Wampum & Womantam Creations. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PersonEditPlaceController : UIViewController 
	<UITableViewDataSource, UITableViewDelegate> {

		UITableView *tableView;
		NSArray *details;
		
		NSDictionary *categoryItems;
		NSArray *categories;
		NSArray *items;
		
		BOOL *newItem;
		NSMutableDictionary *editingPlace;
		NSMutableArray *editingContent;
}

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSArray *details;

@property (nonatomic, retain) NSDictionary *categoryItems;
@property (nonatomic, retain) NSArray *categories;

@property (nonatomic, retain) NSMutableDictionary *editingPlace;
@property (nonatomic, retain) NSMutableArray *editingContent;

-(IBAction)save:(id)sender;
-(IBAction)cancel:(id)sender;

@end
