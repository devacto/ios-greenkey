//
//  AuditLightingViewController.m
//  ANUGreen
//
//  Created by Victor Hartanto Wibisono on 2/08/11.
//  Copyright 2011 ANUGreen. All rights reserved.
//

#import "AuditLightingViewController.h"


@implementation AuditLightingViewController

@synthesize compactFluorescentField, linearFluorescentField, circularFluorescentField, compactDownlightField, halogenDownlightField, incandescentBulbField, noCompactFluorescentField, noLinearFluorescentField, noCircularFluorescentField, noCompactDownlightField, noHalogenDownlightField, noIncandescentBulbField, turnOff;

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
    double compactFluorescentValue;
    double linearFluorescentValue;
    double circularFluorescentValue;
    double compactDownlightValue;
    double halogenDownlightValue;
    double incandescentBulbValue;
    
    //For the number text fields
    
    double turnOffValue;
    
    compactFluorescentValue = ([self.noCompactFluorescentField.text doubleValue] * [self.compactFluorescentField.text doubleValue]) * 11;
    linearFluorescentValue = ([self.noLinearFluorescentField.text doubleValue] * [self.linearFluorescentField.text doubleValue]) * 36;
    circularFluorescentValue = ([self.noCircularFluorescentField.text doubleValue] * [self.circularFluorescentField.text doubleValue]) * 22;
    compactDownlightValue = ([self.noCompactDownlightField.text doubleValue] *[self.compactDownlightField.text doubleValue]) * 11;
    halogenDownlightValue = ([self.noHalogenDownlightField.text doubleValue] *[self.halogenDownlightField.text doubleValue]) * 50;
    incandescentBulbValue = ([self.noIncandescentBulbField.text doubleValue] *[self.incandescentBulbField.text doubleValue]) * 60;
    
    if (self.turnOff.selectedSegmentIndex == 0) {
        turnOffValue = 0.00;
    } else {
        turnOffValue = 1.00;
    }
    
    double lightingSubtotal;
    lightingSubtotal = ((compactFluorescentValue + linearFluorescentValue + circularFluorescentValue + compactDownlightValue + halogenDownlightValue + incandescentBulbValue) * 30 / 1000) + turnOffValue;
    
    NSLog(@"Lighting Subtotal = %g", lightingSubtotal);
    
    [self saveToUserDefaults:[NSNumber numberWithDouble:lightingSubtotal] forKey:@"lighting"];
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
    
    self.compactFluorescentField.delegate = self;
    self.linearFluorescentField.delegate = self;
    self.circularFluorescentField.delegate = self;
    self.compactDownlightField.delegate = self;
    self.halogenDownlightField.delegate = self;
    self.incandescentBulbField.delegate = self;
    self.noCircularFluorescentField.delegate = self;
    self.noCompactDownlightField.delegate = self;
    self.noCompactFluorescentField.delegate = self;
    self.noHalogenDownlightField.delegate = self;
    self.noIncandescentBulbField.delegate = self;
    self.noLinearFluorescentField.delegate = self;
	
    self.compactFluorescentField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.linearFluorescentField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.circularFluorescentField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.compactDownlightField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.halogenDownlightField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.incandescentBulbField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    
    self.noCircularFluorescentField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.noCompactDownlightField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.noCompactFluorescentField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.noHalogenDownlightField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.noIncandescentBulbField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.noLinearFluorescentField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    
	//Setting the content size of the scroll view
    UIScrollView *tempScrollView=(UIScrollView *)self.view;
	tempScrollView.contentSize=CGSizeMake(320,570);
	
	self.title = @"Lighting";
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
    
    self.compactFluorescentField = nil;
    self.linearFluorescentField = nil;
    self.circularFluorescentField = nil;
    self.compactDownlightField = nil;
    self.halogenDownlightField = nil;
    self.incandescentBulbField = nil;
    
    self.noCircularFluorescentField = nil;
    self.noCompactDownlightField = nil;
    self.noCompactFluorescentField = nil;
    self.noHalogenDownlightField = nil;
    self.noIncandescentBulbField = nil;
    self.noLinearFluorescentField = nil;
    self.turnOff = nil;
}


- (void)dealloc {
    [compactFluorescentField release];
    [linearFluorescentField release];
    [circularFluorescentField release];
    [compactDownlightField release];
    [halogenDownlightField release];
    [incandescentBulbField release];
    [turnOff release];
    
    [noCircularFluorescentField release];
    [noCompactDownlightField release];
    [noCompactFluorescentField release];
    [noHalogenDownlightField release];
    [noIncandescentBulbField release];
    [noLinearFluorescentField release];

    
    [super dealloc];
}


@end
