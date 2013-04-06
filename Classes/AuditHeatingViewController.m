//
//  AuditHeatingViewController.m
//  ANUGreen
//
//  Created by Victor Hartanto Wibisono on 2/08/11.
//  Copyright 2011 ANUGreen. All rights reserved.
//

#import "AuditHeatingViewController.h"
#import "ActionSheetPicker.h"


@implementation AuditHeatingViewController

@synthesize valveField, thermostatField, heatingTable, myScroll, heatingModes, currentHeatingSelection;
@synthesize thermostatList, valveList;
@synthesize valveSelected, thermostatSelected, noControSelected;
@synthesize delegate;

#pragma mark - Scroll picker events

- (IBAction)selectValveSettings:(UIControl *)sender {    
    valveList = [[NSArray alloc]
                 initWithObjects: @"0", @"1", @"2", @"3", @"4", @"5", nil];
    
    ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        if ([sender respondsToSelector:@selector(setText:)]) {
            [sender performSelector:@selector(setText:) withObject:selectedValue];
        }
    };
    ActionStringCancelBlock cancel = ^(ActionSheetStringPicker *picker) {
        NSLog(@"Block Picker Canceled");
    };
    [ActionSheetStringPicker showPickerWithTitle:@"Select Settings" rows:valveList initialSelection:0 doneBlock:done cancelBlock:cancel origin:sender];
}

- (IBAction)selectThermostatSettings:(UIControl *)sender {
    thermostatList = [[NSArray alloc]
                      initWithObjects: @"0", @"20", @"21", @"22", @"23", @"24", @"25", @"26", @"27", @"28", @"29", @"30",nil];
    
    ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        if ([sender respondsToSelector:@selector(setText:)]) {
            [sender performSelector:@selector(setText:) withObject:selectedValue];
        }
    };
    
    ActionStringCancelBlock cancel = ^(ActionSheetStringPicker *picker) {
        NSLog(@"Block Picker Canceled");
    };
    
    [ActionSheetStringPicker showPickerWithTitle:@"Select Settings" rows:thermostatList initialSelection:0 doneBlock:done cancelBlock:cancel origin:sender];
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

- (void)saveBOOLToUserDefaults:(BOOL)myResult forKey:(NSString *)myKey {
    NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (standardUserDefaults) {
        [standardUserDefaults setBool:myResult forKey:myKey];
        [standardUserDefaults synchronize];
    }}

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

- (BOOL)retrieveBOOLFromUserDefaultsForKey:(NSString *)key {
    NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
    BOOL value = NO;
    
    if (standardUserDefaults) {
        if ([standardUserDefaults objectForKey:key]) {
            value = [standardUserDefaults boolForKey:key];
        }
    }
    
    return value;
}

#pragma mark - Saving and loading inputs

- (void)saveInputs {
    [self saveStringToUserDefaults:self.valveField.text forKey:@"valveField"];
    [self saveStringToUserDefaults:self.thermostatField.text forKey:@"thermostatField"];

    [self saveBOOLToUserDefaults:self.valveSelected forKey:@"valveSelectedField"];
    [self saveBOOLToUserDefaults:self.thermostatSelected forKey:@"thermostatSelectedField"];
    [self saveBOOLToUserDefaults:noControSelected forKey:@"noControlSelectedField"];
    
}

- (void)loadInputs {
    
    self.valveField.text = [self retrieveStringFromUserDefaultsForKey:@"valveField"];
    self.thermostatField.text = [self retrieveStringFromUserDefaultsForKey:@"thermostatField"];
    
    if ([self retrieveBOOLFromUserDefaultsForKey:@"valveSelectedField"] == YES) {
        self.valveSelected = YES;
        self.thermostatSelected = NO;
        self.noControSelected = NO;
        [self tableView:heatingTable didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        //[[self heatingTable] reloadData];
    } 
    
    if ([self retrieveBOOLFromUserDefaultsForKey:@"thermostatSelectedField"] == YES) {
        self.valveSelected = NO;
        self.thermostatSelected = YES;
        self.noControSelected = NO;
        [self tableView:heatingTable didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        //[[self heatingTable] reloadData];
    } 
    
    if ([self retrieveBOOLFromUserDefaultsForKey:@"noControlSelectedField"] == YES) {
        self.valveSelected = NO;
        self.thermostatSelected = NO;
        self.noControSelected = YES;
        [self tableView:heatingTable didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
        //[[self heatingTable] reloadData];
        
    }
}

#pragma mark - Done button event

- (void)doneButtonClicked {
    [self.delegate auditHeatingViewControllerDidDone:self];
    [[self navigationController] popViewControllerAnimated:YES];
}

#pragma mark - Calculating score

- (void)calculateScore {

    double valveValue;
    double thermostatValue;
    
    valveValue = [self.valveField.text doubleValue];
    thermostatValue = [self.thermostatField.text doubleValue];
    
    double heatingSubtotal;
    heatingSubtotal = 0;
    
    if (thermostatValue > 0) {
        heatingSubtotal = thermostatValue;
    } else if (valveValue > 0) {
        if (valveValue == 1) {
            heatingSubtotal = 22;
        } else if (valveValue == 2) {
            heatingSubtotal = 24;
        } else if (valveValue == 3) {
            heatingSubtotal = 26;
        } else if (valveValue == 4) {
            heatingSubtotal = 28;
        } else if (valveValue == 5) {
            heatingSubtotal = 30;
        }
    } else {
        heatingSubtotal = 21;
    }
    
    [self saveNumberToUserDefaults:[NSNumber numberWithDouble:heatingSubtotal] forKey:@"heating"];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.heatingTable.delegate = self;
    self.heatingTable.dataSource = self;
    
	self.myScroll.delegate = self;
    self.myScroll.contentSize=CGSizeMake(320,500);
	
    heatingModes = [[NSArray alloc]
                    initWithObjects:@"Valve on the radiator", @"Thermostat", @"I have no controls", nil];
    
	self.title = @"Heating";
    
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"MenuListTableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }

    if (indexPath.row == 0) {
        cell.textLabel.text = @"Valve on the radiator";
        if (valveSelected == YES) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"Thermostat";
        if (thermostatSelected == YES) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"I have no controls";
    }
    
    return cell;
}

#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSInteger catIndex = [heatingModes indexOfObject:self.currentHeatingSelection];
    
    if (catIndex == indexPath.row) {
        return;
    }
    NSIndexPath *oldIndexPath = [NSIndexPath indexPathForRow:catIndex inSection:0];
    
    UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
    if (newCell.accessoryType == UITableViewCellAccessoryNone) {
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
        self.currentHeatingSelection = [heatingModes objectAtIndex:indexPath.row];
    }
        
    UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:oldIndexPath];
    if (oldCell.accessoryType == UITableViewCellAccessoryCheckmark) {
        oldCell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    if (indexPath.row == 0) {
        self.valveField.enabled = YES;
        self.valveField.backgroundColor = [UIColor whiteColor];
        self.thermostatField.enabled = NO;
        self.thermostatField.text = @"0";
        self.thermostatField.backgroundColor = [UIColor grayColor];
        self.valveSelected = YES;
        self.thermostatSelected = NO;
        self.noControSelected = NO;
    } else if (indexPath.row == 1) {
        self.thermostatField.enabled = YES;
        self.thermostatField.backgroundColor = [UIColor whiteColor];
        self.valveField.enabled = NO;
        self.valveField.text = @"0";
        self.valveField.backgroundColor = [UIColor grayColor];
        self.valveSelected = NO;
        self.thermostatSelected = YES;
        self.noControSelected = NO;
    } else {
        self.thermostatField.enabled = NO;
        self.valveField.enabled = NO;
        self.thermostatField.text = @"0";
        self.valveField.text = @"0";
        self.thermostatField.backgroundColor = [UIColor grayColor];
        self.valveField.backgroundColor = [UIColor grayColor];
        self.valveSelected = NO;
        self.thermostatSelected = NO;
        self.noControSelected = NO;
    }
    
}

#pragma mark - Deallocation and garbage collection

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
    self.valveField = nil;
    self.thermostatField = nil;
    self.myScroll = nil;
    self.heatingTable = nil;
}


- (void)dealloc {
    [valveField release];
    [thermostatField release];
    [myScroll release];
    [heatingTable release];
    
    [super dealloc];
}


@end
