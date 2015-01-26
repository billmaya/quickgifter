//
//  SetupPeopleDatesViewController.h
//  QuickGifter
//
//  Created by Bill Maya on 7/1/09.
//  Copyright 2009 Wampum & Womantam Creations. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetupEditController.h"
#import "SetupEditPlacesController.h"


@interface SetupDetailPlacesController : UIViewController 
	<UITableViewDataSource, UITableViewDelegate> {
		
		NSString *caption;
		UITableView *tableView;
		
		NSMutableDictionary *categoryItems;
		NSArray *categories;
		//NSMutableArray *details;
		
		//SetupEditController *setupEditController;
		SetupEditPlacesController *setupEditPlacesController;
}

@property (nonatomic, retain) NSString *caption;
@property (nonatomic, retain) IBOutlet UITableView *tableView;

@property (nonatomic, retain) NSMutableDictionary *categoryItems;
@property (nonatomic, retain) NSArray *categories;
//@property (nonatomic, retain) NSMutableArray *details;

//@property (nonatomic, retain) SetupEditController *setupEditController;
@property (nonatomic, retain) SetupEditPlacesController *setupEditPlacesController;

@end
