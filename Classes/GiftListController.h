//
//  GiftListController.h
//  QuickGifter
//
//  Created by Bill Maya on 8/17/09.
//  Copyright 2009 Wampum & Womantam Creations. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GiftListController : UIViewController 
	<UITableViewDataSource, UITableViewDelegate> {

	UITableView *tableView;
	NSMutableDictionary *peopleGifts;
	NSMutableArray *peoples;
	NSMutableArray *gifts;	
		
		NSMutableArray *peopleDetail;
	
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSMutableDictionary *peopleGifts;
@property (nonatomic, retain) NSMutableArray *peoples;
@property (nonatomic, retain) NSMutableArray *gifts;

@property (nonatomic, retain) NSMutableArray *peopleDetail;

@end
