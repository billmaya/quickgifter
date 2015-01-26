//
//  SetupEditController.h
//  QuickGifter
//
//  Created by Bill Maya on 8/7/09.
//  Copyright 2009 2009 Wampum & Womantam Creations. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetupEditCell.h"

@class SetupEditPlacesTypeController;

@interface SetupEditPlacesController : UIViewController 
	 <UITableViewDelegate, UITableViewDataSource> {

		 NSArray *details;
		 SetupEditPlacesTypeController *setupEditPlacesTypeController;
		 
		 BOOL *newItem;
		 
		 //NSMutableDictionary *editingItem; // Changed to NSString
		 //NSDictionary *editingItemCopy;
		 
		 NSMutableString *editingItem;
		 NSMutableString *editingItemCopy;
		 NSMutableArray *editingContent;
		 
		 //NSArray *placeTypes; // Don't need to build Type of Places data structure
		 
		 NSString *sectionName;
		 
		 UITextField *itemField;
		 UITextField *categoryField;
		 UITableView *tableView;
		 
		 SetupEditCell *itemCell;
		 UITableViewCell *categoryCell;
}

@property (nonatomic, retain) NSArray *details;
@property (nonatomic, retain) SetupEditPlacesTypeController *setupEditPlacesTypeController;

//@property (nonatomic, retain) NSMutableDictionary *editingItem; // Changed to NSString
//@property (nonatomic, copy) NSDictionary *editingItemCopy;

@property (nonatomic, retain) NSMutableString *editingItem;
@property (nonatomic, copy) NSMutableString *editingItemCopy;
@property (nonatomic, retain) NSMutableArray *editingContent;

//@property (nonatomic, retain) NSArray *placeTypes; //Don't need to build Type of Places data structure

@property (nonatomic, copy) NSString *sectionName;
@property (nonatomic, retain) IBOutlet UITableView *tableView;

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;
- (IBAction)nameFieldDoneEditing:(id)sender;

@end
