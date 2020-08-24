//
//  Matrix.h
//  Cuantum Computer Simulator
//
//  Created by Stefan Hacko on 12/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Complex.h"

@interface Matrix : NSObject {
    int columns;
    int rows;
    NSMutableArray *redovi;

}

@property int columns, rows;

-(Matrix *)initWithSize: (int)i by: (int)j;
+(NSMutableArray *)product: (Matrix *)aMatrix withOneRow:(NSMutableArray *)red sizeOfRow:(int)i;
+(Matrix *)add: (Matrix *)aMatrix with: (Matrix *)bMatrix;
-(void)addObject: (id)object AtRow: (int)i Column: (int)j;
-(void)replaceObjectAtRow: (int)i Column: (int)j WithObject:(id)object;
-(void)removeObjectAtRow: (int)i Column: (int)j;
-(id)getOojectAtRow: (int)i Column: (int)j;

@end
