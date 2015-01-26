//
//  PersonEditLikeController.h
//  QuickGifter
//
//  Created by Bill Maya on 8/4/09.
//  Copyright 2009 Wampum & Womantam Creations. All rights reserved.
//

#import <UIKit/UIKit.h>

#define categoryComponent 0
#define itemComponent 1

@interface PersonEditLikeController : UIViewController
	<UIPickerViewDelegate, UIPickerViewDataSource> {
		
		IBOutlet UIPickerView *dependentPicker;
		NSArray *details;
		NSDictionary *categoryItems;
		NSArray *categories;
		NSArray *items;
		
		IBOutlet UITextField *detailField;
		
		BOOL *newItem;
		NSMutableDictionary *editingLike;
		NSMutableArray *editingContent;
		NSString *editingType;
}
	
@property (nonatomic, retain) UIPickerView *dependentPicker;
@property (nonatomic, retain) NSArray *details;
@property (nonatomic, retain) NSDictionary *categoryItems;
@property (nonatomic, retain) NSArray *categories;
@property (nonatomic, retain) NSArray *items;

@property (nonatomic, retain) UITextField *detailField;

@property (nonatomic, retain) NSMutableDictionary *editingLike;
@property (nonatomic, retain) NSMutableArray *editingContent;
@property (nonatomic, retain) NSString *editingType;

-(IBAction)save:(id)sender;
-(IBAction)cancel:(id)sender;
- (IBAction)textFieldDoneEditing:(id)sender;
- (IBAction)backgroundClick:(id)sender;

@end
