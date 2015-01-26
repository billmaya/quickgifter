//
//  PersonEditDateController.h
//  QuickGifter
//
//  Created by Bill Maya on 5/2/09.
//  Copyright 2009 Wampum & Womantam Creations. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PersonEditDateTypeController;

@interface PersonEditDateController : UIViewController 
	<UITableViewDataSource, UITableViewDelegate> {
	
		NSArray *details;
		
		BOOL *newItem;
		NSMutableDictionary *editingItem;
		NSMutableArray *editingContent;
		NSString *sectionName;
		NSArray *dateTypes;
		
		UITableView *tableView;
		IBOutlet UIDatePicker *datePicker;
		
		PersonEditDateTypeController *personEditDateTypeController;
		UITableViewCell *typeCell;
}

@property (nonatomic, retain) NSArray *details;

@property (nonatomic, retain) NSMutableDictionary *editingItem;
@property (nonatomic, retain) NSMutableArray *editingContent;
@property (nonatomic, copy) NSString *sectionName;
@property (nonatomic, retain) NSArray *dateTypes;

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UIDatePicker *datePicker;

@property (nonatomic, retain) PersonEditDateTypeController *personEditDateTypeController;

-(IBAction)save:(id)sender;
-(IBAction)cancel:(id)sender;
-(IBAction)nameFieldDoneEditing:(id)sender;

@end
