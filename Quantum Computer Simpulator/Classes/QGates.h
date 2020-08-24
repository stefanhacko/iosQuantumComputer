//
//  QGates.h
//  Quantum Computer Simpulator
//
//  Created by Stefan Hacko on 1/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "QComputer.h"
#import "Matrix.h"
#import "Quantum_Computer_SimpulatorViewController.h"

@class QComputer;
@class Quantum_Computer_SimpulatorViewController;

@interface QGates : NSObject {
    //Za dva
    int brojStanjaZaDvaQbita[4];
    int stanjaZaDvaQBita[4][10];
    //Za jedan
    int stanjeZaRad[10];
    int kopijaStanjeZaRad[10];
    
    int radnoStanje;
	int operacijaBr;
    int radniBit;
    int kontrolniBit;
    BOOL wasDone[1024];
    NSMutableArray *kopijaStanja;
    NSMutableArray *original;
    QComputer *qComp;
    Matrix *anyUnitary;
    Matrix *pauliX;
    Matrix *pauliY;
    Matrix *pauliZ;
    Matrix *hadamard;
    Matrix *cnot;
	
	//Brojevi
	Complex *nula;    
	Complex *jedan;
    Complex *minusJedan;
    Complex *iBroj;
    Complex *minusI;
    Complex *jedanZaHadamard;
    Complex *minusJedanZaHad;
	
	//Stanja za furijevu
	int stanjaZaFurijevu[1024][10];
	int brStanjaZaFurija[1024];
	BOOL isRadniBitiVise[10];
	int zaDobijanjeStanja[10];
	int brojacZaFurija;
	int brojStanjaZaJedanCiklus;
    BOOL isDoneOperating;
    
    Quantum_Computer_SimpulatorViewController *screenObject;
}
@property (nonatomic, retain) Quantum_Computer_SimpulatorViewController *screenObject;
@property int radniBit, kontrolniBit, operacijaBr;
@property BOOL isDoneOperating;

-(int)convertStanjeToInt;
-(QGates *)initWithComputer:(QComputer *)comp;
-(void)swap;
-(void)dobiBrojStanja;
-(void)dobiSvaStanja;
-(void)dobiSvaStanjaZaJedanBit;
-(void)newOperation;
-(void)kopirajStanja;
-(void)applayPauliXOnNoOfBits:(int)b;
-(void)applayPauliYOnNoOfBits:(int)b;
-(void)applayPauliZOnNoOfBits:(int)b;
-(void)applayHadamaradOnNoOfBits:(int)b;
-(void)applayControledNotOnNoOfBits:(int)b;
-(void)applayAnyUnitarOperationOnTwoBits:(int)b;
-(void)applayAnyUintaryOperationOnOneBit:(int)b;
-(void)setAnyUnitary:(Matrix *)aMatrix;
-(void)fourierTransformacijaNaSvimBitima:(int)b;
-(void)inverznaFurTransf:(int)b;
-(void)furiZaNekeBite:(int)b jePrviPut:(BOOL)buli;
-(void)pripremaZaFurija;
-(void)dobiStanjaZaFurija:(int)b;
-(void)brojeviStanjaZaFurija;
-(void)fTest;
-(void)setIsRadniBitVise:(BOOL)b atIndex:(int)i;
@end
