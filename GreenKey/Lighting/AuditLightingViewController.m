//
//  AuditLightingViewController.m
//  ANUGreen
//
//  Created by Victor Hartanto Wibisono on 2/08/11.
//  Copyright 2011 ANUGreen. All rights reserved.
//

#import "AuditLightingViewController.h"
#import "ActionSheetPicker.h"


@implementation AuditLightingViewController

@synthesize compactFluorescentField, linearFluorescentField, circularFluorescentField, compactDownlightField, halogenDownlightField, incandescentBulbField, noCompactFluorescentField, noLinearFluorescentField, noCircularFluorescentField, noCompactDownlightField, noHalogenDownlightField, noIncandescentBulbField, turnOff;

@synthesize numberOfBulbList, durationList;
@synthesize delegate;

// The method below is used to get the scroll picker up for the fields

#pragma mark - ActionSheetPicker Instances

- (IBAction) selectNumber:(UIControl *) sender {

    ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        if ([sender respondsToSelector:@selector(setText:)]) {
            [sender performSelector:@selector(setText:) withObject:selectedValue];
        }
    };
    ActionStringCancelBlock cancel = ^(ActionSheetStringPicker *picker) {
        //NSLog(@"Block Picker Canceled");
    };
    [ActionSheetStringPicker showPickerWithTitle:@"Select Number" rows:numberOfBulbList initialSelection:0 doneBlock:done cancelBlock:cancel origin:sender];
}

- (IBAction) selectDuration:(UIControl *) sender {
    
    ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        if ([sender respondsToSelector:@selector(setText:)]) {
            [sender performSelector:@selector(setText:) withObject:selectedValue];
        }
    };
    ActionStringCancelBlock cancel = ^(ActionSheetStringPicker *picker) {
        //NSLog(@"Block Picker Canceled");
    };
    [ActionSheetStringPicker showPickerWithTitle:@"Select Hours" rows:durationList initialSelection:0 doneBlock:done cancelBlock:cancel origin:sender];
    
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

#pragma mark - Score calculation

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
    
    [self saveNumberToUserDefaults:[NSNumber numberWithDouble:lightingSubtotal] forKey:@"lighting"];
}

#pragma mark - Saving and loading inputs

- (void)saveInputs {
    // saving the numbers
    [self saveStringToUserDefaults:self.noCompactFluorescentField.text forKey:@"noCompactFluorescentField"];
    [self saveStringToUserDefaults:self.noLinearFluorescentField.text forKey:@"noLinearFluorescentField"];
    [self saveStringToUserDefaults:self.noCircularFluorescentField.text forKey:@"noCircularFluorescentField"];
    [self saveStringToUserDefaults:self.noCompactDownlightField.text forKey:@"noCompactDownlightField"];
    [self saveStringToUserDefaults:self.noHalogenDownlightField.text forKey:@"noHalogenDownlightField"];
    [self saveStringToUserDefaults:self.noIncandescentBulbField.text forKey:@"noIncandescentBulbField"];
    
    // saving the duration
    [self saveStringToUserDefaults:self.compactFluorescentField.text forKey:@"compactFluorescentField"];
    [self saveStringToUserDefaults:self.linearFluorescentField.text forKey:@"linearFluorescentField"];
    [self saveStringToUserDefaults:self.circularFluorescentField.text forKey:@"circularFluorescentField"];
    [self saveStringToUserDefaults:self.compactDownlightField.text forKey:@"compactDownlightField"];
    [self saveStringToUserDefaults:self.halogenDownlightField.text forKey:@"halogenDownlightField"];
    [self saveStringToUserDefaults:self.incandescentBulbField.text forKey:@"incandescentBulbField"];
    
    // saving turn off segmented control
    [self saveStringToUserDefaults:[NSString stringWithFormat:@"%d",self.turnOff.selectedSegmentIndex] forKey:@"turnOffField"];
}

- (void)loadInputs {
    self.noCompactFluorescentField.text = [self retrieveStringFromUserDefaultsForKey:@"noCompactFluorescentField"];
    self.noLinearFluorescentField.text = [self retrieveStringFromUserDefaultsForKey:@"noLinearFluorescentField"];
    self.noCircularFluorescentField.text = [self retrieveStringFromUserDefaultsForKey:@"noCircularFluorescentField"];
    self.noCompactDownlightField.text = [self retrieveStringFromUserDefaultsForKey:@"noCompactDownlightField"];
    self.noHalogenDownlightField.text = [self retrieveStringFromUserDefaultsForKey:@"noHalogenDownlightField"];
    self.noIncandescentBulbField.text = [self retrieveStringFromUserDefaultsForKey:@"noIncandescentBulbField"];
    
    self.compactFluorescentField.text = [self retrieveStringFromUserDefaultsForKey:@"compactFluorescentField"];
    self.linearFluorescentField.text = [self retrieveStringFromUserDefaultsForKey:@"linearFluorescentField"];
    self.circularFluorescentField.text = [self retrieveStringFromUserDefaultsForKey:@"circularFluorescentField"];
    self.compactDownlightField.text = [self retrieveStringFromUserDefaultsForKey:@"compactDownlightField"];
    self.halogenDownlightField.text = [self retrieveStringFromUserDefaultsForKey:@"halogenDownlightField"];
    self.incandescentBulbField.text = [self retrieveStringFromUserDefaultsForKey:@"incandescentBulbField"];
    
    self.turnOff.selectedSegmentIndex = [[self retrieveStringFromUserDefaultsForKey:@"turnOffField"] integerValue];
}

#pragma mark - Done Button

- (void)doneButtonClicked {
    
    /* When the done button is clicked
     * the data in the view controller is saved
     * the score is calculated
     * go back to previous view controller (done!)
     * add a checkmark into the cell of the previous view controller (done!)
     */
    [self.delegate auditLightingViewControllerDidDone:self];
    [[self navigationController] popViewControllerAnimated:YES];
    
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    numberOfBulbList = [[NSArray alloc]
                        initWithObjects:@"0" ,@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", nil];
    
    durationList = [[NSArray alloc] 
                    initWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10",
                    @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20",
                    @"21", @"22", @"23", @"24", nil];
    
    UIScrollView *tempScrollView=(UIScrollView *)self.view;
	tempScrollView.contentSize=CGSizeMake(320,680);
    
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonClicked)];
    self.navigationItem.rightBarButtonItem = doneButton;
	self.title = @"Lighting";
    
    [doneButton autorelease];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadInputs];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [self saveInputs];
    [self calculateScore];
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
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
