//
//  AuditElectricityCommunicationsViewController.m
//  ANUGreen
//
//  Created by Victor Hartanto Wibisono on 2/08/11.
//  Copyright 2011 ANUGreen. All rights reserved.
//

#import "AuditElectricityCommunicationsViewController.h"


@implementation AuditElectricityCommunicationsViewController

@synthesize laptopField, desktopField, printerField, scannerField, mobileField, ipodField, shutdownField, turnoffField;


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
    double laptopValue;
    double desktopValue;
    double printerValue;
    double scannerValue;
    double mobileValue;
    double ipodValue;
    
    laptopValue = ([self.laptopField.text doubleValue]) * 60;
    desktopValue = ([self.desktopField.text doubleValue]) * 110;
    printerValue = ([self.printerField.text doubleValue]) * 25;
    scannerValue = ([self.scannerField.text doubleValue]) * 30;
    mobileValue = ([self.mobileField.text doubleValue]) * 0.5;
    ipodValue = ([self.ipodField.text doubleValue]) * 5;
    
    double communicationSubtotal;
    communicationSubtotal = (laptopValue + desktopValue + printerValue + scannerValue + mobileValue + ipodValue) * 30 / 1000;
    
    NSLog(@"Communication Subtotal = %g", communicationSubtotal);
    
    [self saveToUserDefaults:[NSNumber numberWithDouble:communicationSubtotal] forKey:@"communication"];
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
    
    self.laptopField.delegate = self;
    self.desktopField.delegate = self;
    self.printerField.delegate = self;
    self.scannerField.delegate = self;
    self.mobileField.delegate = self;
    self.ipodField.delegate = self;
	
    self.laptopField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.desktopField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.printerField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.scannerField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.mobileField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.ipodField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    
    UIScrollView *tempScrollView=(UIScrollView *)self.view;
	tempScrollView.contentSize=CGSizeMake(320,650);
    
	self.title = @"Communications";
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
    
    self.laptopField = nil;
    self.desktopField = nil;
    self.printerField = nil;
    self.scannerField = nil;
    self.mobileField = nil;
    self.ipodField = nil;
}


- (void)dealloc {
    [laptopField release];
    [desktopField release];
    [printerField release];
    [scannerField release];
    [mobileField release];
    [ipodField release];
    
    [super dealloc];
}


@end
