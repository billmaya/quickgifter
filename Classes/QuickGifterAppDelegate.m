//
//  QuickGifterAppDelegate.m
//  QuickGifter
//
//  Created by Bill Maya on 5/2/09.
//  Copyright 2009 Wampum & Womantam Creations. All rights reserved.
//

#import "QuickGifterAppDelegate.h"

@implementation QuickGifterAppDelegate

@synthesize window;
@synthesize rootController;

@synthesize people, details, sizes, favplaces;
@synthesize pathToPeople, pathToDetails, pathToSizes, pathToFavPlaces;

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
	
    self.pathToPeople = [documentsDirectory stringByAppendingPathComponent:@"People.plist"];
    if ([fileManager fileExistsAtPath:pathToPeople] == NO) {
        NSString *pathToDefaultPeople = [[NSBundle mainBundle] pathForResource:@"People" ofType:@"plist"];
        if ([fileManager copyItemAtPath:pathToDefaultPeople toPath:pathToPeople error:&error] == NO) {
            NSAssert1(0, @"Failed to copy people data with error message '%@'.", [error localizedDescription]);
        }
    }
	
	self.pathToDetails = [documentsDirectory stringByAppendingPathComponent:@"Setup.plist"];
    if ([fileManager fileExistsAtPath:pathToDetails] == NO) {
        NSString *pathToDefaultDetails = [[NSBundle mainBundle] pathForResource:@"Setup" ofType:@"plist"];
        if ([fileManager copyItemAtPath:pathToDefaultDetails toPath:pathToDetails error:&error] == NO) {
            NSAssert1(0, @"Failed to copy setup data with error message '%@'.", [error localizedDescription]);
        }
    }
	
	self.pathToSizes = [documentsDirectory stringByAppendingPathComponent:@"Sizes.plist"];
	if ([fileManager fileExistsAtPath:pathToSizes] == NO) {
		NSString *pathToDefaultSizes = [[NSBundle mainBundle] pathForResource:@"Sizes" ofType:@"plist"];
		if ([fileManager copyItemAtPath:pathToDefaultSizes toPath:pathToSizes error:&error] == NO) {
			NSAssert1(0, @"Failed to copy size data with error message '%@'.", [error localizedDescription]);
		}
	}
	
	self.pathToFavPlaces = [documentsDirectory stringByAppendingPathComponent:@"FavPlaces.plist"];
	if ([fileManager fileExistsAtPath:pathToFavPlaces] == NO) {
		NSString *pathToDefaultFavPlaces = [[NSBundle mainBundle] pathForResource:@"FavPlaces" ofType:@"plist"];
		if ([fileManager copyItemAtPath:pathToDefaultFavPlaces toPath:pathToFavPlaces error:&error] == NO) {
			NSAssert1(0, @"Faled to copy fav place data with error message '%@'.", [error localizedDescription]);
		}
	}
	
	self.people = [[[NSMutableArray alloc] initWithContentsOfFile:pathToPeople] autorelease];
	
	self.details = [[[NSMutableArray alloc] initWithContentsOfFile:pathToDetails] autorelease];	
	
	self.sizes = [[[NSDictionary alloc] initWithContentsOfFile:pathToSizes] autorelease];
	
	self.favplaces = [[[NSMutableDictionary alloc] initWithContentsOfFile:pathToFavPlaces] autorelease];
	
	//[window addSubview:rootController.view];
    [self.window setRootViewController:rootController];
    [window makeKeyAndVisible];
}

- (void)applicationWillTerminate:(UIApplication *)application {
	
	[people writeToFile:pathToPeople atomically:NO];
	[details writeToFile:pathToDetails atomically:NO]; 
	[favplaces writeToFile:pathToFavPlaces atomically:NO];
}


- (void)dealloc {
	[pathToPeople release];
	[pathToDetails release];
	[pathToSizes release];
	[pathToFavPlaces release];
	[people release];
	[details release];
	[sizes release];
	[favplaces release];
	[rootController release];
    [window release];
    [super dealloc];
}

@end
