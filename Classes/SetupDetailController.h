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


@interface SetupDetailController : UIViewController 
	<UITableViewDataSource, UITableViewDelegate> {
		
		NSString *caption;
		NSMutableArray *details;
		UITableView *tableView;
		
		SetupEditController *setupEditController;
		//SetupEditPlacesController *setupEditPlacesController;
}

@property (nonatomic, retain) NSString *caption;
@property (nonatomic, retain) NSMutableArray *details;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) SetupEditController *setupEditController;
//@property (nonatomic, retain) SetupEditPlacesController *setupEditPlacesController;

@end
