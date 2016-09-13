//
//  main.m
//  QuickGifter
//
//  Created by Bill Maya on 5/2/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuickGifterAppDelegate.h"

int main(int argc, char *argv[]) {
    
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, NSStringFromClass([QuickGifterAppDelegate class]));
    [pool release];
    return retVal;
}
