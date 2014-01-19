//
//  AuditResidenceViewController.m
//  ANUGreen
//
//  Created by Victor Hartanto Wibisono on 2/08/11.
//  Copyright 2011 ANUGreen. All rights reserved.
//

#import "AuditResidenceViewController.h"
#import "ActionSheetPicker.h"
#import "GAIDictionaryBuilder.h"
#import "GAITracker.h"
#import "GAI.h"


@implementation AuditResidenceViewController

@synthesize residenceField;
@synthesize wingField;
@synthesize roomSharingField;

@synthesize buildingList;

@synthesize bruceHallWings;
@synthesize burgmannCollegeWings;
@synthesize johnXXIIICollegeWings;
@synthesize ursulaHallWings;
@synthesize fennerHallWings;
@synthesize burtonGarranHallWings;
@synthesize delegate;

#pragma mark - Textfield Actions

// These methods are for the data source of the picker view object
// Components are the number of columns of the picker view

- (IBAction)selectAResidence:(UIControl *)sender {
    ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        if ([sender respondsToSelector:@selector(setText:)]) {
            [sender performSelector:@selector(setText:) withObject:selectedValue];
        }
    };
    ActionStringCancelBlock cancel = ^(ActionSheetStringPicker *picker) {
        NSLog(@"Block Picker Canceled");
    };
    [ActionSheetStringPicker showPickerWithTitle:@"Select a Residence" rows:buildingList initialSelection:0 doneBlock:done cancelBlock:cancel origin:sender];
}

- (IBAction)selectAWing:(UIControl *)sender {
    ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        if ([sender respondsToSelector:@selector(setText:)]) {
            [sender performSelector:@selector(setText:) withObject:selectedValue];
        }
    };
    ActionStringCancelBlock cancel = ^(ActionSheetStringPicker *picker) {
        NSLog(@"Block Picker Canceled");
    };
    if ([residenceField.text isEqualToString:@"Bruce Hall"]) {
        bruceHallWings = [[NSArray alloc]
                          initWithObjects:@"Bruce Hall Wing 1", @"Bruce Hall Wing 2", nil];
        [ActionSheetStringPicker showPickerWithTitle:@"Select a Building Wing" rows:bruceHallWings initialSelection:0 doneBlock:done cancelBlock:cancel origin:sender];
    } else if ([residenceField.text isEqualToString:@"Burgmann College"]) {
        burgmannCollegeWings = [[NSArray alloc]
                                initWithObjects:@"Burgmann Wing 1", @"Burgmann Wing 2", nil];
        [ActionSheetStringPicker showPickerWithTitle:@"Select a Building Wing" rows:burgmannCollegeWings initialSelection:0 doneBlock:done cancelBlock:cancel origin:sender];    
    } else if ([residenceField.text isEqualToString:@"John XXIII College"]) {
        johnXXIIICollegeWings = [[NSArray alloc]
                                 initWithObjects:@"John XXIII Wing 1", @"John XXIII Wing 2", nil];
        [ActionSheetStringPicker showPickerWithTitle:@"Select a Building Wing" rows:johnXXIIICollegeWings initialSelection:0 doneBlock:done cancelBlock:cancel origin:sender];
    } else if ([residenceField.text isEqualToString:@"Ursula Hall"]) {
        ursulaHallWings = [[NSArray alloc]
                           initWithObjects:@"Ursula Wing 1", @"Ursula Wing 2", nil];
        [ActionSheetStringPicker showPickerWithTitle:@"Select a Building Wing" rows:ursulaHallWings initialSelection:0 doneBlock:done cancelBlock:cancel origin:sender];
    } else if ([residenceField.text isEqualToString:@"Fenner Hall"]) {
        fennerHallWings = [[NSArray alloc]
                           initWithObjects:@"Fenner Wing 1", @"Fenner Wing 2", nil];
        [ActionSheetStringPicker showPickerWithTitle:@"Select a Building Wing" rows:fennerHallWings initialSelection:0 doneBlock:done cancelBlock:cancel origin:sender];
    } else if ([residenceField.text isEqualToString:@"Burton & Garran Hall"]) {
        burtonGarranHallWings = [[NSArray alloc]
                                 initWithObjects:@"B&G Wing 1", @"B&G Wing 2", nil];
        [ActionSheetStringPicker showPickerWithTitle:@"Select a Building Wing" rows:burtonGarranHallWings initialSelection:0 doneBlock:done cancelBlock:cancel origin:sender];        
    }

}

#pragma mark - Done Button Event

- (void)doneButtonClicked {
    [[self delegate] auditResidenceViewControllerDidDone:self];
    [[self navigationController] popViewControllerAnimated:YES];
    [self sendDataToGoogleAnalytics];
}

// Send hall results to Google Analytics
- (void)sendDataToGoogleAnalytics {
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"ui_action" action:@"button_press" label:@"residence_selection" value:self.residenceField.text] build]];
}


#pragma mark - Textfield Delegate

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField {
    return NO;
}

#pragma mark - Save to user defaults

- (void)saveStringToUserDefaults:(NSString *)input forKey:(NSString *)key {
    NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (standardUserDefaults) {
        [standardUserDefaults setObject:input forKey:key];
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
    [self saveStringToUserDefaults:self.residenceField.text forKey:@"residenceField"];
    [self saveStringToUserDefaults:self.wingField.text forKey:@"wingField"];
    [self saveStringToUserDefaults:[NSString stringWithFormat:@"%d", self.roomSharingField.selectedSegmentIndex] forKey:@"roomSharingField"];
}


- (void)loadInputs {
    self.residenceField.text = [self retrieveStringFromUserDefaultsForKey:@"residenceField"];
    self.wingField.text = [self retrieveStringFromUserDefaultsForKey:@"wingField"];
    self.roomSharingField.selectedSegmentIndex = [[self retrieveStringFromUserDefaultsForKey:@"roomSharingField"] integerValue];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
	self.title = @"Residence";
    
    buildingList = [[NSArray alloc]
                    initWithObjects:@"Bruce Hall", @"Burgmann College", @"John XXIII College", @"Ursula Hall", @"Fenner Hall", @"Burton & Garran Hall", @"Davey Lodge", @"Kinloch Lodge", @"Warrumbul Lodge", @"Lena Karmel Lodge", @"Off-campus", nil];
    
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonClicked)];
    self.navigationItem.rightBarButtonItem = doneButton;
    [doneButton release];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.screenName = @"Residence Screen";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadInputs];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self saveInputs];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
	[super viewDidUnload];
	self.residenceField = nil;
	self.wingField = nil;
    self.roomSharingField = nil;
}


- (void)dealloc {
	[residenceField release];
	[wingField release];
    [roomSharingField release];
    [bruceHallWings release];
    [super dealloc];
}


@end
