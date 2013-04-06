//
//  AuditElectricityCommunicationsViewController.m
//  ANUGreen
//
//  Created by Victor Hartanto Wibisono on 2/08/11.
//  Copyright 2011 ANUGreen. All rights reserved.
//

#import "AuditElectricityCommunicationsViewController.h"
#import "ActionSheetPicker.h"


@implementation AuditElectricityCommunicationsViewController

@synthesize laptopField, desktopField, printerField, scannerField, mobileField, ipodField, shutdownField, turnoffField;
@synthesize hoursList;
@synthesize delegate;


#pragma mark - Scroll picker events

- (IBAction)selectHours:(UIControl *)sender {
    hoursList = [[NSArray alloc]
                 initWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9",
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
    [self saveStringToUserDefaults:self.laptopField.text forKey:@"laptopField"];
    [self saveStringToUserDefaults:self.desktopField.text forKey:@"desktopField"];
    [self saveStringToUserDefaults:self.printerField.text forKey:@"printerField"];
    [self saveStringToUserDefaults:self.scannerField.text forKey:@"scannerField"];
    [self saveStringToUserDefaults:self.mobileField.text forKey:@"mobileField"];
    [self saveStringToUserDefaults:self.ipodField.text forKey:@"ipodField"];
    [self saveStringToUserDefaults:[NSString stringWithFormat:@"%d", self.shutdownField.selectedSegmentIndex] forKey:@"shutdownField"];
    [self saveStringToUserDefaults:[NSString stringWithFormat:@"%d", self.turnoffField.selectedSegmentIndex] forKey:@"turnoffField"];
}

- (void)loadInputs {
    self.laptopField.text  = [self retrieveStringFromUserDefaultsForKey:@"laptopField"];
    self.desktopField.text = [self retrieveStringFromUserDefaultsForKey:@"desktopField"];
    self.printerField.text = [self retrieveStringFromUserDefaultsForKey:@"printerField"];
    self.scannerField.text = [self retrieveStringFromUserDefaultsForKey:@"scannerField"];
    self.mobileField.text  = [self retrieveStringFromUserDefaultsForKey:@"mobileField"];
    self.ipodField.text    = [self retrieveStringFromUserDefaultsForKey:@"ipodField"];
    self.shutdownField.selectedSegmentIndex = [[self retrieveStringFromUserDefaultsForKey:@"shutdownField"] integerValue];
    self.turnoffField.selectedSegmentIndex  = [[self retrieveStringFromUserDefaultsForKey:@"turnoffField"] integerValue];
}

#pragma mark - Textfield delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return NO;
}

#pragma mark - Calculate score

- (void)calculateScore {
    double laptopValue;
    double desktopValue;
    double printerValue;
    double scannerValue;
    double mobileValue;
    double ipodValue;
    
    laptopValue = ([self.laptopField.text doubleValue]) * 60;
    desktopValue = ([self.desktopField.text doubleValue]) * 110;
    printerValue = ([self.printerField.text doubleValue]) * 25;
    scannerValue = ([self.scannerField.text doubleValue]) * 30;
    mobileValue = ([self.mobileField.text doubleValue]) * 0.5;
    ipodValue = ([self.ipodField.text doubleValue]) * 5;
    
    double communicationSubtotal;
    communicationSubtotal = (laptopValue + desktopValue + printerValue + scannerValue + mobileValue + ipodValue) * 30 / 1000;
    
    [self saveNumberToUserDefaults:[NSNumber numberWithDouble:communicationSubtotal] forKey:@"communication"];
}

#pragma mark - Done button event

- (void)doneButtonClicked {
    [self.delegate auditElectricityCommunicationsViewControllerDidDone:self];
    [[self navigationController] popViewControllerAnimated:YES];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView *tempScrollView=(UIScrollView *)self.view;
	tempScrollView.contentSize=CGSizeMake(320,680);
    
	self.title = @"Communications";
    
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonClicked)];
    self.navigationItem.rightBarButtonItem = doneButton;
    [doneButton autorelease];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self calculateScore];
    [self saveInputs];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadInputs];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
    self.laptopField = nil;
    self.desktopField = nil;
    self.printerField = nil;
    self.scannerField = nil;
    self.mobileField = nil;
    self.ipodField = nil;
}


- (void)dealloc {
    [laptopField release];
    [desktopField release];
    [printerField release];
    [scannerField release];
    [mobileField release];
    [ipodField release];
    
    [super dealloc];
}


@end
