//
//  SetupNavController.h
//  QuickGifter
//
//  Created by Bill Maya on 7/1/09.
//  Copyright 2009 Wampum & Womantam Creations. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetupViewController.h"


@interface SetupNavController : UINavigationController {
	
	SetupViewController *setupViewController;

}

@property (nonatomic, retain) SetupViewController *setupViewController;

@end
