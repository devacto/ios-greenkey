//
//  AuditElectricityKitchenViewController.m
//  ANUGreen
//
//  Created by Victor Hartanto Wibisono on 2/08/11.
//  Copyright 2011 ANUGreen. All rights reserved.
//

#import "AuditElectricityKitchenViewController.h"
#import "ActionSheetPicker.h"


@implementation AuditElectricityKitchenViewController

@synthesize kettleField, microwaveField, coffeemachineField, toasterField;

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
    [ActionSheetStringPicker showPickerWithTitle:@"Select Minutes" rows:minutesList initialSelection:0 doneBlock:done cancelBlock:cancel origin:sender];}

#pragma mark - Save to user defaults

- (void)saveStringToUserDefaults:(NSString *)myResult forKey:(NSString *)myKey {
    NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (standardUserDefaults) {
        [standardUserDefaults setObject:myResult forKey:myKey];
        [standardUserDefaults synchronize];
    }
}

-(void)saveNumberToUserDefaults:(NSNumber*)myResult forKey:(NSString*)myKey {
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
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
    [self saveStringToUserDefaults:self.kettleField.text forKey:@"kettleField"];
    [self saveStringToUserDefaults:self.microwaveField.text forKey:@"microwaveField"];
    [self saveStringToUserDefaults:self.coffeemachineField.text forKey:@"coffeemachineField"];
    [self saveStringToUserDefaults:self.toasterField.text forKey:@"toasterField"];
}

- (void)loadInputs {
    self.kettleField.text = [self retrieveStringFromUserDefaultsForKey:@"kettleField"];
    self.microwaveField.text = [self retrieveStringFromUserDefaultsForKey:@"microwaveField"];
    self.coffeemachineField.text = [self retrieveStringFromUserDefaultsForKey:@"coffeemachineField"];
    self.toasterField.text = [self retrieveStringFromUserDefaultsForKey:@"toasterField"];
}

#pragma mark - Calculating score

- (void)calculateScore {
    
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
    
    [self saveNumberToUserDefaults:[NSNumber numberWithDouble:kitchenSubTotal] forKey:@"kitchen"];
}

#pragma mark - Done button event

- (void)doneButtonClicked {
    [self.delegate auditElectricityKitchenViewControllerDidDone:self];
    [[self navigationController] popViewControllerAnimated:YES];
}


#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadInputs];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Setting the content size of the scroll view
    UIScrollView *tempScrollView=(UIScrollView *)self.view;
	tempScrollView.contentSize=CGSizeMake(320,480);
    
	self.title = @"Kitchen";
    
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonClicked)];
    self.navigationItem.rightBarButtonItem = doneButton;
    [doneButton autorelease];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self calculateScore];
    [self saveInputs];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
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
