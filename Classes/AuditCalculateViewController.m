//
//  AuditCalculateViewController.m
//  ANUGreen
//
//  Created by Victor Hartanto Wibisono on 2/08/11.
//  Copyright 2011 ANUGreen. All rights reserved.
//

#import "AuditCalculateViewController.h"

@implementation AuditCalculateViewController

@synthesize gradeLabel;

#pragma mark - Retrieve from user defaults

-(NSNumber *)retrievefromUserDefaultsforKey:(NSString*)myKey {
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSNumber *val = nil;
    
    if (standardUserDefaults) 
        val = [standardUserDefaults objectForKey:myKey];
    
    return val;
}

#pragma mark - Reset data touched up inside

- (IBAction)resetButtonTouchedUpInside:(UIButton *)sender {
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    [[self navigationController] popViewControllerAnimated:YES];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
	self.title = @"Calculate";
    
    // Calculating Electricity
    double electricitySubtotal;
    electricitySubtotal = ([[self retrievefromUserDefaultsforKey:@"lighting"] doubleValue]+ [[self retrievefromUserDefaultsforKey:@"kitchen"] doubleValue]+ [[self retrievefromUserDefaultsforKey:@"communication"] doubleValue] + [[self retrievefromUserDefaultsforKey:@"entertainment"] doubleValue] + [[self retrievefromUserDefaultsforKey:@"grooming"] doubleValue]) / 200 * 33;
    
    double waterSubtotal;
    
    waterSubtotal = [[self retrievefromUserDefaultsforKey:@"water"] doubleValue] / 16000 * 32;
    
    double heatingSubtotal;
    heatingSubtotal = [[self retrievefromUserDefaultsforKey:@"heating"] doubleValue];
    
    double result;
    result = electricitySubtotal + waterSubtotal + heatingSubtotal;
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    self.gradeLabel = nil;
    [super viewDidUnload];
}


- (void)dealloc {
    [gradeLabel release];
    [super dealloc];
}

@end
