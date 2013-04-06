//
//  AuditElectricityEntertainmentViewController.m
//  ANUGreen
//
//  Created by Victor Hartanto Wibisono on 2/08/11.
//  Copyright 2011 ANUGreen. All rights reserved.
//

#import "AuditElectricityEntertainmentViewController.h"
#import "ActionSheetPicker.h"


@implementation AuditElectricityEntertainmentViewController

@synthesize lcdtvField, plasmatvField, standardtvField, stereoField, speakerField, consoleField;
@synthesize hoursList;
@synthesize delegate;

#pragma mark - Scroll picker events

- (IBAction) selectHours:(UIControl *)sender {
    hoursList = [[NSArray alloc]
                 initWithObjects: @"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9",
                 @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20",
                 @"21", @"22", @"23", @"24", nil];
    ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        if ([sender respondsToSelector:@selector(setText:)]) {
            [sender performSelector:@selector(setText:) withObject:selectedValue];
        }
    };
    ActionStringCancelBlock cancel = ^(ActionSheetStringPicker *picker) {
        NSLog(@"Block Picker Canceled");
    };
    [ActionSheetStringPicker showPickerWithTitle:@"Select Hours" rows:hoursList initialSelection:0 doneBlock:done cancelBlock:cancel origin:sender];     
    
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
    [self saveStringToUserDefaults:self.lcdtvField.text forKey:@"lcdtvField"];
    [self saveStringToUserDefaults:self.plasmatvField.text forKey:@"plasmatvField"];
    [self saveStringToUserDefaults:self.standardtvField.text forKey:@"standardtvField"];
    [self saveStringToUserDefaults:self.stereoField.text forKey:@"stereoField"];
    [self saveStringToUserDefaults:self.speakerField.text forKey:@"speakerField"];
    [self saveStringToUserDefaults:self.consoleField.text forKey:@"consoleField"];
}

- (void)loadInputs {
    self.lcdtvField.text = [self retrieveStringFromUserDefaultsForKey:@"lcdtvField"];
    self.plasmatvField.text = [self retrieveStringFromUserDefaultsForKey:@"plasmatvField"];
    self.standardtvField.text = [self retrieveStringFromUserDefaultsForKey:@"standardtvField"];
    self.stereoField.text = [self retrieveStringFromUserDefaultsForKey:@"stereoField"];
    self.speakerField.text = [self retrieveStringFromUserDefaultsForKey:@"speakerField"];
    self.consoleField.text = [self retrieveStringFromUserDefaultsForKey:@"consoleField"];
}

#pragma mark - Calculate score

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
    
    [self saveNumberToUserDefaults:[NSNumber numberWithDouble:entertainmentSubtotal] forKey:@"entertainment"];
}

#pragma mark - Done button event

- (void)doneButtonClicked {
    [self.delegate auditElectricityEntertainmentViewControllerDidDone:self];
    [[self navigationController] popViewControllerAnimated:YES];
}


#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Setting the content size of the scroll view
    UIScrollView *tempScrollView=(UIScrollView *)self.view;
	tempScrollView.contentSize=CGSizeMake(320,520);
	
	self.title = @"Entertainment";
    
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
