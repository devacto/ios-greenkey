//
//  AuditElectricityEntertainmentViewController.m
//  ANUGreen
//
//  Created by Victor Hartanto Wibisono on 2/08/11.
//  Copyright 2011 ANUGreen. All rights reserved.
//

#import "AuditElectricityEntertainmentViewController.h"


@implementation AuditElectricityEntertainmentViewController

@synthesize lcdtvField, plasmatvField, standardtvField, stereoField, speakerField, consoleField;

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
	[textField resignFirstResponder];
	return YES;	
}

-(void)saveToUserDefaults:(NSNumber*)myResult forKey:(NSString*)myKey {
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (standardUserDefaults) {
        [standardUserDefaults setObject:myResult forKey:myKey];
        [standardUserDefaults synchronize];
    }
}

- (void)calculateScore {
    
    //Setting up the variables
    double lcdtvValue;
    double plasmatvValue;
    double standardtvValue;
    double stereoValue;
    double speakerValue;
    double consoleValue;
    
    lcdtvValue = ([self.lcdtvField.text doubleValue]) * 110;
    plasmatvValue = ([self.plasmatvField.text doubleValue]) * 300;
    standardtvValue = ([self.standardtvField.text doubleValue]) * 40;
    stereoValue = ([self.stereoField.text doubleValue]) * 1200;
    speakerValue = ([self.speakerField.text doubleValue]) * 100;
    consoleValue = ([self.consoleField.text doubleValue]) * 180;
    
    double entertainmentSubtotal;
    entertainmentSubtotal = (lcdtvValue + plasmatvValue + standardtvValue + stereoValue + speakerValue + consoleValue) * 30 / 1000;
    
    NSLog(@"Entertainment Subtotal = %g", entertainmentSubtotal);
    
    [self saveToUserDefaults:[NSNumber numberWithDouble:entertainmentSubtotal] forKey:@"entertainment"];
}


// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lcdtvField.delegate = self;
    self.plasmatvField.delegate = self;
    self.standardtvField.delegate = self;
    self.stereoField.delegate = self;
    self.speakerField.delegate = self;
    self.consoleField.delegate = self;
    
    self.lcdtvField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.plasmatvField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.standardtvField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.stereoField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.speakerField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.consoleField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    
    //Setting the content size of the scroll view
    UIScrollView *tempScrollView=(UIScrollView *)self.view;
	tempScrollView.contentSize=CGSizeMake(320,520);
	
	self.title = @"Entertainment";
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self calculateScore];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    self.lcdtvField = nil;
    self.plasmatvField = nil;
    self.standardtvField = nil;
    self.stereoField = nil;
    self.speakerField = nil;
    self.consoleField = nil;

}


- (void)dealloc {
    [lcdtvField release];
    [plasmatvField release];
    [standardtvField release];
    [stereoField release];
    [speakerField release];
    [consoleField release];
    
    [super dealloc];
}


@end
