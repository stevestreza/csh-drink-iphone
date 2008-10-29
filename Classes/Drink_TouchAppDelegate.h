//
//  Drink_TouchAppDelegate.h
//  Drink Touch
//
//  Created by Steve Streza on 10/28/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Drink_TouchViewController;

@interface Drink_TouchAppDelegate : NSObject <UIApplicationDelegate> {
	IBOutlet UIWindow *window;
	IBOutlet Drink_TouchViewController *viewController;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) Drink_TouchViewController *viewController;

@end

