//
//  Quantum_Computer_SimpulatorViewController.h
//  Quantum Computer Simpulator
//
//  Created by Stefan Hacko on 1/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QComputer.h"
#import "QBits.h"
#import "Matrix.h"
#import "QGates.h"
#import "Complex.h"
#import "AlertWithText.h"
@class QComputer;
@class QGates;
@interface Quantum_Computer_SimpulatorViewController : UIViewController <UITableViewDataSource,UITableViewDelegate> {
    //Za Grafiku
    IBOutlet UIView *stanjaEkran;
    UIView *setBits;
    UIView *applayOperation;
    UITableView *tabelaOperacija;
    UIView *working;
    UIActivityIndicatorView *aktivnost;
	NSMutableArray *pikseli;
    NSMutableArray *lblZaSetStanja;
    NSMutableArray *switchZaStanja;
    UIButton *startSimulator;
	
	//Ostalo
	QComputer *computer;
    QGates *gateovi;
    NSMutableArray *ugloviFi;
    int noOfBits;
    int trenutno;
    UIButton *tastatura;
    BOOL isFirstOp;
    
    //Za listu operacija
    UIView *operationList;
    NSMutableArray *imenaOperacija;
    int brojOperacija;
    int operationNumber[300];
    int operationBit[300];
    int controlBit[300];
    short int indeks;
    UISegmentedControl *qBitZaOperaciju;
    UISegmentedControl *kontrolniqBit;
    UILabel *imeOperacije;
    UIView *rotacija;
    BOOL firstSet;
    
    //Rotacija
    int osa[300];
    float ugao[300];
    UISegmentedControl *osaRotacije;
    UITextField *ugaoURad;
    
    //Any unytary
    float brojeviZapatricu[300][4];
    float imaginarniDeoZaMat[300][4];
    UIView *customMat;
    UITextField *jedan;
    UITextField *dva;
    UITextField *tri;
    UITextField *cetiri;
    UITextField *iJedan;
    UITextField *iDva;
    UITextField *iTri;
    UITextField *iCetiri;
    
    //Za cuvanje i ucitavanje
    UITextField *imeListeOperacija;
    UIView *cuvanjeListe;
    UIView *loadListView;
    UITableView *tabelaLoad;
    
    //Furi
    BOOL selektovanBit[300][10];
    UIView *fouri;
    UITextField *bitiZaFTransf;
}
@property (nonatomic, retain) IBOutlet UITableView *tabelaLoad;
@property (nonatomic, retain) IBOutlet UIView *loadListView;
@property (nonatomic, retain) IBOutlet UIView *cuvanjeListe;
@property (nonatomic, retain) IBOutlet UITextField *imeListeOperacija;
@property (nonatomic, retain) IBOutlet UITextField *iCetiri;
@property (nonatomic, retain) IBOutlet UITextField *iTri;
@property (nonatomic, retain) IBOutlet UITextField *iDva;
@property (nonatomic, retain) IBOutlet UITextField *iJedan;
@property (nonatomic, retain) IBOutlet UITextField *cetiri;
@property (nonatomic, retain) IBOutlet UITextField *tri;
@property (nonatomic, retain) IBOutlet UITextField *dva;
@property (nonatomic, retain) IBOutlet UITextField *jedan;
@property (nonatomic, retain) IBOutlet UIView *customMat;
@property (nonatomic, retain) IBOutlet UILabel *imeOperacije;
@property (nonatomic, retain) IBOutlet UITextField *ugaoURad;
@property (nonatomic, retain) IBOutlet UISegmentedControl *osaRotacije;
@property (nonatomic, retain) IBOutlet UIView *rotacija;
@property (nonatomic, retain) IBOutlet UISegmentedControl *qBitZaOperaciju;
@property (nonatomic, retain) IBOutlet UISegmentedControl *kontrolniqBit;
@property (nonatomic, retain) IBOutlet UIView *operationList;
@property (nonatomic, retain) IBOutlet UIView *stanjaEkran;
@property (nonatomic, retain) IBOutlet UIView *setBits;
@property (nonatomic, retain) IBOutlet UIView *applayOperation;
@property (nonatomic, retain) IBOutlet UITableView *tabelaOperacija;
@property (nonatomic, retain) IBOutlet UIView *working;
@property (nonatomic, retain) IBOutlet UIView *fouri;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *aktivnost;
@property (nonatomic, retain) IBOutlet UITextField *bitiZaFTransf;

- (IBAction)restartFromSetBits:(id)sender;
- (IBAction)backIzLoad:(id)sender;
- (IBAction)backFromMatrix:(id)sender;
- (IBAction)nextOperation:(id)sender;
- (IBAction)resetList:(id)sender;
- (IBAction)backToApplayOp:(id)sender;
- (IBAction)matrixDone:(id)sender;
- (UIColor *)getColor;
- (void)startComputer;
- (void)refreshScreen;
- (void)setScreen;
- (void)ucitajIzFajlaAtIndex:(int)a;
- (NSString *)getSlovo;
- (IBAction)test;
- (IBAction)startSimulatorFromSetBits;
- (IBAction)restart:(id)sender;
- (IBAction)tastatura:(id)sender;
- (IBAction)undo:(id)sender;
- (IBAction)newOperation:(id)sender;
- (void)applayOperation:(int)o onBit:(int)z controlBit:(int)c;
- (IBAction)applayRotation:(id)sender;
- (IBAction)systemVector:(id)sender;
- (IBAction)backToTable:(id)sender;
- (IBAction)selectOperation:(id)sender;
- (IBAction)sacuvajListu:(id)sender;
- (IBAction)backIzCuvanja:(id)sender;
- (IBAction)ucitajListu:(id)sender;
- (void)stardovanjeAuto;
- (void)workingScreen;
- (IBAction)applayFTransform:(id)sender;
- (void)gotovaFurieva;
- (void)dobiSveNazive;
@end
