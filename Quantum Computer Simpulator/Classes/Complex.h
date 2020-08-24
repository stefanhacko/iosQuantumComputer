//
//  Complex.h
//  Cuantum Computer Simulator
//
//  Created by Stefan Hacko on 12/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Complex : NSObject {
    float real;
    float imaginary;
    BOOL isReal;
}

@property float real, imaginary;

-(void) setReal: (float)r andImaginary: (float)i;
//-(BOOL) isReal;
-(BOOL) isZero;
-(float) ugaoFi;
-(float) radius;
-(float) moduo;
-(Complex *) initWithReal: (float)r andImaginary: (float)i;
-(Complex *) add: (Complex *)cNumber;
-(Complex *) product: (Complex *)cNumber;
-(Complex *) devide: (Complex *)cNumber;
+(Complex *) brojIstiZaBr: (Complex *)broj;
+(Complex *) add: (Complex *)cNumOne with: (Complex *)cNumTwo;
+(Complex *) product: (Complex *)cNumOne with: (Complex *)cNumTwo;
+(Complex *) devide: (Complex *)cNumOne with: (Complex *)cNumTwo;

@end
