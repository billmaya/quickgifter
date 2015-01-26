//
//  QuickGifterAppDelegate.h
//  QuickGifter
//
//  Created by Bill Maya on 5/2/09.
//  Copyright 2009 Wampum & Womantam Creations. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonNavController.h"
#import "SetupNavController.h"

#import "PersonListController.h"

@interface QuickGifterAppDelegate : NSObject <UIApplicationDelegate> {
	
    UIWindow *window;
	IBOutlet UITabBarController *rootController;

	NSMutableArray *people;
	NSMutableArray *details;
	NSDictionary *sizes;
	NSMutableDictionary *favplaces;
	
	
	NSString *pathToPeople;
	NSString *pathToDetails;
	NSString *pathToSizes;
	NSString *pathToFavPlaces;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) UITabBarController *rootController;

@property (nonatomic, retain) NSMutableArray *people;
@property (nonatomic, retain) NSMutableArray *details;
@property (nonatomic, retain) NSDictionary *sizes;
@property (nonatomic, retain) NSMutableDictionary *favplaces;

@property (nonatomic, retain) NSString *pathToPeople;
@property (nonatomic, retain) NSString *pathToDetails;
@property (nonatomic, retain) NSString *pathToSizes;
@property (nonatomic, retain) NSString *pathToFavPlaces;

@end

