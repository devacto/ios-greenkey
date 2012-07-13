//
//  AuditWaterViewController.m
//  ANUGreen
//
//  Created by Victor Hartanto Wibisono on 2/08/11.
//  Copyright 2011 ANUGreen. All rights reserved.
//

#import "AuditWaterViewController.h"


@implementation AuditWaterViewController

@synthesize showerField, tapField, halfflushField, fullflushField, washField, coldwashField, fullwashField;

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
    double showerValue;
    double tapValue;
    double halfflushValue;
    double fullflushValue;
    double washValue;
    
    double coldwashValue;
    double fullwashValue;
    
    showerValue = ([self.showerField.text doubleValue] / 60) * 6;
    tapValue = ([self.tapField.text doubleValue] / 60) * 9;
    halfflushValue = ([self.halfflushField.text doubleValue]) * 4;
    fullflushValue = ([self.fullflushField.text doubleValue]) * 6;
    washValue = (([self.washField.text doubleValue]) * 100) * 4;
    
    if (self.fullwashField.selectedSegmentIndex == 0) {
        fullwashValue = 0.00;
    } else {
        fullwashValue = 1.00;
    }
    
    if (self.coldwashField.selectedSegmentIndex == 0) {
        coldwashValue = 0.00;
    } else {
        coldwashValue = 1.00;
    }
        
    double waterSubtotal;
    waterSubtotal = ((showerValue + tapValue + halfflushValue + fullflushValue) * 30) + (washValue * 4) + fullwashValue + coldwashValue;
    
    
    NSLog(@"Water Subtotal = %g", waterSubtotal);
    
    [self saveToUserDefaults:[NSNumber numberWithDouble:waterSubtotal] forKey:@"water"];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.showerField.delegate = self;
    self.tapField.delegate = self;
    self.halfflushField.delegate = self;
    self.fullflushField.delegate = self;
    self.washField.delegate = self;
    
    self.showerField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.tapField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.halfflushField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.fullflushField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.washField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
	
    //Setting the content size of the scroll view
    UIScrollView *tempScrollView=(UIScrollView *)self.view;
	tempScrollView.contentSize=CGSizeMake(320,540);
    
	self.title = @"Water";
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
    
    self.showerField = nil;
    self.tapField = nil;
    self.halfflushField = nil;
    self.fullflushField = nil;
    self.washField = nil;
}


- (void)dealloc {
    [showerField release];
    [tapField release];
    [halfflushField release];
    [fullflushField release];
    [washField release];
    
    [super dealloc];
}


@end
