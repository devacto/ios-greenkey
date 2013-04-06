//
//  AuditElectricityGroomingViewController.m
//  ANUGreen
//
//  Created by Victor Hartanto Wibisono on 4/08/11.
//  Copyright 2011 ANUGreen. All rights reserved.
//

#import "AuditElectricityGroomingViewController.h"
#import "ActionSheetPicker.h"


@implementation AuditElectricityGroomingViewController

@synthesize blowdryerField;
@synthesize hairstraightenerField;

@synthesize minutesList;
@synthesize delegate;

#pragma mark - Scroll picker events

- (IBAction)selectMinutes:(UIControl *)sender {
    minutesList = [[NSArray alloc]
                   initWithObjects: @"0", @"10", @"20", @"30", @"40", @"50", @"60", @"70", @"80",
                   @"90", @"100", @"110", @"120", @"130", @"140", @"150", @"160", @"170", @"180",
                   @"190", @"200", @"210", @"220", @"230", @"240", @"250", @"260", @"270", @"280", @"290", @"300", nil];
    ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        if ([sender respondsToSelector:@selector(setText:)]) {
            [sender performSelector:@selector(setText:) withObject:selectedValue];
        }
    };
    ActionStringCancelBlock cancel = ^(ActionSheetStringPicker *picker) {
        NSLog(@"Block Picker Canceled");
    };
    [ActionSheetStringPicker showPickerWithTitle:@"Select Minutes" rows:minutesList initialSelection:0 doneBlock:done cancelBlock:cancel origin:sender];
}

-(void)saveToUserDefaults:(NSNumber*)myResult forKey:(NSString*)myKey {
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (standardUserDefaults) {
        [standardUserDefaults setObject:myResult forKey:myKey];
        [standardUserDefaults synchronize];
    }
}

#pragma mark - Textfield delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return NO;
}

#pragma mark - Save to user defaults

- (void)saveStringToUserDefaults:(NSString *)myResult forKey:(NSString *)myKey {
    NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (standardUserDefaults) {
        [standardUserDefaults setObject:myResult forKey:myKey];
        [standardUserDefaults synchronize];
    }
}

- (void)saveNumberToUserDefaults:(NSNumber *)myResult forKey:(NSString *)myKey {
    NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (standardUserDefaults) {
        [standardUserDefaults setObject:myResult forKey:myKey];
        [standardUserDefaults synchronize];
    }
}

#pragma mark - Load from user defaults

- (NSString *)retrieveStringFromUserDefaultsForKey:(NSString *)key {
    NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSString * value = @" ";
    
    if (standardUserDefaults) {
        if ([standardUserDefaults objectForKey:key] != nil) {
            value = [standardUserDefaults objectForKey:key];
        }
    }
    
    return value;
}

#pragma mark - Saving and loading inputs

- (void)saveInputs {
    [self saveStringToUserDefaults:self.blowdryerField.text forKey:@"blowdryerField"];
    [self saveStringToUserDefaults:self.hairstraightenerField.text forKey:@"hairstraightenerField"];
}

- (void)loadInputs {
    self.blowdryerField.text = [self retrieveStringFromUserDefaultsForKey:@"blowdryerField"];
    self.hairstraightenerField.text = [self retrieveStringFromUserDefaultsForKey:@"hairstraightenerField"];
}

#pragma mark - Calculating score

- (void)calculateScore {
    
    //Setting up the variables
    double blowdryerValue;
    double hairstraightenerValue;
    
    blowdryerValue = ([self.blowdryerField.text doubleValue] / 60) * 1000;
    hairstraightenerValue = ([self.hairstraightenerField.text doubleValue] / 60) * 1000;
    
    double groomingSubTotal;
    groomingSubTotal = (blowdryerValue + hairstraightenerValue) * 30 / 500;
    
    [self saveNumberToUserDefaults:[NSNumber numberWithDouble:groomingSubTotal] forKey:@"grooming"];
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

    UIScrollView *tempScrollView=(UIScrollView *)self.view;
	tempScrollView.contentSize=CGSizeMake(320,500);
    
	self.title = @"Grooming";
    
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonClicked)];
    self.navigationItem.rightBarButtonItem = doneButton;
    [doneButton autorelease];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadInputs];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self calculateScore];
    [self saveInputs];
}

#pragma mark - Done button event

- (void)doneButtonClicked {
    [self.delegate auditElectricityGroomingViewControllerDidDone:self];
    [[self navigationController] popViewControllerAnimated:YES];
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
