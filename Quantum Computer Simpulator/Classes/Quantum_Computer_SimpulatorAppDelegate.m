//
//  Quantum_Computer_SimpulatorAppDelegate.m
//  Quantum Computer Simpulator
//
//  Created by Stefan Hacko on 1/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Quantum_Computer_SimpulatorAppDelegate.h"

#import "Quantum_Computer_SimpulatorViewController.h"

@implementation Quantum_Computer_SimpulatorAppDelegate


@synthesize window;

@synthesize viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // Override point for customization after application launch.
     
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {

    // Save data if appropriate.
}

- (void)dealloc {

    [window release];
    [viewController release];
    [super dealloc];
}

@end
