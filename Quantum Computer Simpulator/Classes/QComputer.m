//
//  QComputer.m
//  Cuantum Computer Simulator
//
//  Created by Stefan Hacko on 12/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QComputer.h"


@implementation QComputer

@synthesize brqBita, brStanja;

-(BOOL)stanjeJeNula:(int)i{
    Complex *brojZaTest = [sistem objectAtIndex:i];
    
    if([brojZaTest real] == 0 && [brojZaTest imaginary] == 0){
        return YES;
    }
    
    else{
        return NO;
    }
}

-(void)changeBitNo:(int)a withBit:(QBits *)bit{
    [qBiti replaceObjectAtIndex:a withObject:bit];
}

-(QComputer *)initWithNoOfBits:(int)i{
    
    self = [super init];
    
    brStanja = pow(2, i);
    
    stanje = 0;
    
    NSUInteger bb = brStanja;
    
    brqBita = i;
    
    sistem = [[NSMutableArray alloc] initWithCapacity:bb];
    
    return self;
}

-(NSMutableArray *)setBitsTo:(Complex *)stanjeJedan :(Complex *)stanjeDva{
    
    int a = brqBita;
    NSUInteger aa = a;
    
    NSMutableArray *biti = [[NSMutableArray alloc] initWithCapacity:aa];
    
    for (int i = 0; i <= (a - 1); i++){
        Complex *broZaJedan = [Complex brojIstiZaBr:stanjeJedan];
        Complex *brojZaDva = [Complex brojIstiZaBr:stanjeDva];
        QBits *bitic = [[QBits alloc] initWithStates:broZaJedan:brojZaDva];
        [biti insertObject:bitic atIndex:i];
    }
    qBiti = biti;
    return nil;
}

-(NSMutableArray *)ugloviFi{
    
    NSUInteger zz = brStanja;
    
    NSMutableArray *uglovi = [[NSMutableArray alloc] initWithCapacity:zz];
    
    for(int i = 0; i<= (brStanja - 1);i++){
        
        NSUInteger ii = i;
        NSNumber *ugao = [NSNumber numberWithFloat:[[sistem objectAtIndex:ii] ugaoFi]];
        
        [uglovi addObject:ugao];
       
    }
    
    return uglovi;
}

-(NSMutableArray *)tenzorskiProizvodQBita:(NSMutableArray *)biti brBita:(int)b{
 
    if(b==0){
        for (int a = 0; a<= (brqBita - 1);a++){
            if(a==0){
                [sistem insertObject:[Complex brojIstiZaBr:[[qBiti objectAtIndex:a] getState:trazenoStanje[a]]] atIndex:stanje];
            }
            else{
                [[sistem objectAtIndex:stanje] product:[[qBiti objectAtIndex:a] getState:trazenoStanje[a]]];
            }
            
        }
         stanje++;
    }
    
    else{
        for(int k = 0; k<2; k++){
            trazenoStanje[b-1]=k;
            //NSLog(@"%d",k);
            [self tenzorskiProizvodQBita:nil brBita:(b-1)];
        }
    }
    
    return nil;
}

-(void)start{
    
    Complex *brojNula = [[Complex alloc] init];
    Complex *brojJedan = [[Complex alloc] init];
    
    [brojNula setReal:1.0 andImaginary:0.0];
    [brojJedan setReal:0.00 andImaginary:0.0];
    
    [self setBitsTo:brojNula :brojJedan];
    
    [self tenzorskiProizvodQBita:nil brBita:brqBita];
    
    [brojNula release];
    [brojJedan release];
    
}

-(void)refresh{
	stanje = 0;
    [self tenzorskiProizvodQBita:nil brBita:brqBita];
}

-(QBits *)bitBr:(int)i{
    return [qBiti objectAtIndex:i];
}

-(NSMutableArray *)sistem{
    return sistem;
}

-(void)dealloc{
	for (int i = brqBita -1; i>=0; i--) {
		QBits *bit = [qBiti objectAtIndex:i];
		[qBiti removeLastObject];
		[bit release];
	}
	//for (int i = pow(2, brqBita) - 1; i>=0; i--) {
		//Complex *broj = [sistem objectAtIndex:i];
		[sistem removeAllObjects];
		//[broj release];
	//}
	[qBiti release];
	[sistem release];
	
	[super dealloc];
}

@end
