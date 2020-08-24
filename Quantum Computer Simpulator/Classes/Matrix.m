//
//  Matrix.m
//  Cuantum Computer Simulator
//
//  Created by Stefan Hacko on 12/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Matrix.h"



@implementation Matrix

@synthesize rows,columns;

-(Matrix *)initWithSize:(int)i by:(int)j{
    
    
    self = [super init];
    
    rows = i;
    columns = j;
    
    NSUInteger red = rows;
    NSUInteger kolona = columns;
    
    redovi = [[NSMutableArray alloc] initWithCapacity:red];
    
    for (int a = 0; a <= (rows - 1); a++){
        NSUInteger aa=a;
        NSMutableArray *kolone = [NSMutableArray arrayWithCapacity:kolona];
        [redovi insertObject:kolone atIndex:aa];
        
    }
    
    return self;
    
}

+(Matrix *)add:(Matrix *)aMatrix with:(Matrix *)bMatrix{
    
    Matrix *rezultujuca = [[Matrix alloc] initWithSize:[aMatrix rows] by:[aMatrix columns]];
    
    int x = [aMatrix rows];
    int y = [aMatrix columns];
    
    for(int a = 0; a <= x - 1; a++){
        for(int b = 0; b <= y - 1; b++){
            Complex *prviSabirak = [[Complex alloc]init];
            Complex *drugiSabirak = [[Complex alloc]init];
            Complex *rezultat;
            
            prviSabirak = [aMatrix getOojectAtRow:a Column:b];
            drugiSabirak = [bMatrix getOojectAtRow:a Column:b];
            
            rezultat = [Complex add:prviSabirak with:drugiSabirak];
            
            [rezultujuca addObject:rezultat AtRow:a Column:b];
            
            [prviSabirak release];
            [drugiSabirak release];
            
        }
    }
    
    return rezultujuca;
}

-(void)addObject: (id)object AtRow:(int)i Column:(int)j{
    NSUInteger red = i;
    NSUInteger kolona = j;
    
    [[redovi objectAtIndex:red] insertObject:object atIndex:kolona];
}

-(void)replaceObjectAtRow:(int)i Column:(int)j WithObject:(id)object{
    NSUInteger red = i;
    NSUInteger kolona = j;
    
    [[redovi objectAtIndex:red] replaceObjectAtIndex:kolona withObject:object];
}

-(void)removeObjectAtRow:(int)i Column:(int)j{
    NSUInteger red = i;
    NSUInteger kolona = j;
    
    [[redovi objectAtIndex:red] replaceObjectAtIndex:kolona withObject:nil];
}

-(id)getOojectAtRow:(int)i Column:(int)j{
    NSUInteger red = i;
    NSUInteger kolona = j;
    
	Complex *objekat = [[redovi objectAtIndex:red] objectAtIndex:kolona];
    return objekat;
}

- (void)dealloc {
	[redovi removeAllObjects];
    [redovi release];
    [super dealloc];
}

+(NSMutableArray *)product:(Matrix *)aMatrix withOneRow:(NSMutableArray *)red sizeOfRow:(int)i{
    NSMutableArray *povratna = [[NSMutableArray alloc] initWithCapacity:i];
    
    for(int a = 0; a<i; a++){
        Complex *nula = [[Complex alloc] initWithReal:0.00 andImaginary:0.00];
        [povratna insertObject:nula atIndex:a];
    }
    
    for(int x = 0; x<i; x++){
        for(int y = 0; y<i; y++){
			Complex *brojce =[Complex product:[red objectAtIndex:y] with:[aMatrix getOojectAtRow:x Column:y]];
            [[povratna objectAtIndex:x] add:brojce];
			[brojce release];
        }
    }
    return povratna;
    
}

@end
