//
//  AlertWithText.m
//  Quantum Computer Simpulator
//
//  Created by Stefan Hacko on 1/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AlertWithText.h"


@implementation AlertWithText
@synthesize textField;
@synthesize enteredText;
- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle okButtonTitle:(NSString *)okayButtonTitle
{
    
    if (self = [super initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:okayButtonTitle, nil])
    {
        UITextField *theTextField = [[UITextField alloc] initWithFrame:CGRectMake(15.0, 40.0, 260.0, 25.0)]; 
        [theTextField setBackgroundColor:[UIColor whiteColor]]; 
        [self addSubview:theTextField];
        self.textField = theTextField;
        [theTextField release];
        //CGAffineTransform translate = CGAffineTransformMakeTranslation(0.0, 130.0); 
        //[self setTransform:translate];
    }
    return self;
}
- (void)show
{
    [textField becomeFirstResponder];
    [super show];
}
- (NSString *)enteredText
{
    return textField.text;
}
- (void)dealloc
{
    [textField release];
    [super dealloc];
}
@end
