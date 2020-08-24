//
//  QComputer.h
//  Cuantum Computer Simulator
//
//  Created by Stefan Hacko on 12/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QBits.h"
#import "Matrix.h"
#import "Complex.h"
#import "QGates.h"

@interface QComputer : NSObject {
    
    int brqBita;
    int brStanja;
    int trazenoStanje[20];
    int stanje;
    NSMutableArray *qBiti;
    NSMutableArray *sistem;
}

@property int brqBita, brStanja;

-(void)start;
-(void)refresh;
-(void)changeBitNo:(int)a withBit: (QBits *)bit;
-(BOOL)stanjeJeNula:(int)i;
-(QBits *)bitBr:(int)i;
-(NSMutableArray *)sistem;
-(NSMutableArray *)ugloviFi;
-(NSMutableArray *)setBitsTo:(Complex *)stanjeJedan :(Complex *)stanjeDva;
-(NSMutableArray *)tenzorskiProizvodQBita:(NSMutableArray *)biti brBita: (int)b;
-(QComputer *)initWithNoOfBits: (int) i;
@end
