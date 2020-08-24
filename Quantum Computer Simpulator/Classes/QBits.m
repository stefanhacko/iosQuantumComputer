//
//  QBits.m
//  Cuantum Computer Simulator
//
//  Created by Stefan Hacko on 12/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QBits.h"


@implementation QBits

-(QBits *)initWithStates:(Complex *)stateZero:(Complex *)stateOne{
    self = [super init];
    
    zeroState = stateZero;
    oneState = stateOne;
    
    return self;
}

-(BOOL)isInZeroState{
    if([[self oneState] isZero]){
        return YES;
    }
    
    else{
        return NO;
    }
    
}

-(void)setStates:(Complex *)stateZero:(Complex *)stateOne{
    zeroState = stateZero;
    oneState = stateOne;
}

-(Complex *)zeroState{
    return zeroState;
}

-(Complex *)oneState{
    return oneState;
}

-(Complex *)getState:(int)s{
    if (s == 0){
        return zeroState;
    }
    else{
        return oneState;
    }
}

- (void)dealloc {
    [zeroState release];
    [oneState release];
    [super dealloc];
}
@end
