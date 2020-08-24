//
//  Quantum_Computer_SimpulatorAppDelegate.h
//  Quantum Computer Simpulator
//
//  Created by Stefan Hacko on 1/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Quantum_Computer_SimpulatorViewController;

@interface Quantum_Computer_SimpulatorAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    Quantum_Computer_SimpulatorViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet Quantum_Computer_SimpulatorViewController *viewController;

@end
