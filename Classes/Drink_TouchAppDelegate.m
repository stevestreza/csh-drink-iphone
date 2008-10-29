//
//  Drink_TouchAppDelegate.m
//  Drink Touch
//
//  Created by Steve Streza on 10/28/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import "Drink_TouchAppDelegate.h"
#import "Drink_TouchViewController.h"

#import "CSHDrinkClient.h"

@implementation Drink_TouchAppDelegate

@synthesize window;
@synthesize viewController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {	
	
	// Override point for customization after app launch	
    [window addSubview:viewController.view];
	[window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
	[window release];
	[super dealloc];
}


@end
