//
//  HellowWorldAppDelegate.h
//  HellowWorld
//
//  Created by Lacey-bordeaux, Peter M on 2/15/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HellowWorldViewController;

@interface HellowWorldAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    HellowWorldViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet HellowWorldViewController *viewController;

@end

