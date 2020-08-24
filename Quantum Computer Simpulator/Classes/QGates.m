
//  QGates.m
//  Quantum Computer Simpulator
//
//  Created by Stefan Hacko on 1/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "QGates.h"

@implementation QGates
float absfdd(float x);
@synthesize radniBit, kontrolniBit, operacijaBr;
@synthesize isDoneOperating;
@synthesize screenObject;

#define k_Pi 3.14159265
#define k_E 2.71828183

-(QGates *)initWithComputer:(QComputer *)comp{
    
    self = [super init];
	
	operacijaBr = 0;
    
    qComp = comp;
    
    pauliX = [[Matrix alloc] initWithSize:2 by:2];
    pauliY = [[Matrix alloc] initWithSize:2 by:2];
    pauliZ = [[Matrix alloc] initWithSize:2 by:2];
    hadamard = [[Matrix alloc] initWithSize:2 by:2];
    cnot = [[Matrix alloc] initWithSize:4 by:4];
    
    float korenIzDva = sqrtf(2);
    
    nula = [[Complex alloc] initWithReal:0.00 andImaginary:0.00];
    jedan = [[Complex alloc] initWithReal:1.00 andImaginary:0.00];
    minusJedan = [[Complex alloc] initWithReal:-1.00 andImaginary:0.00];
    iBroj = [[Complex alloc] initWithReal:0.00 andImaginary:1.00];
    minusI = [[Complex alloc] initWithReal:0.00 andImaginary:-1.00];
    jedanZaHadamard = [[Complex alloc] initWithReal:(1/korenIzDva) andImaginary:0.00];
    minusJedanZaHad = [[Complex alloc] initWithReal:-(1/korenIzDva) andImaginary:0.00];
    
    [pauliX addObject:nula AtRow:0 Column:0];
    [pauliX addObject:jedan AtRow:0 Column:1];
    [pauliX addObject:jedan AtRow:1 Column:0];
    [pauliX addObject:nula AtRow:1 Column:1];
    
    [pauliY addObject:nula AtRow:0 Column:0];
    [pauliY addObject:minusI AtRow:0 Column:1];
    [pauliY addObject:iBroj AtRow:1 Column:0];
    [pauliY addObject:nula AtRow:1 Column:1];
    
    [pauliZ addObject:jedan AtRow:0 Column:0];
    [pauliZ addObject:nula AtRow:0 Column:1];
    [pauliZ addObject:nula AtRow:1 Column:0];
    [pauliZ addObject:minusJedan AtRow:1 Column:1];
    
    [hadamard addObject:jedanZaHadamard AtRow:0 Column:0];
    [hadamard addObject:jedanZaHadamard AtRow:0 Column:1];
    [hadamard addObject:jedanZaHadamard AtRow:1 Column:0];
    [hadamard addObject:minusJedanZaHad AtRow:1 Column:1];
    
    [cnot addObject:jedan AtRow:0 Column:0];
    [cnot addObject:nula AtRow:0 Column:1];
    [cnot addObject:nula AtRow:0 Column:2];
    [cnot addObject:nula AtRow:0 Column:3];
    [cnot addObject:nula AtRow:1 Column:0];
    [cnot addObject:jedan AtRow:1 Column:1];
    [cnot addObject:nula AtRow:1 Column:2];
    [cnot addObject:nula AtRow:1 Column:3];
    [cnot addObject:nula AtRow:2 Column:0];
    [cnot addObject:nula AtRow:2 Column:1];
    [cnot addObject:nula AtRow:2 Column:2];
    [cnot addObject:jedan AtRow:2 Column:3];
    [cnot addObject:nula AtRow:3 Column:0];
    [cnot addObject:nula AtRow:3 Column:1];
    [cnot addObject:jedan AtRow:3 Column:2];
    [cnot addObject:nula AtRow:3 Column:3];
    return self;
}

-(void)applayPauliXOnNoOfBits:(int)b{
    if(b==0){
		if(operacijaBr == 0){
			[self swap];
			Complex *zaRelease = [original objectAtIndex:radnoStanje];
			[original replaceObjectAtIndex:radnoStanje withObject:[kopijaStanja objectAtIndex:[self convertStanjeToInt]]];
			radnoStanje++;
			[zaRelease release];
		}
		else {
			[self swap];
			[original replaceObjectAtIndex:radnoStanje withObject:[kopijaStanja objectAtIndex:[self convertStanjeToInt]]];
			radnoStanje++;
			
		}

    }
    
    else{
        for(int k = 0; k<2; k++){
            stanjeZaRad[b-1]=k;
            //NSLog(@"%d",k);
            [self applayPauliXOnNoOfBits:(b-1)];
        }
    }
    
}

-(void)applayPauliYOnNoOfBits:(int)b{
	if(b==0){
		if(operacijaBr == 0){
			if (stanjeZaRad[radniBit] == 0) {
				[self swap];
				Complex *rel = [original objectAtIndex:radnoStanje];
				[original replaceObjectAtIndex:radnoStanje withObject:[[kopijaStanja objectAtIndex:[self convertStanjeToInt]]product:[pauliY getOojectAtRow:0 Column:1]]];
				radnoStanje++;
				[rel release];
			}
			else {
				[self swap];
				Complex *rel = [original objectAtIndex:radnoStanje];
				[original replaceObjectAtIndex:radnoStanje withObject:[[kopijaStanja objectAtIndex:[self convertStanjeToInt]]product:[pauliY getOojectAtRow:1 Column:0]]];
				radnoStanje++;
				[rel release];
			}
		}
		else{
			if (stanjeZaRad[radniBit] == 0) {
				[self swap];
				[original replaceObjectAtIndex:radnoStanje withObject:[[kopijaStanja objectAtIndex:[self convertStanjeToInt]]product:[pauliY getOojectAtRow:0 Column:1]]];
				radnoStanje++;
			}
			else {
				[self swap];
				[original replaceObjectAtIndex:radnoStanje withObject:[[kopijaStanja objectAtIndex:[self convertStanjeToInt]]product:[pauliY getOojectAtRow:1 Column:0]]];
				radnoStanje++;
			}
		}

    }
    
    else{
        for(int k = 0; k<2; k++){
            stanjeZaRad[b-1]=k;
            //NSLog(@"%d",k);
            [self applayPauliYOnNoOfBits:(b-1)];
        }
    }
}

-(void)applayPauliZOnNoOfBits:(int)b{
	if (b==0) {
		if(!wasDone[radnoStanje]){
            [self dobiSvaStanjaZaJedanBit];
            NSMutableArray *zaProizvod = [[NSMutableArray alloc] initWithCapacity:2];
            for(int r = 0;r<2;r++){
                [zaProizvod insertObject:[Complex brojIstiZaBr:[original objectAtIndex:brojStanjaZaDvaQbita[r]]] atIndex:r];
            }
            NSMutableArray *rezultat=[Matrix product:pauliZ withOneRow:zaProizvod sizeOfRow:2];
			for (int i = 1; i>=0; i--) {
				Complex *relisic = [zaProizvod objectAtIndex:i];
				[zaProizvod removeLastObject];
				[relisic release];
			}
            [zaProizvod release];
			
			if(operacijaBr == 0){
				for(int j = 0; j < 2; j++){
					Complex *rel = [original objectAtIndex:brojStanjaZaDvaQbita[j]];
					Complex *rels = [rezultat objectAtIndex:j];
					[original replaceObjectAtIndex:brojStanjaZaDvaQbita[j] withObject:[rezultat objectAtIndex:j]];
					wasDone[brojStanjaZaDvaQbita[j]]=YES;
					[rel release];
					[rels release];
				}
			}
			else {
				for(int j = 0; j < 2; j++){
					Complex *rel = [rezultat objectAtIndex:j];
					[original replaceObjectAtIndex:brojStanjaZaDvaQbita[j] withObject:[rezultat objectAtIndex:j]];
					wasDone[brojStanjaZaDvaQbita[j]]=YES;
					[rel release];
				}
			}
			[rezultat release];
        }
        radnoStanje++;
	}
	else {
		for(int k = 0; k<2; k++){
            stanjeZaRad[b-1]=k;
            //NSLog(@"%d",k);
            [self applayPauliZOnNoOfBits:(b-1)];
        }
	}

}

-(void)applayControledNotOnNoOfBits:(int)b{
	if (b==0) {
		if(!wasDone[radnoStanje]){
            [self dobiBrojStanja];
            NSMutableArray *zaProizvod = [[NSMutableArray alloc] initWithCapacity:4];
            for(int r = 0;r<4;r++){
                [zaProizvod insertObject:[Complex brojIstiZaBr:[original objectAtIndex:brojStanjaZaDvaQbita[r]]] atIndex:r];
            }
            NSMutableArray *rezultat=[Matrix product:cnot withOneRow:zaProizvod sizeOfRow:4];
			for (int i = 3; i>=0; i--) {
				Complex *relisic = [zaProizvod objectAtIndex:i];
				[zaProizvod removeLastObject];
				[relisic release];
			}
            [zaProizvod release];
			
			if(operacijaBr == 0){
				for(int j = 0; j < 4; j++){
					Complex *rel = [original objectAtIndex:brojStanjaZaDvaQbita[j]];
					Complex *rels = [rezultat objectAtIndex:j];
					[original replaceObjectAtIndex:brojStanjaZaDvaQbita[j] withObject:[rezultat objectAtIndex:j]];
					wasDone[brojStanjaZaDvaQbita[j]]=YES;
					[rel release];
					[rels release];
				}
			}
			else {
				for(int j = 0; j < 4; j++){
					Complex *rel = [rezultat objectAtIndex:j];
					[original replaceObjectAtIndex:brojStanjaZaDvaQbita[j] withObject:[rezultat objectAtIndex:j]];
					wasDone[brojStanjaZaDvaQbita[j]]=YES;
					[rel release];
				}
			}
			[rezultat release];
        }
        radnoStanje++;
	}
    else{
        for(int k = 0; k<2; k++){
            stanjeZaRad[b-1]=k;
            [self applayControledNotOnNoOfBits:(b-1)];
        }
    }
}

-(void)applayHadamaradOnNoOfBits:(int)b{
    if(b==0){
        if(stanjeZaRad[radniBit] == 0){
            [[original objectAtIndex:radnoStanje] product:[hadamard getOojectAtRow:0 Column:0]];
            [self swap];
            [[original objectAtIndex:radnoStanje] add:[[kopijaStanja objectAtIndex:[self convertStanjeToInt]]product:[hadamard getOojectAtRow:0 Column:0]]];
        }
        else{
            [[original objectAtIndex:radnoStanje] product:[hadamard getOojectAtRow:1 Column:1]];
            [self swap];
            [[original objectAtIndex:radnoStanje] add:[[kopijaStanja objectAtIndex:[self convertStanjeToInt]]product:[hadamard getOojectAtRow:0 Column:0]]];
            
        }
		radnoStanje++;
        
    }
    
    else{
        for(int k = 0; k<2; k++){
            stanjeZaRad[b-1]=k;
            //NSLog(@"%d",k);
            [self applayHadamaradOnNoOfBits:(b-1)];
        }
    }
}

-(void)applayAnyUnitarOperationOnTwoBits:(int)b{
	if (b==0) {
		if(!wasDone[radnoStanje]){
            [self dobiBrojStanja];
            NSMutableArray *zaProizvod = [[NSMutableArray alloc] initWithCapacity:4];
            for(int r = 0;r<4;r++){
                [zaProizvod insertObject:[Complex brojIstiZaBr:[original objectAtIndex:brojStanjaZaDvaQbita[r]]] atIndex:r];
            }
            NSMutableArray *rezultat=[Matrix product:anyUnitary withOneRow:zaProizvod sizeOfRow:4];
			for (int i = 3; i>=0; i--) {
				Complex *relisic = [zaProizvod objectAtIndex:i];
				[zaProizvod removeLastObject];
				[relisic release];
			}
            [zaProizvod release];
			
			if(operacijaBr == 0){
				for(int j = 0; j < 4; j++){
					Complex *rel = [original objectAtIndex:brojStanjaZaDvaQbita[j]];
					Complex *rels = [rezultat objectAtIndex:j];
					[original replaceObjectAtIndex:brojStanjaZaDvaQbita[j] withObject:[rezultat objectAtIndex:j]];
					wasDone[brojStanjaZaDvaQbita[j]]=YES;
					[rel release];
					[rels release];
				}
			}
			else {
				for(int j = 0; j < 4; j++){
					Complex *rel = [rezultat objectAtIndex:j];
					[original replaceObjectAtIndex:brojStanjaZaDvaQbita[j] withObject:[rezultat objectAtIndex:j]];
					wasDone[brojStanjaZaDvaQbita[j]]=YES;
					[rel release];
				}
			}
			[rezultat release];
        }
        radnoStanje++;
	}
    else{
        for(int k = 0; k<2; k++){
            stanjeZaRad[b-1]=k;
            [self applayAnyUnitarOperationOnTwoBits:(b-1)];
        }
    }
}

-(void)applayAnyUintaryOperationOnOneBit:(int)b{
    if (b==0) {
		if(!wasDone[radnoStanje]){
            [self dobiSvaStanjaZaJedanBit];
            NSMutableArray *zaProizvod = [[NSMutableArray alloc] initWithCapacity:2];
            for(int r = 0;r<2;r++){
                [zaProizvod insertObject:[Complex brojIstiZaBr:[original objectAtIndex:brojStanjaZaDvaQbita[r]]] atIndex:r];
            }
            NSMutableArray *rezultat=[Matrix product:anyUnitary withOneRow:zaProizvod sizeOfRow:2];
			for (int i = 1; i>=0; i--) {
				Complex *relisic = [zaProizvod objectAtIndex:i];
				[zaProizvod removeLastObject];
				[relisic release];
			}
            [zaProizvod release];
			
			if(operacijaBr == 0){
				for(int j = 0; j < 2; j++){
					Complex *rel = [original objectAtIndex:brojStanjaZaDvaQbita[j]];
					Complex *rels = [rezultat objectAtIndex:j];
					[original replaceObjectAtIndex:brojStanjaZaDvaQbita[j] withObject:[rezultat objectAtIndex:j]];
					wasDone[brojStanjaZaDvaQbita[j]]=YES;
					[rel release];
					[rels release];
				}
			}
			else {
				for(int j = 0; j < 2; j++){
					Complex *rel = [rezultat objectAtIndex:j];
					[original replaceObjectAtIndex:brojStanjaZaDvaQbita[j] withObject:[rezultat objectAtIndex:j]];
					wasDone[brojStanjaZaDvaQbita[j]]=YES;
					[rel release];
				}
			}
			[rezultat release];
        }
        radnoStanje++;
	}
    else{
        for(int k = 0; k<2; k++){
            stanjeZaRad[b-1]=k;
            [self applayAnyUintaryOperationOnOneBit:(b-1)];
        }
    }
}

-(int)convertStanjeToInt{
    int d = 1;
    int p = 0;
    for(int b = 0 ;b < 10;b++){
        p = p + kopijaStanjeZaRad[b]*d;
        d = d*2;
    }
    return p;
}

-(void)kopirajStanja{
    if(kopijaStanja){
		for (int a = ([qComp brStanja] - 1); a>=0; a--) {
			Complex *reeasBr = [kopijaStanja objectAtIndex:a];
			[kopijaStanja removeLastObject];
			[reeasBr release];
		}
		[kopijaStanja release];
	}
    kopijaStanja = [[NSMutableArray alloc] initWithCapacity:[qComp brStanja]];
    original = [qComp sistem];
    
    for(int i = 0; i < [qComp brStanja]; i++){
        [kopijaStanja insertObject:[Complex brojIstiZaBr:[original objectAtIndex:i]] atIndex:i];
    }
    
}

-(void)swap{
    for(int i = 0; i<10; i++){
        kopijaStanjeZaRad[i]= stanjeZaRad[i];
    }
    if(kopijaStanjeZaRad[radniBit]==0){
        kopijaStanjeZaRad[radniBit]=1;
    }
    else{
        kopijaStanjeZaRad[radniBit]=0;
    }
    
}

-(void)newOperation{
	original = [qComp sistem];
    [self kopirajStanja];
    radnoStanje = 0;
    for(int i = 0;i<1024;i++){
        wasDone[i]=NO;
    }
	brojacZaFurija = 0;
    isDoneOperating = NO;
}

-(void)dobiSvaStanja{
    for(int a =0;a<4;a++){
        for(int i = 0; i<10; i++){
            stanjaZaDvaQBita[a][i]= stanjeZaRad[i];
        }
    }
    int c=0;
    for(int a = 0; a<2; a++){
        for(int b = 0;b<2;b++){
            stanjaZaDvaQBita[c][kontrolniBit]=a;
            stanjaZaDvaQBita[c][radniBit]=b;
            c++;
        }
    }
}

-(void)dobiSvaStanjaZaJedanBit{
    for(int a = 0;a < 2;a++){
        for(int i = 0; i<10; i++){
            stanjaZaDvaQBita[a][i]= stanjeZaRad[i];
        }
    }
    int c=0;
    for(int b = 0; b < 2;b++){
        stanjaZaDvaQBita[c][radniBit]=b;
        c++;
    }
	
	for(int x = 0; x < 2; x++){
        int d = 1;
        int p = 0;
        for(int b = 0 ;b < 10;b++){
            p = p + stanjaZaDvaQBita[x][b]*d;
            d = d*2;
        }
        brojStanjaZaDvaQbita[x]=p;
    }
}

-(void)dobiBrojStanja{
    [self dobiSvaStanja];
    for(int x = 0; x < 4; x++){
        int d = 1;
        int p = 0;
        for(int b = 0 ;b < 10;b++){
            p = p + stanjaZaDvaQBita[x][b]*d;
            d = d*2;
        }
        brojStanjaZaDvaQbita[x]=p;
    }
    
}

- (void)setAnyUnitary:(Matrix *)aMatrix{
    anyUnitary = aMatrix;
}

- (void)dealloc {
	//for (int i = pow(2, [qComp brqBita]) - 1; i>=0; i--) {
		//Complex *broj = [original objectAtIndex:i];
		//[original removeLastObject];
		//if(!(broj == nil)) {
          //  [broj release];
      //  }
	//}
	for (int i = pow(2, [qComp brqBita]) - 1; i>=0; i--) {
		Complex *broj = [kopijaStanja objectAtIndex:i];
		[kopijaStanja removeLastObject];
		[broj release];
	}
	[cnot release];
	[pauliX release];
    [pauliY release];
    [pauliZ release];
    [hadamard release];
	[nula release];
	[jedan release];
	[minusJedan release];
	[iBroj release];
	[minusI release];
	[jedanZaHadamard release];
	[minusJedanZaHad release];
    [kopijaStanja release];
    //[original release];
    [super dealloc];
}

-(void)fourierTransformacijaNaSvimBitima:(int)b{
    
    int brBita = [qComp brqBita];
    int bStanja = pow(2, brBita);
    
    //Complex *jedan = [[Complex alloc] initWithReal:1.00 andImaginary:0.00];
    Complex *dvaPi = [[Complex alloc] initWithReal:2*k_Pi andImaginary:0.00];
    Complex *brI = [[Complex alloc] initWithReal:0.00 andImaginary:1.00];
    Complex *brStanja = [[Complex alloc] initWithReal:bStanja andImaginary:0.00];
    Complex *kornBrS = [[Complex alloc] initWithReal:1/sqrtf(bStanja) andImaginary:0.00];
    
    for(int a = 0;a<bStanja;a++){
        //Complex *zaOtpustiti = [original objectAtIndex:a];
        [original replaceObjectAtIndex:a withObject:[Complex brojIstiZaBr:nula]];
        Complex *eNaEx;
        for(int b = 0; b < bStanja; b++){
            Complex *eEksponent = [Complex brojIstiZaBr:dvaPi];
            [eEksponent product:brI];
			Complex *brZaA = [[Complex alloc] initWithReal:a*b andImaginary:0.00];
			[eEksponent product: brZaA];
            [eEksponent devide: brStanja];
            float iOdEx = [eEksponent imaginary];
            float nowR = cosf(iOdEx);
            float nowI = sinf(iOdEx);
            
            eNaEx = [[Complex alloc] initWithReal:nowR andImaginary:nowI];
            [eNaEx product:[kopijaStanja objectAtIndex:b]];
            [[original objectAtIndex:a] add:eNaEx];
            [eNaEx release];
			[brZaA release];

        }
        [[original objectAtIndex:a]product:kornBrS];
		float relic = [[original objectAtIndex:a] real];
		float imag = [[original objectAtIndex:a] imaginary];
		relic = absfdd(relic);
		imag = absfdd(imag);
		if(relic<0.0001 && imag<0.0001){
			[[original objectAtIndex:a] setReal:0.00];
			[[original objectAtIndex:a] setImaginary:0.00];
		}
    }
    isDoneOperating = YES;
    [screenObject gotovaFurieva];
    [dvaPi release];
    [brI release];
    [brStanja release];
    [kornBrS release];
}
-(void)inverznaFurTransf:(int)b{
	int brBita = [qComp brqBita];
    int bStanja = pow(2, brBita);
    
    //Complex *jedan = [[Complex alloc] initWithReal:1.00 andImaginary:0.00];
    Complex *dvaPi = [[Complex alloc] initWithReal:-2*k_Pi andImaginary:0.00];
    Complex *brI = [[Complex alloc] initWithReal:0.00 andImaginary:1.00];
    Complex *brStanja = [[Complex alloc] initWithReal:bStanja andImaginary:0.00];
    Complex *kornBrS = [[Complex alloc] initWithReal:1/sqrtf(bStanja) andImaginary:0.00];
    
    for(int a = 0;a<bStanja;a++){
        //Complex *zaOtpustiti = [original objectAtIndex:a];
        [original replaceObjectAtIndex:a withObject:[Complex brojIstiZaBr:nula]];
        //[zaOtpustiti release];
        Complex *eNaEx;
        for(int b = 0; b < bStanja; b++){
            Complex *eEksponent = [Complex brojIstiZaBr:dvaPi];
            [eEksponent product:brI];
            //[eEksponent product:[kopijaStanja objectAtIndex:a]];
			Complex *brZaA = [[Complex alloc] initWithReal:a*b andImaginary:0.00];
			[eEksponent product: brZaA];
            //[eEksponent product:[kopijaStanja objectAtIndex:b]];
            [eEksponent devide: brStanja];
            float iOdEx = [eEksponent imaginary];
            
            float nowR = cosf(iOdEx);
            float nowI = sinf(iOdEx);
            
            eNaEx = [[Complex alloc] initWithReal:nowR andImaginary:nowI];
            [eNaEx product:[kopijaStanja objectAtIndex:b]];
            [[original objectAtIndex:a] add:eNaEx];
            [eNaEx release];
			[brZaA release];
        }
        [[original objectAtIndex:a]product:kornBrS];
		float relic = [[original objectAtIndex:a] real];
		float imag = [[original objectAtIndex:a] imaginary];
		relic = absfdd(relic);
		imag = absfdd(imag);
		if(relic<0.0001 && imag<0.0001){
			[[original objectAtIndex:a] setReal:0.00];
			[[original objectAtIndex:a] setImaginary:0.00];
		}
    }
    [dvaPi release];
    [brI release];
    [brStanja release];
    [kornBrS release];
}
float absfdd(float x){
	if (x<0) {
		x=-x;
	}
	return x;
}
-(void)furiZaNekeBite:(int)b jePrviPut:(BOOL)buli{
	if (b==0) {
		if (!wasDone[radnoStanje]) {
			[self dobiStanjaZaFurija:10];
			[self brojeviStanjaZaFurija];
			
			Complex *dvaPi = [[Complex alloc] initWithReal:2*k_Pi andImaginary:0.00];
			Complex *brI = [[Complex alloc] initWithReal:0.00 andImaginary:1.00];
			Complex *brStanja = [[Complex alloc] initWithReal:brojStanjaZaJedanCiklus andImaginary:0.00];
			Complex *kornBrS = [[Complex alloc] initWithReal:1/sqrtf(brojStanjaZaJedanCiklus) andImaginary:0.00];
			
			for(int a = 0; a < brojStanjaZaJedanCiklus;a++){
				//Complex *zaOtpustiti = [original objectAtIndex:a];
				[original replaceObjectAtIndex:brStanjaZaFurija[a] withObject:[Complex brojIstiZaBr:nula]];
				Complex *eNaEx = [[Complex alloc] init];
                Complex *brZaA = [[Complex alloc] init];
				for(int b = 0; b < brojStanjaZaJedanCiklus; b++){
					Complex *eEksponent = [Complex brojIstiZaBr:dvaPi];
					[eEksponent product:brI];
                    [brZaA setReal:a*b andImaginary:0.00];
					[eEksponent product: brZaA];
					[eEksponent devide: brStanja];
					float iOdEx = [eEksponent imaginary];
					float nowR = cosf(iOdEx);
					float nowI = sinf(iOdEx);
					
					[eNaEx setReal:nowR andImaginary:nowI];
					[eNaEx product:[kopijaStanja objectAtIndex:brStanjaZaFurija[b]]];
					[[original objectAtIndex:brStanjaZaFurija[a]] add:eNaEx];
				}
				[[original objectAtIndex:brStanjaZaFurija[a]]product:kornBrS];
				float relic = [[original objectAtIndex:brStanjaZaFurija[a]] real];
				float imag = [[original objectAtIndex:brStanjaZaFurija[a]] imaginary];
				relic = absfdd(relic);
				imag = absfdd(imag);
				if(relic<0.0001 && imag<0.0001){
					[[original objectAtIndex:brStanjaZaFurija[a]] setReal:0.00];
					[[original objectAtIndex:brStanjaZaFurija[a]] setImaginary:0.00];
				}
				wasDone[brStanjaZaFurija[a]]=YES;
                [eNaEx release];
                [brZaA release];
			}
			[dvaPi release];
			[brI release];
			[brStanja release];
			[kornBrS release];
			
		}
		radnoStanje++;
		
	}
	else {
		for (int k = 0; k<2; k++) {
			stanjeZaRad[b-1]=k;
			[self furiZaNekeBite:(b-1) jePrviPut:NO];
		}
	}
    //if(buli){
        //[screenObject gotovaFurieva];
    //}

}
-(void)dobiStanjaZaFurija:(int)b{
	if (b == 0) {
		for (int z = 0; z < 10; z++) {
			stanjaZaFurijevu[brojacZaFurija][z]=zaDobijanjeStanja[z];
		}
		brojacZaFurija++;
	}
	else {
		if (isRadniBitiVise[b-1]) {
			for (int k = 0; k < 2; k++) {
				zaDobijanjeStanja[b-1]=k;
				[self dobiStanjaZaFurija:b-1];
			}
		}
		else {
			zaDobijanjeStanja[b-1]=stanjeZaRad[b-1];
			[self dobiStanjaZaFurija:b-1];
		}

	}

}
-(void)pripremaZaFurija{
	int d = 0;
	for (int a = 0; a<10; a++) {
		if (isRadniBitiVise[a]) {
			d++;
		}
	}
	brojStanjaZaJedanCiklus = pow(2, d);
}
-(void)brojeviStanjaZaFurija{
	for (int q = 0; q<brojStanjaZaJedanCiklus; q++) {
		int a = 1;
		int b = 0;
		for (int c = 0; c < 10; c++) {
			b = b + stanjaZaFurijevu[q][c]*a;
			a=a*2;
		}
		brStanjaZaFurija[q]=b;
	}
}
-(void)fTest{
	NSAutoreleasePool *bazen = [[NSAutoreleasePool alloc] init];
	[self pripremaZaFurija];
	int brojBita=0;
	for (int i = 0; i<=10; i++) {
		if (isRadniBitiVise[i]) {
			brojBita++;
		}
	}
	
	[self furiZaNekeBite:brojBita jePrviPut:YES];
	[screenObject gotovaFurieva];
	[bazen drain];
}
-(void)setIsRadniBitVise:(BOOL)b atIndex:(int)i{
    isRadniBitiVise[i]=b;
}
@end
