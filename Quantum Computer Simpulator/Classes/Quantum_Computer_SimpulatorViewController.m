//
//  Quantum_Computer_SimpulatorViewController.m
//  Quantum Computer Simpulator
//
//  Created by Stefan Hacko on 1/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Quantum_Computer_SimpulatorViewController.h"
#define k_PI 3.14159

@implementation Quantum_Computer_SimpulatorViewController

@synthesize tabelaLoad;
@synthesize loadListView;
@synthesize cuvanjeListe;
@synthesize imeListeOperacija;
@synthesize iCetiri;
@synthesize iTri;
@synthesize iDva;
@synthesize iJedan;
@synthesize cetiri;
@synthesize tri;
@synthesize dva;
@synthesize jedan;
@synthesize customMat;
@synthesize imeOperacije;
@synthesize ugaoURad;
@synthesize osaRotacije;
@synthesize rotacija;
@synthesize qBitZaOperaciju;
@synthesize kontrolniqBit;
@synthesize operationList;
@synthesize stanjaEkran;
@synthesize setBits;
@synthesize applayOperation;
@synthesize tabelaOperacija;
@synthesize working;
@synthesize fouri;
@synthesize aktivnost;
@synthesize bitiZaFTransf;

-(void)startComputer{
    computer = [QComputer alloc];
    [computer initWithNoOfBits:noOfBits];
    
    [computer start];
    
}

-(void)setScreen{
    //test
    pikseli = [[NSMutableArray alloc] initWithCapacity:[computer brStanja]];
    
    ugloviFi = [computer ugloviFi];
    
    for(int c = 0; c<32; c++){
        for (int d = 0; d<32;d++){
            
            if([computer stanjeJeNula:trenutno]){
                UILabel *lbl1 = [[UILabel alloc] initWithFrame:CGRectMake(d*10, c*10, 10, 10)];
                lbl1.backgroundColor = [UIColor colorWithHue:0 saturation:100 brightness:0 alpha:1];
                
                [self.view addSubview:lbl1];
                
                [pikseli insertObject:lbl1 atIndex:trenutno];
            }
            else{
                UILabel *lbl1 = [[UILabel alloc] initWithFrame:CGRectMake(d*10, c*10, 10, 10)];
                lbl1.backgroundColor = [self getColor];
                
                [self.view addSubview:lbl1];
                
                [pikseli insertObject:lbl1 atIndex:trenutno];
            }
            
            trenutno ++;
        }
    }
}

-(IBAction)test{
	gateovi = [[QGates alloc] initWithComputer:computer];
    [gateovi setRadniBit:4];
    [gateovi newOperation];
    [gateovi applayHadamaradOnNoOfBits:noOfBits];
    
    [gateovi newOperation];
    [gateovi setKontrolniBit:4];
    [gateovi setRadniBit:0];
    [gateovi applayControledNotOnNoOfBits:noOfBits];
	
    
    [self refreshScreen];
}


- (IBAction)restartFromSetBits:(id)sender {
    for(int i = 0; i < noOfBits;i++){
        UISegmentedControl *radni = [switchZaStanja objectAtIndex:i];
        if(radni.selectedSegmentIndex==1){
            Complex *jedanBr = [[Complex alloc] initWithReal:1.00 andImaginary:0.00];
            Complex *nula = [[Complex alloc] initWithReal:0.00 andImaginary:0.00];
			Complex *rel0 = [[computer bitBr:i] zeroState];
			Complex *rel1 = [[computer bitBr:i] oneState];
            [[computer bitBr:i] setStates:nula :jedanBr];
			
			[rel0 release];
			[rel1 release];
        }
    }
    [gateovi release];
	[computer release];
	self.view=operationList;
    
}

- (IBAction)backIzLoad:(id)sender {
	self.view=operationList;
}

- (IBAction)backFromMatrix:(id)sender {
    self.view = applayOperation;
    NSString *raRele = [imenaOperacija objectAtIndex:indeks];
    NSString *nova = [[NSString alloc] initWithFormat:@"Set operation %d",indeks];
    [imenaOperacija replaceObjectAtIndex:indeks withObject:nova];
    [raRele release];
    
}

- (IBAction)nextOperation:(id)sender {
   if(indeks>300){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Pleas Add New Operations" message:nil delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    if([[imenaOperacija objectAtIndex:indeks]characterAtIndex:0]=='F'){
        [self applayOperation:operationNumber[indeks] onBit:operationBit[indeks] controlBit:controlBit[indeks]];
        [self workingScreen];
       
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No more operations" message:nil delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
}

- (IBAction)resetList:(id)sender {
    brojOperacija = 15;
    for(int i = 0; i < brojOperacija; i++){
		NSString *reel = [imenaOperacija objectAtIndex:i];
        NSString *naziv = [[NSString alloc] initWithFormat:@"Set operation %d",i];
        [imenaOperacija replaceObjectAtIndex:i withObject:naziv];
		[reel release];
        
    }
    [tabelaOperacija reloadData];
}

- (IBAction)backToApplayOp:(id)sender {
    self.view = applayOperation;
    NSString *raRele = [imenaOperacija objectAtIndex:indeks];
    NSString *nova = [[NSString alloc] initWithFormat:@"Set operation %d",indeks];
    [imenaOperacija replaceObjectAtIndex:indeks withObject:nova];
    [raRele release];
    
}

- (IBAction)matrixDone:(id)sender {
    self.view=applayOperation;
    brojeviZapatricu[indeks][0]=[[jedan text]floatValue];
    brojeviZapatricu[indeks][1]=[[dva text]floatValue];
    brojeviZapatricu[indeks][2]=[[tri text]floatValue];
    brojeviZapatricu[indeks][3]=[[cetiri text]floatValue];
    
    imaginarniDeoZaMat[indeks][0]=[[iJedan text]floatValue];
    imaginarniDeoZaMat[indeks][1]=[[iDva text]floatValue];
    imaginarniDeoZaMat[indeks][2]=[[iTri text]floatValue];
    imaginarniDeoZaMat[indeks][3]=[[iCetiri text]floatValue];
    
}

-(UIColor *)getColor{
    float ugaoBroja = [[ugloviFi objectAtIndex:trenutno] floatValue];
    
    ugaoBroja = ugaoBroja * (180 / k_PI);
    
    if(ugaoBroja < 0){
        ugaoBroja = ugaoBroja +360;
    }
    
    return [UIColor colorWithHue:(ugaoBroja/360) saturation:1 brightness:1 alpha:1];
}

-(void)refreshScreen{
    //[pikseli removeAllObjects];
	if (ugloviFi) {
		[ugloviFi removeAllObjects];
		[ugloviFi release];
	}
    ugloviFi = [computer ugloviFi];
    
    trenutno = 0;
    
    int d;
    for (int c = 0; c < 32; c++){
        for (d = 0; d < 32; d++){
            
            if([computer stanjeJeNula:trenutno]){
                [[pikseli objectAtIndex:trenutno] setBackgroundColor:[UIColor colorWithHue:0 saturation:100 brightness:0 alpha:1.00]];
                [self.view addSubview:[pikseli objectAtIndex:trenutno]];
                trenutno ++;
            }
            
            else{
                [[pikseli objectAtIndex:trenutno] setBackgroundColor:[self getColor]];
                [self.view addSubview:[pikseli objectAtIndex:trenutno]];
                trenutno++;
            }
            
        }
    }
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    //[self.view addSubview:self.pocetak];
	[self stardovanjeAuto];
	gateovi = [[QGates alloc] initWithComputer:computer];
    [gateovi setScreenObject:self];
    firstSet = YES;
    isFirstOp = YES;
}

-(void)applayOperation:(int)o onBit:(int)z controlBit:(int)c {
    int q = z;
	o--;
    Complex *jedanBr = [[Complex alloc] initWithReal:1.00 andImaginary:0.00];
    Complex *nula = [[Complex alloc] initWithReal:0.00 andImaginary:0.00];
    Complex *i = [[Complex alloc] initWithReal:0.00 andImaginary:1.00];
	
	if([gateovi operacijaBr]==0 && o==3){
		[gateovi setRadniBit:q];
        [gateovi newOperation];
        [gateovi applayPauliZOnNoOfBits:noOfBits];
	}
    
    if(o == 0){
        [gateovi setRadniBit:q];
        [gateovi newOperation];
        [gateovi applayPauliXOnNoOfBits:noOfBits];
    }
    else if(o == 1){
        [gateovi setRadniBit:q];
        [gateovi newOperation];
        [gateovi applayPauliYOnNoOfBits:noOfBits];
    }
    else if(o == 2){
        [gateovi setRadniBit:q];
        [gateovi newOperation];
        [gateovi applayPauliZOnNoOfBits:noOfBits];
    }
    else if(o == 3){
        [gateovi setRadniBit:q];
        [gateovi newOperation];
        [gateovi applayHadamaradOnNoOfBits:noOfBits];
    }
    else if(o == 4){
        [gateovi setRadniBit:q];
        [gateovi newOperation];
        
        Matrix *phase = [[Matrix alloc] initWithSize:2 by:2];
        [phase addObject:jedanBr AtRow:0 Column:0];
        [phase addObject:nula AtRow:0 Column:1];
        [phase addObject:nula AtRow:1 Column:0];
        [phase addObject:i AtRow:1 Column:1];
        
        [gateovi setAnyUnitary:phase];
        [gateovi applayAnyUintaryOperationOnOneBit:noOfBits];
        
        [phase release];
    }
    else if(o == 5){
        [gateovi setRadniBit:q];
        [gateovi newOperation];
        
        Matrix *piOsmina = [[Matrix alloc] initWithSize:2 by:2];
        Complex *eNaI = [[Complex alloc] initWithReal:0.707106781 andImaginary:0.707106781];
        
        [piOsmina addObject:jedanBr AtRow:0 Column:0];
        [piOsmina addObject:nula AtRow:0 Column:1];
        [piOsmina addObject:nula AtRow:1 Column:0];
        [piOsmina addObject:eNaI AtRow:1 Column:1];
        
        [gateovi setAnyUnitary:piOsmina];
        [gateovi applayAnyUintaryOperationOnOneBit:noOfBits];
        
        [piOsmina release];
		[eNaI release];
    }
    else if(o == 6){
        [gateovi setRadniBit:q];
        [gateovi setKontrolniBit:c];
        [gateovi newOperation];
        
        Matrix *controlZ = [[Matrix alloc] initWithSize:4 by:4];
        Complex *minusJedan = [[Complex alloc] initWithReal:-1.00 andImaginary:0.00];
        
        [controlZ addObject:jedanBr AtRow:0 Column:0];
        [controlZ addObject:nula AtRow:0 Column:1];
        [controlZ addObject:nula AtRow:0 Column:2];
        [controlZ addObject:nula AtRow:0 Column:3];
        [controlZ addObject:nula AtRow:1 Column:0];
        [controlZ addObject:jedanBr AtRow:1 Column:1];
        [controlZ addObject:nula AtRow:1 Column:2];
        [controlZ addObject:nula AtRow:1 Column:3];
        [controlZ addObject:nula AtRow:2 Column:0];
        [controlZ addObject:nula AtRow:2 Column:1];
        [controlZ addObject:jedanBr AtRow:2 Column:2];
        [controlZ addObject:nula AtRow:2 Column:3];
        [controlZ addObject:nula AtRow:3 Column:0];
        [controlZ addObject:nula AtRow:3 Column:1];
        [controlZ addObject:nula AtRow:3 Column:2];
        [controlZ addObject:minusJedan AtRow:3 Column:3];
        
        [gateovi setAnyUnitary:controlZ];
        [gateovi applayAnyUnitarOperationOnTwoBits:noOfBits];
        [minusJedan release];
        [controlZ release];
    }
    else if(o == 7){
        [gateovi setRadniBit:q];
        [gateovi setKontrolniBit:c];
        [gateovi newOperation];
        
        Matrix *svap= [[Matrix alloc] initWithSize:4 by:4];
        
        [svap addObject:jedanBr AtRow:0 Column:0];
        [svap addObject:nula AtRow:0 Column:1];
        [svap addObject:nula AtRow:0 Column:2];
        [svap addObject:nula AtRow:0 Column:3];
        [svap addObject:nula AtRow:1 Column:0];
        [svap addObject:nula AtRow:1 Column:1];
        [svap addObject:jedanBr AtRow:1 Column:2];
        [svap addObject:nula AtRow:1 Column:3];
        [svap addObject:nula AtRow:2 Column:0];
        [svap addObject:jedanBr AtRow:2 Column:1];
        [svap addObject:nula AtRow:2 Column:2];
        [svap addObject:nula AtRow:2 Column:3];
        [svap addObject:nula AtRow:3 Column:0];
        [svap addObject:nula AtRow:3 Column:1];
        [svap addObject:nula AtRow:3 Column:2];
        [svap addObject:jedanBr AtRow:3 Column:3];
        
        [gateovi setAnyUnitary:svap];
        [gateovi applayAnyUnitarOperationOnTwoBits:noOfBits];
        
        [svap release];
    }
    else if(o == 8){
        [gateovi setRadniBit:q];
        [gateovi setKontrolniBit:c];
        [gateovi newOperation];
        
        Matrix *controlS = [[Matrix alloc] initWithSize:4 by:4];
        
        [controlS addObject:jedanBr AtRow:0 Column:0];
        [controlS addObject:nula AtRow:0 Column:1];
        [controlS addObject:nula AtRow:0 Column:2];
        [controlS addObject:nula AtRow:0 Column:3];
        [controlS addObject:nula AtRow:1 Column:0];
        [controlS addObject:jedanBr AtRow:1 Column:1];
        [controlS addObject:nula AtRow:1 Column:2];
        [controlS addObject:nula AtRow:1 Column:3];
        [controlS addObject:nula AtRow:2 Column:0];
        [controlS addObject:nula AtRow:2 Column:1];
        [controlS addObject:jedanBr AtRow:2 Column:2];
        [controlS addObject:nula AtRow:2 Column:3];
        [controlS addObject:nula AtRow:3 Column:0];
        [controlS addObject:nula AtRow:3 Column:1];
        [controlS addObject:nula AtRow:3 Column:2];
        [controlS addObject:i AtRow:3 Column:3];
        
        [gateovi setAnyUnitary:controlS];
        [gateovi applayAnyUnitarOperationOnTwoBits:noOfBits];
        
        [controlS release];
    }
    else if(o == 9){
        [gateovi setRadniBit:q];
        [gateovi setKontrolniBit:c];
        [gateovi newOperation];
        
        [gateovi applayControledNotOnNoOfBits:noOfBits];
    }
    else if(o == 10){
        Matrix *proizvoljna = [[Matrix alloc] initWithSize:2 by:2];
        Complex *prvi = [[Complex alloc] initWithReal:brojeviZapatricu[indeks][0] andImaginary:imaginarniDeoZaMat[indeks][0]];
        Complex *drugi = [[Complex alloc] initWithReal:brojeviZapatricu[indeks][1] andImaginary:imaginarniDeoZaMat[indeks][1]];
        Complex *treci = [[Complex alloc] initWithReal:brojeviZapatricu[indeks][2] andImaginary:imaginarniDeoZaMat[indeks][2]];
        Complex *cetvrti = [[Complex alloc] initWithReal:brojeviZapatricu[indeks][3] andImaginary:imaginarniDeoZaMat[indeks][3]];
        
        [proizvoljna addObject:prvi AtRow:0 Column:0];
        [proizvoljna addObject:drugi AtRow:0 Column:1];
        [proizvoljna addObject:treci AtRow:1 Column:0];
        [proizvoljna addObject:cetvrti AtRow:1 Column:1];
        
        [gateovi setRadniBit:q];
        [gateovi setAnyUnitary:proizvoljna];
        [gateovi newOperation];
        
        [gateovi applayAnyUintaryOperationOnOneBit:noOfBits];
        
        [proizvoljna release];
        [prvi release];
        [drugi release];
        [treci release];
        [cetvrti release];
        
    }
    else if(o == 11){
        Complex *br1;
        Complex *br2;
        Complex *br3;
        Complex *br4;
        if(osa[indeks]==0){
            br1 = [[Complex alloc] initWithReal:cosf(ugao[indeks]/2) andImaginary:0.00];
            br2 = [[Complex alloc] initWithReal:0.00 andImaginary:-sinf(ugao[indeks]/2)];
            br3 = [[Complex alloc] initWithReal:-sinf(ugao[indeks]/2) andImaginary:0.00];
            br4 = [[Complex alloc] initWithReal:0.00 andImaginary:cosf(ugao[indeks]/2)];
        
        }
        else if(osa[indeks]==1){
            br1 = [[Complex alloc] initWithReal:cosf(ugao[indeks]/2) andImaginary:0.00];
            br2 = [[Complex alloc] initWithReal:-sinf(ugao[indeks]/2) andImaginary:0.00];
            br3 = [[Complex alloc] initWithReal:sinf(ugao[indeks]/2) andImaginary:0.00];
            br4 = [[Complex alloc] initWithReal:cosf(ugao[indeks]/2) andImaginary:0.00];
        }
        else if(osa[indeks]==2){
            br1 = [[Complex alloc] initWithReal:cosf(-ugao[indeks]/2) andImaginary:sinf(-ugao[indeks]/2)];
            br2 = [[Complex alloc] initWithReal:0.00 andImaginary:0.00];
            br3 = [[Complex alloc] initWithReal:0.00 andImaginary:0.00];
            br4 = [[Complex alloc] initWithReal:cosf(ugao[indeks]/2) andImaginary:sinf(ugao[indeks]/2)];
        }
        Matrix *rotaciona = [[Matrix alloc] initWithSize:2 by:2];
        
        [rotaciona addObject:br1 AtRow:0 Column:0];
        [rotaciona addObject:br2 AtRow:0 Column:1];
        [rotaciona addObject:br3 AtRow:1 Column:0];
        [rotaciona addObject:br4 AtRow:1 Column:1];
        
        [gateovi setRadniBit:q];
        [gateovi newOperation];
        [gateovi setAnyUnitary:rotaciona];
        [gateovi applayAnyUintaryOperationOnOneBit:noOfBits];
        
        [rotaciona release];
        [br1 release];
        [br2 release];
        [br3 release];
        [br4 release];
                    
    }
    else if(o == 12){
        [gateovi newOperation];
        for(int k = 0; k<=10; k++){
            [gateovi setIsRadniBitVise:selektovanBit[indeks][k] atIndex:k];
        }
		[NSThread detachNewThreadSelector:@selector(fTest) toTarget:gateovi withObject:nil];

        //[gateovi fourierTransformacijaNaSvimBitima:noOfBits];
    }
	else if(o == 13){
        [gateovi newOperation];
        [gateovi inverznaFurTransf:noOfBits];
    }
	[jedanBr release];
	[nula release];
	[i release];
	[gateovi setOperacijaBr:([gateovi operacijaBr]+1)];
}

- (IBAction)applayRotation:(id)sender {
    osa[indeks]=osaRotacije.selectedSegmentIndex;
    
    float a,b;
    int errore = 0;
    
    if ([[ugaoURad text] length] == 1){
        a = [[ugaoURad text] floatValue];
        b = [[ugaoURad text] floatValue];
    }
    
    else if(([[ugaoURad text] characterAtIndex:1] == '/') && ([[ugaoURad text]length]==3)){
        NSRange range1 = NSMakeRange(0, 1);
        NSRange range2 = NSMakeRange(2, 1);
        
        a = [[[ugaoURad text] substringWithRange:range1]floatValue];
        b = [[[ugaoURad text] substringWithRange:range2]floatValue];
    }
    else if (([[ugaoURad text] characterAtIndex:3] == '/') && ([[ugaoURad text]length]==5)){
        NSRange range1 = NSMakeRange(0, 2);
        NSRange range2 = NSMakeRange(3, 2);
        
        a = [[[ugaoURad text] substringWithRange:range1]floatValue];
        b = [[[ugaoURad text] substringWithRange:range2]floatValue];
    }
    else{
        UIAlertView *alarmo = [[UIAlertView alloc] initWithTitle:@"Invalid value!" message:@"You enterd invalid number please choose another value" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
        errore = 1;
        [alarmo show];
        [alarmo release];
    }
    if (!errore){
        ugao[indeks]=(a/b)*k_PI;
        self.view=operationList;
    }
}

- (IBAction)systemVector:(id)sender {
    self.view = stanjaEkran;
    indeks=0;
    [self refreshScreen];
}


- (IBAction)backToTable:(id)sender {
    self.view = operationList;
    [tabelaOperacija reloadData];
    indeks=0;
}

- (IBAction)selectOperation:(id)sender {
    operationBit[indeks] = qBitZaOperaciju.selectedSegmentIndex;
    controlBit[indeks] = kontrolniqBit.selectedSegmentIndex;
    operationNumber[indeks] = ([sender tag]+1);
    
    NSString *zaRelease = [imenaOperacija objectAtIndex:indeks];
    NSString *novoIme;
	operationNumber[indeks]--;
    if(operationNumber[indeks]<=5){
     novoIme = [[NSString alloc] initWithFormat:@"F%d%@(q%d)",indeks,[self getSlovo],operationBit[indeks]];   
    }
    else if(operationNumber[indeks]>=5 && operationNumber[indeks]<=11){
        novoIme = [[NSString alloc] initWithFormat:@"F%d%@(q%d,cq%d)",indeks,[self getSlovo],operationBit[indeks],controlBit[indeks]];  
    }
    else if(operationNumber[indeks]==12 || operationNumber[indeks]==13){
        novoIme = [[NSString alloc] initWithFormat:@"Fourier transformation"];  
    }
    [imenaOperacija replaceObjectAtIndex:indeks withObject:novoIme];
    [zaRelease release];
    [imeOperacije setText:novoIme];
    if([sender tag] == 11){
        self.view=rotacija;
    }
	if([sender tag] == 10){
		self.view=customMat;
	}
    if([sender tag] == 12){
        [bitiZaFTransf setText:@""];
        [self setView:fouri];
    }
	operationNumber[indeks]++;
}

- (void)dobiSveNazive{
    for(int i = 0; i<=299; i++){
        NSString *zaRelease = [imenaOperacija objectAtIndex:i];
        NSString *novoIme;
		if (operationNumber[i] != 0) {
			operationNumber[i]--;
			indeks = i;
			if(operationNumber[i]<=5){
				novoIme = [[NSString alloc] initWithFormat:@"F%d%@(q%d)",i,[self getSlovo],operationBit[i]];   
			}
			else if(operationNumber[i]>=5 && operationNumber[i]<=11){
				novoIme = [[NSString alloc] initWithFormat:@"F%d%@(q%d,cq%d)",i,[self getSlovo],operationBit[i],controlBit[i]];  
			}
			else if(operationNumber[i]==12 || operationNumber[i]==12){
				novoIme = [[NSString alloc] initWithFormat:@"Fourier transformation"];  
			}
			[imenaOperacija replaceObjectAtIndex:i withObject:novoIme];
			[zaRelease release];
			operationNumber[i]++;
		}
    }
}

- (IBAction)sacuvajListu:(id)sender {
    if([sender tag]==0){
        self.view = cuvanjeListe;
    }
    else{
        NSArray *putanjaArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *putanja = [[putanjaArray objectAtIndex:0] stringByAppendingPathComponent:@"sacuvaniFajl.plist"];
        if([[NSFileManager defaultManager] fileExistsAtPath:putanja]){
			NSMutableArray *brOperacije = [[NSMutableArray alloc] initWithCapacity:300];
            NSMutableArray *radniBit = [[NSMutableArray alloc] initWithCapacity:300];
            NSMutableArray *kontrolBit = [[NSMutableArray alloc] initWithCapacity:300];
            NSMutableArray *uglovi = [[NSMutableArray alloc] initWithCapacity:300];
            NSMutableArray *ose = [[NSMutableArray alloc] initWithCapacity:300];
            NSMutableArray *brZaMatRe = [[NSMutableArray alloc] initWithCapacity:300];
            NSMutableArray *brZaMatIm = [[NSMutableArray alloc] initWithCapacity:300];
            NSMutableArray *zaFur = [[NSMutableArray alloc] initWithCapacity:300];
            for(int i = 0; i<300; i++){
                [brOperacije insertObject:[NSNumber numberWithInt:operationNumber[i]] atIndex:i];
                [radniBit insertObject:[NSNumber numberWithInt:operationBit[i]] atIndex:i];
                [kontrolBit insertObject:[NSNumber numberWithInt:controlBit[i]] atIndex:i];
                [uglovi insertObject:[NSNumber numberWithFloat:ugao[i]] atIndex:i];
                [ose insertObject:[NSNumber numberWithInt:osa[i]] atIndex:i];
				NSMutableArray *brojRe = [[NSMutableArray alloc] initWithCapacity:4];
				NSMutableArray *brojIm = [[NSMutableArray alloc] initWithCapacity:4];
				for(int k = 0;k<4;k++){
                    [brojRe insertObject:[NSNumber numberWithFloat:brojeviZapatricu[i][k]] atIndex:k];
                    [brojIm insertObject:[NSNumber numberWithFloat:imaginarniDeoZaMat[i][k]] atIndex:k];
                }
                [brZaMatRe insertObject:brojRe atIndex:i];
                [brZaMatIm insertObject:brojIm atIndex:i];
                [brojRe release];
                [brojIm release];
            }
            for (int i = 0; i<=300;i++){
                NSMutableArray *oznaceniBiti = [[NSMutableArray alloc] initWithCapacity:10];
                
                for (int n = 0; n<=10; n++){
                    [oznaceniBiti insertObject:[NSNumber numberWithBool:selektovanBit[i][n]] atIndex:n];
                }
                [zaFur insertObject:oznaceniBiti atIndex:i];
                [oznaceniBiti release];
            }
            NSArray *zaFile = [[NSArray alloc] initWithObjects:brOperacije,uglovi,ose,brZaMatRe,brZaMatIm,zaFur,radniBit,kontrolBit, nil];
            NSString *imeList = [[NSString alloc] initWithFormat:@"%@",[imeListeOperacija text]];
			NSMutableArray *izFajla = [[NSMutableArray alloc] initWithContentsOfFile:putanja];
			
			NSMutableArray *zaFilePisanje = [[NSMutableArray alloc] initWithArray:izFajla];
			[zaFilePisanje addObject:zaFile];
			[zaFilePisanje addObject:imeList];
			
			[zaFilePisanje writeToFile:putanja atomically:YES];
			
            [zaFur release];
            [brOperacije release];
            [radniBit release];
            [kontrolBit release];
			[izFajla release];
			[zaFilePisanje release];
            [uglovi release];
            [ose release];
            [brZaMatIm release];
            [brZaMatRe release];
            [zaFile release];
            [imeList release];
        }
        else{
            NSMutableArray *brOperacije = [[NSMutableArray alloc] initWithCapacity:300];
            NSMutableArray *radniBit = [[NSMutableArray alloc] initWithCapacity:300];
            NSMutableArray *kontrolBit = [[NSMutableArray alloc] initWithCapacity:300];
            NSMutableArray *uglovi = [[NSMutableArray alloc] initWithCapacity:300];
            NSMutableArray *ose = [[NSMutableArray alloc] initWithCapacity:300];
            NSMutableArray *brZaMatRe = [[NSMutableArray alloc] initWithCapacity:300];
            NSMutableArray *brZaMatIm = [[NSMutableArray alloc] initWithCapacity:300];
            NSMutableArray *zaFur = [[NSMutableArray alloc] initWithCapacity:300];
            for(int i = 0; i<300; i++){
                [brOperacije insertObject:[NSNumber numberWithInt:operationNumber[i]] atIndex:i];
                [radniBit insertObject:[NSNumber numberWithInt:operationBit[i]] atIndex:i];
                [kontrolBit insertObject:[NSNumber numberWithInt:controlBit[i]] atIndex:i];
                [uglovi insertObject:[NSNumber numberWithFloat:ugao[i]] atIndex:i];
                [ose insertObject:[NSNumber numberWithInt:osa[i]] atIndex:i];
                 NSMutableArray *brojRe = [[NSMutableArray alloc] initWithCapacity:4];
                 NSMutableArray *brojIm = [[NSMutableArray alloc] initWithCapacity:4];
                 for(int k = 0;k<4;k++){
                    [brojRe insertObject:[NSNumber numberWithFloat:brojeviZapatricu[i][k]] atIndex:k];
                    [brojIm insertObject:[NSNumber numberWithFloat:imaginarniDeoZaMat[i][k]] atIndex:k];
                }
                [brZaMatRe insertObject:brojRe atIndex:i];
                [brZaMatIm insertObject:brojIm atIndex:i];
                [brojRe release];
                [brojIm release];
            }
            for (int i = 0; i<=300;i++){
                NSMutableArray *oznaceniBiti = [[NSMutableArray alloc] initWithCapacity:10];
                
                for (int n = 0; n<=10; n++){
                    [oznaceniBiti insertObject:[NSNumber numberWithBool:selektovanBit[i][n]] atIndex:n];
                }
                [zaFur insertObject:oznaceniBiti atIndex:i];
                [oznaceniBiti release];
            }
            NSArray *zaFile = [[NSArray alloc] initWithObjects:brOperacije,uglovi,ose,brZaMatRe,brZaMatIm,zaFur,radniBit,kontrolBit, nil];
            NSString *imeList = [[NSString alloc] initWithFormat:@"%@",[imeListeOperacija text]];
            NSArray *zaCuvanje = [[NSArray alloc] initWithObjects:zaFile,imeList, nil];
            
            [zaCuvanje writeToFile:putanja atomically:YES];
            [zaFur release];
            [brOperacije release];
            [radniBit release];
            [kontrolBit release];
            [uglovi release];
            [ose release];
            [brZaMatIm release];
            [brZaMatRe release];
            [zaFile release];
            [imeList release];
            [zaCuvanje release];
        }
        self.view = operationList;
    }
}

- (IBAction)backIzCuvanja:(id)sender {
    self.view = operationList;
}

- (IBAction)ucitajListu:(id)sender {
    self.view = loadListView;
	[tabelaLoad reloadData];
}
-(NSString *)getSlovo{
    NSString *povratak;
    if(operationNumber[indeks]==0){
        povratak = [NSString stringWithFormat:@"X"];
    }
    if(operationNumber[indeks]==1){
        povratak = [NSString stringWithFormat:@"Y"];
    }
    if(operationNumber[indeks]==2){
        povratak = [NSString stringWithFormat:@"Z"];
    }
    if(operationNumber[indeks]==3){
        povratak = [NSString stringWithFormat:@"H"];
    }
    if(operationNumber[indeks]==4){
        povratak = [NSString stringWithFormat:@"S"];
    }
    if(operationNumber[indeks]==5){
        povratak = [NSString stringWithFormat:@"T"];
    }
    if(operationNumber[indeks]==6){
        povratak = [NSString stringWithFormat:@"cZ"];
    }
    if(operationNumber[indeks]==7){
        povratak = [NSString stringWithFormat:@"SWAP"];
    }
    if(operationNumber[indeks]==8){
        povratak = [NSString stringWithFormat:@"cS"];
    }
    if(operationNumber[indeks]==9){
        povratak = [NSString stringWithFormat:@"cNOT"];
    }
    if(operationNumber[indeks]==10){
        povratak = [NSString stringWithFormat:@"U"];
    }
    if(operationNumber[indeks]==11){
        povratak = [NSString stringWithFormat:@"R"];
    }
    if(operationNumber[indeks]==12){
        povratak = [NSString stringWithFormat:@"F"];
    }
	if(operationNumber[indeks]==13){
        povratak = [NSString stringWithFormat:@"F-1"];
    }
    return povratak;
}

-(IBAction)tastatura:(id)sender{
    [imeListeOperacija resignFirstResponder];
    [ugaoURad resignFirstResponder];
    [jedan resignFirstResponder];
    [dva resignFirstResponder];
    [tri resignFirstResponder];
    [cetiri resignFirstResponder];
    [iJedan resignFirstResponder];
    [iDva resignFirstResponder];
    [iTri resignFirstResponder];
    [iCetiri resignFirstResponder];
    [bitiZaFTransf resignFirstResponder];
}

- (IBAction)undo:(id)sender {   
	indeks--;
	if(indeks<0){
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Nothing to undo" message:nil delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
	[alert show];
	[alert release];
	}
    else if([[imenaOperacija objectAtIndex:indeks]characterAtIndex:0]=='F'){
        [self applayOperation:operationNumber[indeks] onBit:operationBit[indeks] controlBit:controlBit[indeks]];
        [self refreshScreen];
    }
}

- (IBAction)newOperation:(id)sender {
    self.view = operationList;
    if(firstSet){
        brojOperacija = 300;
        imenaOperacija = [[NSMutableArray alloc] initWithCapacity:brojOperacija];
        for(int i = 0; i < brojOperacija; i++){
            NSString *naziv = [[NSString alloc] initWithFormat:@"Set operation %d",i];
            [imenaOperacija insertObject:naziv atIndex:i];
            
        }
        [tabelaOperacija reloadData];
        firstSet=NO;
    }
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)startSimulatorFromSetBits{
    for(int i = 0; i < noOfBits;i++){
        UISegmentedControl *radni = [switchZaStanja objectAtIndex:i];
        if(radni.selectedSegmentIndex==1){
            Complex *jedanBr = [[Complex alloc] initWithReal:1.00 andImaginary:0.00];
            Complex *nula = [[Complex alloc] initWithReal:0.00 andImaginary:0.00];
			Complex *rel0 = [[computer bitBr:i] zeroState];
			Complex *rel1 = [[computer bitBr:i] oneState];
            [[computer bitBr:i] setStates:nula :jedanBr];
			
			[rel0 release];
			[rel1 release];
        }
    }
    [switchZaStanja removeAllObjects];
    [switchZaStanja release];
    self.view = stanjaEkran;
	NSMutableArray *sisZaRelease = [computer sistem];
	for (int i=(pow(2, noOfBits))-1; i>=0; i--) {
		Complex *rele = [sisZaRelease objectAtIndex:i];
		[sisZaRelease removeLastObject];
		[rele release];
	}
    [computer refresh];
    [self refreshScreen];
}

- (IBAction)restart:(id)sender {
	[gateovi release];
	[computer release];
	//[self stardovanjeAuto];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
   // [startSimulator release];
    [tastatura release];
    [stanjaEkran release];
    [stanjaEkran release];
    [setBits release];
    [applayOperation release];
    [operationList release];
    [qBitZaOperaciju release];
    [kontrolniqBit release];
    [imeOperacije release];
    [rotacija release];
    [osaRotacije release];
    [ugaoURad release];
    [customMat release];
    [jedan release];
    [dva release];
    [tri release];
    [cetiri release];
    [iJedan release];
    [iDva release];
    [iTri release];
    [iCetiri release];
    [imeListeOperacija release];
    [cuvanjeListe release];
    [loadListView release];
    [tabelaLoad release];
    [working release];
    [aktivnost release];
    [fouri release];
    [bitiZaFTransf release];
    [super dealloc];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if([tableView tag]==0){
     return brojOperacija;   
    }
    else if([tableView tag]==1){
        NSArray *putanjaArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *putanja = [[putanjaArray objectAtIndex:0] stringByAppendingPathComponent:@"sacuvaniFajl.plist"];
        
        NSArray *izFajla = [[NSArray alloc] initWithContentsOfFile:putanja];
        int brojFajlova = [izFajla count]/2;
        [izFajla release];
        return brojFajlova;
    }
    else return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([tableView tag]==0){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        if(cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        cell.textLabel.text = [imenaOperacija objectAtIndex:indexPath.row];
        return cell;
    }
    else if ([tableView tag]==1){
        UITableViewCell *sList = [tableView dequeueReusableCellWithIdentifier:@"sList"];
        
        if(sList == nil){
            sList = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"sList"];
        }
        
        NSArray *putanjaArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *putanja = [[putanjaArray objectAtIndex:0] stringByAppendingPathComponent:@"sacuvaniFajl.plist"];
        
        NSArray *izFajla = [[NSArray alloc] initWithContentsOfFile:putanja];
        
		int brojReda = indexPath.row*2 + 1;
		
        sList.textLabel.text = [izFajla objectAtIndex:brojReda];
        [izFajla release];
        return sList;
        
    }
    else return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([tableView tag]==0){
        indeks = indexPath.row;
        self.view = applayOperation;
        [imeOperacije setText:[imenaOperacija objectAtIndex:indeks]]; 
    }
    else if ([tableView tag]==1){
        int broj = indexPath.row;
        [self ucitajIzFajlaAtIndex:broj*2];
        [self dobiSveNazive];
        self.view = operationList;
        [tabelaOperacija reloadData];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
	[textField resignFirstResponder];
	
	return YES;
}
-(void)stardovanjeAuto{
	noOfBits = 10;
	[self startComputer];
	[self.view addSubview: self.stanjaEkran];
	[self setScreen];
}
 
-(void)workingScreen{
    if (operationNumber[indeks]==13){
        self.view = working;
        [aktivnost startAnimating];
        return;
    }
    [self refreshScreen];
    indeks++;
}

- (IBAction)applayFTransform:(id)sender {
    int erroro = 0;
    NSString *izabraniqBiti = [bitiZaFTransf text];
    int brBita = [izabraniqBiti length];
    if (brBita == 0){
        erroro = 1;
    }
    else{
		int i,b;
        for(i = 0, b = 1; i<=brBita; i=i+2, b = b+2){
			if (b<brBita) {
				if([izabraniqBiti characterAtIndex:b] == ','){
					NSRange ranger = NSMakeRange(i, 1);
					int bitBr = [[izabraniqBiti substringWithRange:ranger] intValue];
					selektovanBit[indeks][bitBr]=YES;
				}
				else{
					erroro = 1;
				}
			}
			else {
				NSRange ranger = NSMakeRange(i, 1);
				int bitBr = [[izabraniqBiti substringWithRange:ranger] intValue];
				selektovanBit[indeks][bitBr]=YES;
			}

        }
    }
    if(erroro){
        UIAlertView *alarmeto = [[UIAlertView alloc] initWithTitle:@"Invalid input format" message:@"Pleas input the valid format:1,2,…" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
        [alarmeto show];
        [alarmeto release];
        return;
    }
    self.view = operationList;
    [tabelaOperacija reloadData];
}
-(void)gotovaFurieva{
    [aktivnost stopAnimating];
    self.view=stanjaEkran;
    [self refreshScreen];
    indeks++;
}
-(void)ucitajIzFajlaAtIndex:(int)a{
    NSArray *putanjaArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *putanja = [[putanjaArray objectAtIndex:0] stringByAppendingPathComponent:@"sacuvaniFajl.plist"];
    
    NSArray *izFajla = [[NSArray alloc] initWithContentsOfFile:putanja];
    
    NSArray *dataIzFajla = [izFajla objectAtIndex:a];
    NSArray *brojOp = [dataIzFajla objectAtIndex:0]; 
    NSArray *uglovi= [dataIzFajla objectAtIndex:1];
    NSArray *ose = [dataIzFajla objectAtIndex:2];
    NSArray *brRe = [dataIzFajla objectAtIndex:3];
    NSArray *brIm = [dataIzFajla objectAtIndex:4];
    NSArray *faFur = [dataIzFajla objectAtIndex:5];
    NSArray *radniBiti = [dataIzFajla objectAtIndex:6];
    NSArray *kontrolniBitic = [dataIzFajla objectAtIndex:7];
    
    for(int q = 0;q<=299;q++){
        operationNumber[q] = [[brojOp objectAtIndex:q] intValue];
        operationBit[q] = [[radniBiti objectAtIndex:q] intValue];
        controlBit[q] = [[kontrolniBitic objectAtIndex:q] intValue];
        osa[q] = [[ose objectAtIndex:q] intValue];
        ugao[q] = [[uglovi objectAtIndex:q] floatValue];
        NSArray *zaFurSelektovaniBiti = [faFur objectAtIndex:q];
        NSArray *brReIzFile = [brRe objectAtIndex:q];
        NSArray *brImIzFile = [brIm objectAtIndex:q];
        
        for(int n = 0; n<=10; n++){
            selektovanBit[q][n] = [[zaFurSelektovaniBiti objectAtIndex:n]boolValue];
            if (n<=3){
                brojeviZapatricu[q][n]= [[brReIzFile objectAtIndex:n]floatValue];
                imaginarniDeoZaMat[q][n]= [[brImIzFile objectAtIndex:n] floatValue];
            }
        }
    }
    
    [brojOp release];
    [uglovi release];
    [ose release];
    [brRe release];
    [brIm release];
    [faFur release];
    [radniBiti release];
    [kontrolniBitic release];
    
}
/*
 -(IBAction)startSimulator:(id)sender{
 trenutno = 0;
 //noOfBits = [[noOfBitsLabel text]intValue];
 if(noOfBits > 10){
 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Extended Maximum no. of qButs!" message:@"Chose other value for no. of qBits." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
 [alert show];
 [alert release];
 }
 else{
 [self startComputer];
 
 if([sender tag]==0){
 self.view=stanjaEkran;
 [self refreshScreen];
 }
 
 else{
 self.view = setBits;
 lblZaSetStanja = [[NSMutableArray alloc] initWithCapacity:noOfBits];
 switchZaStanja = [[NSMutableArray alloc] initWithCapacity:noOfBits];
 for(int i = 0; i < noOfBits; i++){
 UILabel *lblZaSet = [[UILabel alloc] initWithFrame:CGRectMake(20, (i*35+55), 132, 30)];
 UISegmentedControl *control = [[UISegmentedControl alloc] initWithFrame:CGRectMake(190, (i*35+55), 110, 30)];
 control.segmentedControlStyle = UISegmentedControlStyleBar;
 [control insertSegmentWithTitle:@"0" atIndex:0 animated:YES];
 [control insertSegmentWithTitle:@"1" atIndex:1 animated:YES];
 [control setAlpha:1.00];
 //[control setTitle:@"0" forSegmentAtIndex:0];
 //[control setTitle:@"1" forSegmentAtIndex:1];
 NSString *tekst = [NSString stringWithFormat:@"Bit No. %d State",i];
 [lblZaSet setText:tekst];
 lblZaSet.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
 [control setSelectedSegmentIndex:0];
 [self.view addSubview:lblZaSet];
 [self.view addSubview:control];
 
 [lblZaSetStanja addObject:lblZaSet];
 [switchZaStanja addObject:control];
 }
 }
 
 gateovi = [[QGates alloc] initWithComputer:computer];
 }
 }
 */
@end
