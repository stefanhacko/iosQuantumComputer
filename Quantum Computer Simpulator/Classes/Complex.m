//
//  Complex.m
//  Cuantum Computer Simulator
//
//  Created by Stefan Hacko on 12/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Complex.h"


@implementation Complex
@synthesize real, imaginary;

#define k_PI 3.14159

-(void)setReal:(float)r andImaginary:(float)i{
    self.real=r;
    self.imaginary=i;
    
    //isReal = [self isReal];
    
   // NSLog(@"Real is %f and imaginary is %f",real, imaginary);
}
/*
-(BOOL)isReal{
    NSLog(@"Is Real");
    if (imaginary == 0){
        NSLog(@"YES");
        isReal = YES;
        return YES;
    }
    else{
        isReal = NO;
        return NO;
        NSLog(@"NO");
    }
}
*/
-(float)ugaoFi{
     //NSLog(@"Ugao");
    float f,x,y;
    x = real;
    y = imaginary;
    if (x > 0){
        f = atanf(y/x);
    }
    
    else if (x < 0 && y >= 0){
        f = atanf(y/x) + k_PI;
    }
    
    else if (x < 0 && y < 0){
        f = atanf(y/x) - k_PI;
        
    }
    
    else if (x == 0 && y > 0){
        f = k_PI/2;
    }
    
    else if (x == 0 & y < 0){
        f = -(k_PI / 2);
    }
    
    //NSLog(@"Ugao je %f",f);
    return f;
    
}

-(BOOL)isZero{
    if (real == 0 && imaginary == 0){
        return YES;
    }
    else{
        return NO;
    }
}

-(float)radius{
     NSLog(@"Radius");
    float r;
    r = [self moduo];
    NSLog(@"Radius je %f",r);
    return r;
}

-(float)moduo{
     NSLog(@"Moduo");
    float mod;
    mod = sqrtf(((real*real)+(imaginary*imaginary)));
    NSLog(@"Moduo je %f",mod);
    return mod;
}

-(Complex *)add:(Complex *)cNumber{
    //NSLog(@"Zbir");
    self.real = cNumber.real + self.real;
    self.imaginary = cNumber.imaginary + self.imaginary;
     //NSLog(@"Real is %f and imaginary is %f",real, imaginary);
    //isReal = [self isReal];
    return self;
}

-(Complex *)product:(Complex *)cNumber{
    //NSLog(@"Proizvod");
    float t = self.real;
    self.real = (real* cNumber.real)-(imaginary*cNumber.imaginary);
    self.imaginary = (t*cNumber.imaginary)+(imaginary*cNumber.real);
    //NSLog(@"Real is %f and imaginary is %f",real, imaginary);
    //isReal = [self isReal];
    return self;
}

-(Complex *)devide:(Complex *)cNumber{
    //NSLog(@"Kolicnik");
    float r = self.real;
    float i = self.imaginary;
    self.real = ((real* cNumber.real)+(imaginary*cNumber.imaginary))/((cNumber.real*cNumber.real)+(cNumber.imaginary*cNumber.imaginary));
    self.imaginary = ((i * cNumber.real)-(r*cNumber.imaginary))/((cNumber.real*cNumber.real)+(cNumber.imaginary*cNumber.imaginary));
   // NSLog(@"Real is %f and imaginary is %f",real, imaginary);
    //isReal = [self isReal];
    return self;
}

+(Complex *) add:(Complex *)cNumOne with:(Complex *)cNumTwo{
     //NSLog(@"Zbir dva");
    Complex *zbir = [[Complex alloc] init];
    zbir.real = cNumOne.real + cNumTwo.real;
    zbir.imaginary = cNumOne.imaginary +cNumTwo.imaginary;
    //[zbir isReal];
    return zbir;
}

+(Complex *) product:(Complex *)cNumOne with:(Complex *)cNumTwo{
    //NSLog(@"Proizvod dva");
    Complex *proizvod = [[Complex alloc] init];
    proizvod.real = (cNumOne.real*cNumTwo.real)-(cNumOne.imaginary*cNumTwo.imaginary);
    proizvod.imaginary = (cNumOne.real*cNumTwo.imaginary)+(cNumOne.imaginary*cNumTwo.real);
    //[proizvod isReal];
    return proizvod;
}

+(Complex *) devide:(Complex *)cNumOne with:(Complex *)cNumTwo{
     NSLog(@"Kolicnik dva");
    Complex *kolicnik = [[Complex alloc] init];
    kolicnik.real = ((cNumOne.real*cNumTwo.real)+(cNumOne.imaginary*cNumTwo.imaginary))/((cNumTwo.real*cNumTwo.real)+(cNumTwo.imaginary*cNumTwo.imaginary));
    kolicnik.imaginary = ((cNumOne.imaginary*cNumTwo.real)-(cNumOne.real*cNumTwo.imaginary))/((cNumTwo.real*cNumTwo.real)+(cNumTwo.imaginary*cNumTwo.imaginary));
    //[kolicnik isReal];
    return kolicnik;
}

+(Complex *)brojIstiZaBr:(Complex *)broj{
    Complex *povratak = [[Complex alloc] init];
    
    [povratak setReal:[broj real] andImaginary:[broj imaginary]];
    
    return povratak;
}

-(Complex *)initWithReal:(float)r andImaginary:(float)i{
    self = [super init];
    
    [self setReal:r andImaginary:i];
    
    return self;
}
@end
    
