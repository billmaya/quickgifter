//
//  SetupViewController.h
//  QuickGifter
//
//  Created by Bill Maya on 5/2/09.
//  Copyright 2009 Wampum & Womantam Creations. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SetupViewController : UIViewController 
	<UITableViewDataSource, UITableViewDelegate> {

		NSMutableArray *details;
		NSMutableDictionary *favplaces;
		
}

@property (nonatomic, retain) NSMutableArray *details;
@property (nonatomic, retain) NSMutableDictionary *favplaces;

@end
