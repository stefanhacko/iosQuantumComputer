//
//  QBits.h
//  Cuantum Computer Simulator
//
//  Created by Stefan Hacko on 12/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Matrix.h"
#import "Complex.h"

@interface QBits : NSObject {
    Complex *zeroState;
    Complex *oneState;
    
}

-(QBits *)initWithStates:(Complex *)stateZero:(Complex *)stateOne;
-(void)setStates:(Complex *)stateZero:(Complex *)stateOne;
-(BOOL)isInZeroState;
-(Complex *)getState: (int)s;
-(Complex *)zeroState;
-(Complex *)oneState;
@end
