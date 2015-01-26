//
//  PersonDetailGiftCell.h
//  QuickGifter
//
//  Created by Bill Maya on 9/8/09.
//  Copyright 2009 Wampum & Womantam Creations. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonDetailGiftCell : UITableViewCell {
	UITextField *type;
    UITextField *name;
	UITextField *prompt;
    BOOL promptMode;
}

@property (readonly, retain) UITextField *type;
@property (readonly, retain) UITextField *name;
@property (readonly, retain) UITextField *prompt;
@property BOOL promptMode;

@end
