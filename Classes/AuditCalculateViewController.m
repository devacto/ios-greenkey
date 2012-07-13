//
//  AuditCalculateViewController.m
//  ANUGreen
//
//  Created by Victor Hartanto Wibisono on 2/08/11.
//  Copyright 2011 ANUGreen. All rights reserved.
//

#import "AuditCalculateViewController.h"


@implementation AuditCalculateViewController

@synthesize resultLabel, electricityLabel, heatingLabel, waterLabel, gradeLabel;

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

-(NSNumber*)retrievefromUserDefaultsforKey:(NSString*)myKey{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSNumber *val = nil;
    
    if (standardUserDefaults) 
        val = [standardUserDefaults objectForKey:myKey];
    
    return val;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = @"Calculate";
    
    // Calculating Electricity
    double electricitySubtotal;
    electricitySubtotal = ([[self retrievefromUserDefaultsforKey:@"lighting"] doubleValue]+ [[self retrievefromUserDefaultsforKey:@"kitchen"] doubleValue]+ [[self retrievefromUserDefaultsforKey:@"communication"] doubleValue] + [[self retrievefromUserDefaultsforKey:@"entertainment"] doubleValue] + [[self retrievefromUserDefaultsforKey:@"grooming"] doubleValue]) / 200 * 33;
    
    double waterSubtotal;
    
    waterSubtotal = [[self retrievefromUserDefaultsforKey:@"water"] doubleValue] / 16000 * 32;
    
    double heatingSubtotal;
    heatingSubtotal = [[self retrievefromUserDefaultsforKey:@"heating"] doubleValue];
    
    
    self.waterLabel.text = [NSString stringWithFormat:@"Water Score: %g", waterSubtotal];
    self.electricityLabel.text = [NSString stringWithFormat:@"Electricity Score: %g", electricitySubtotal];
    self.heatingLabel.text = [NSString stringWithFormat:@"Heating Score: %g", heatingSubtotal];
    
    double result;
    result = electricitySubtotal + waterSubtotal + heatingSubtotal;
    
    self.resultLabel.text = [NSString stringWithFormat:@"Raw Result: %g", result];
    
    if (result < 33.0) {
        self.gradeLabel.text = @"High Distinction";
    } else if ((33.0 < result) && (result < 43.0)) {
        self.gradeLabel.text = @"Distinction";
    } else if ((43.0 < result) && (result < 53.0)) {
        self.gradeLabel.text = @"Credit";
    } else if ((53.0 < result) && (result < 63.0)) {
        self.gradeLabel.text = @"Pass";
    } else if (result > 63.0) {
        self.gradeLabel.text = @"Fail";
    }
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
    
    self.resultLabel = nil;
    self.gradeLabel = nil;
    self.waterLabel = nil;
    self.electricityLabel = nil;
    self.heatingLabel = nil;
    
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [resultLabel release];
    [gradeLabel release];
    [waterLabel release];
    [electricityLabel release];
    [heatingLabel release];
    
    [super dealloc];
}


@end
