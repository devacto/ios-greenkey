//
//  AuditElectricityKitchenViewController.m
//  ANUGreen
//
//  Created by Victor Hartanto Wibisono on 2/08/11.
//  Copyright 2011 ANUGreen. All rights reserved.
//

#import "AuditElectricityKitchenViewController.h"


@implementation AuditElectricityKitchenViewController

@synthesize kettleField, microwaveField, coffeemachineField, toasterField;

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
    double kettleValue;
    double microwaveValue;
    double coffeemachineValue;
    double toasterValue;
    
    kettleValue = ([self.kettleField.text doubleValue] / 60) * 1700;
    microwaveValue = ([self.microwaveField.text doubleValue] / 60) * 1200;
    coffeemachineValue = ([self.coffeemachineField.text doubleValue] / 60) * 1200;
    toasterValue = ([self.toasterField.text doubleValue] / 60) * 1200;
    
    double kitchenSubTotal;
    kitchenSubTotal = (kettleValue + microwaveValue + coffeemachineValue + toasterValue) * 30 / 1000;
    
    NSLog(@"Kitchen Subtotal = %g", kitchenSubTotal);
    
    [self saveToUserDefaults:[NSNumber numberWithDouble:kitchenSubTotal] forKey:@"kitchen"];
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
    
    self.kettleField.delegate = self;
    self.coffeemachineField.delegate = self;
    self.toasterField.delegate = self;
    self.microwaveField.delegate = self;
    
    self.kettleField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
	self.coffeemachineField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.toasterField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.microwaveField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    
    //Setting the content size of the scroll view
    UIScrollView *tempScrollView=(UIScrollView *)self.view;
	tempScrollView.contentSize=CGSizeMake(320,500);
    
	self.title = @"Kitchen";
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillAppear:animated];
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
    
    self.kettleField = nil;
    self.coffeemachineField = nil;
    self.toasterField = nil;
    self.microwaveField = nil;
}


- (void)dealloc {
    [kettleField release];
    [coffeemachineField release];
    [toasterField release];
    [microwaveField release];
    
    
    [super dealloc];
}


@end
