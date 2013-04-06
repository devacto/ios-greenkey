//
//  AuditWaterViewController.m
//  ANUGreen
//
//  Created by Victor Hartanto Wibisono on 2/08/11.
//  Copyright 2011 ANUGreen. All rights reserved.
//

#import "AuditWaterViewController.h"
#import "ActionSheetPicker.h"


@implementation AuditWaterViewController

@synthesize showerField, tapField, halfflushField, fullflushField, washField, coldwashField, fullwashField;

@synthesize minutesList, numbersList;
@synthesize delegate;

#pragma mark - Picker view events

- (IBAction)selectMinutes:(UIControl *)sender {
    minutesList = [[NSArray alloc]
                   initWithObjects: @"0", @"10", @"20", @"30", @"40", @"50", @"60", @"70", @"80", @"90", @"100", @"110", @"120", @"130", @"140", @"150", @"160", @"170", @"180",                    @"190", @"200", @"210", @"220", @"230", @"240", @"250", @"260", @"270", @"280", @"290", @"300", nil];
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

- (IBAction)selectNumbers:(UIControl *)sender {
    numbersList = [[NSArray alloc]
                   initWithObjects: @"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", nil];
    ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        if ([sender respondsToSelector:@selector(setText:)]) {
            [sender performSelector:@selector(setText:) withObject:selectedValue];
        }
    };
    ActionStringCancelBlock cancel = ^(ActionSheetStringPicker *picker) {
        NSLog(@"Block Picker Canceled");
    };
    [ActionSheetStringPicker showPickerWithTitle:@"Select Numbers" rows:numbersList initialSelection:0 doneBlock:done cancelBlock:cancel origin:sender];
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
    [self saveStringToUserDefaults:self.showerField.text forKey:@"showerField"];
    [self saveStringToUserDefaults:self.tapField.text forKey:@"tapField"];
    [self saveStringToUserDefaults:self.halfflushField.text forKey:@"halfflushField"];
    [self saveStringToUserDefaults:self.fullflushField.text forKey:@"fullflushField"];
    [self saveStringToUserDefaults:self.washField.text forKey:@"washField"];
    
    [self saveStringToUserDefaults:[NSString stringWithFormat:@"%d", self.coldwashField.selectedSegmentIndex] forKey:@"coldwashField"];
    [self saveStringToUserDefaults:[NSString stringWithFormat:@"%d", self.fullwashField.selectedSegmentIndex] forKey:@"fullwashField"];
}

- (void)loadInputs {
    self.showerField.text = [self retrieveStringFromUserDefaultsForKey:@"showerField"];
    self.tapField.text = [self retrieveStringFromUserDefaultsForKey:@"tapField"];
    self.halfflushField.text = [self retrieveStringFromUserDefaultsForKey:@"halfflushField"];
    self.fullflushField.text = [self retrieveStringFromUserDefaultsForKey:@"fullflushField"];
    self.washField.text = [self retrieveStringFromUserDefaultsForKey:@"washField"];
    
    self.coldwashField.selectedSegmentIndex = [[self retrieveStringFromUserDefaultsForKey:@"coldwashField"] integerValue];
    self.fullwashField.selectedSegmentIndex = [[self retrieveStringFromUserDefaultsForKey:@"fullwashField"] integerValue];
}


#pragma mark - Score calculation

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
    
    [self saveNumberToUserDefaults:[NSNumber numberWithDouble:waterSubtotal] forKey:@"water"];
}


#pragma mark - Done button event

- (void)doneButtonClicked {
    [self.delegate auditWaterViewControllerDidDone:self];
    [[self navigationController] popViewControllerAnimated:YES];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Setting the content size of the scroll view
    UIScrollView *tempScrollView=(UIScrollView *)self.view;
	tempScrollView.contentSize=CGSizeMake(320,540);
    
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonClicked)];
    self.navigationItem.rightBarButtonItem = doneButton;
    
	self.title = @"Water";
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
