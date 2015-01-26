//
//  PersonEditSizeController.h
//  QuickGifter
//
//  Created by Bill Maya on 8/4/09.
//  Copyright 2009 Wampum & Womantam Creations. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PersonEditSizeTypeController;

@interface PersonEditSizeController : UIViewController 
	<UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDataSource, UITableViewDelegate> {
		
		NSArray *details;		
		NSDictionary *sizes;
		NSMutableArray *componentOne;
		NSMutableArray *componentTwo;
		NSMutableArray *componentThree;
		NSMutableArray *componentFour;
		
		BOOL *newItem;
		NSMutableDictionary *editingSize;
		NSMutableArray *editingContent;
		NSString *sectionName;
		NSString *editingType;
		NSArray *clothingTypes;
		
		UITableView *tableView;
		IBOutlet UIPickerView *sizePicker;
		
		PersonEditSizeTypeController *personEditSizeTypeController;
		UITableViewCell *typeCell;
}

@property (nonatomic, retain) NSArray *details;
@property (nonatomic, retain) NSDictionary *sizes;
@property (nonatomic, retain) NSMutableArray *componentOne;
@property (nonatomic, retain) NSMutableArray *componentTwo;
@property (nonatomic, retain) NSMutableArray *componentThree;
@property (nonatomic, retain) NSMutableArray *componentFour;

@property (nonatomic, retain) NSMutableDictionary *editingSize;
@property (nonatomic, retain) NSMutableArray *editingContent;
@property (nonatomic, copy) NSString *sectionName;
@property (nonatomic, retain) NSString *editingType;
@property (nonatomic, retain) NSArray *clothingTypes;

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UIPickerView *sizePicker;

@property (nonatomic, retain) PersonEditSizeTypeController *personEditSizeTypeController;

-(IBAction)save:(id)sender;
-(IBAction)cancel:(id)sender;

-(void) PopulatePickerArrays;

@end