//
//  AuditElectricityGroomingViewController.m
//  ANUGreen
//
//  Created by Victor Hartanto Wibisono on 4/08/11.
//  Copyright 2011 ANUGreen. All rights reserved.
//

#import "AuditElectricityGroomingViewController.h"


@implementation AuditElectricityGroomingViewController

@synthesize blowdryerField;
@synthesize hairstraightenerField;

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
	[textField resignFirstResponder];
	return YES;	
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

-(void)saveToUserDefaults:(NSNumber*)myResult forKey:(NSString*)myKey {
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (standardUserDefaults) {
        [standardUserDefaults setObject:myResult forKey:myKey];
        [standardUserDefaults synchronize];
    }
}

- (void)calculateScore {
    
    //Setting up the variables
    double blowdryerValue;
    double hairstraightenerValue;
    
    blowdryerValue = ([self.blowdryerField.text doubleValue] / 60) * 1000;
    hairstraightenerValue = ([self.hairstraightenerField.text doubleValue] / 60) * 1000;
    
    double groomingSubTotal;
    groomingSubTotal = (blowdryerValue + hairstraightenerValue) * 30 / 500;
    
    NSLog(@"Grooming Subtotal = %g", groomingSubTotal);
    
    [self saveToUserDefaults:[NSNumber numberWithDouble:groomingSubTotal] forKey:@"grooming"];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.blowdryerField.delegate = self;
    self.hairstraightenerField.delegate = self;
    
    self.blowdryerField.keyboardType = UIKeyboardTypeNumberPad;
    
    self.hairstraightenerField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
	
    UIScrollView *tempScrollView=(UIScrollView *)self.view;
	tempScrollView.contentSize=CGSizeMake(320,500);
    
	self.title = @"Grooming";
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
    
    self.blowdryerField = nil;
    self.hairstraightenerField = nil;
}


- (void)dealloc {
    [blowdryerField release];
    [hairstraightenerField release];
    
    [super dealloc];
}


@end
