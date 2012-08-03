//
//  AuditHeatingViewController.m
//  ANUGreen
//
//  Created by Victor Hartanto Wibisono on 2/08/11.
//  Copyright 2011 ANUGreen. All rights reserved.
//

#import "AuditHeatingViewController.h"


@implementation AuditHeatingViewController

@synthesize valveField, thermostatField, heatingTable, myScroll, heatingModes, currentHeatingSelection;

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
	[textField resignFirstResponder];
	return YES;	
}

-(void)saveToUserDefaults:(NSNumber*)myResult forKey:(NSString*)myKey {
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (standardUserDefaults) {
        [standardUserDefaults setObject:myResult forKey:myKey];
        [standardUserDefaults synchronize];
    }
}

- (void)calculateScore {
    
    //Setting up the variables
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
    
    NSLog(@"Heating Subtotal = %g", heatingSubtotal);
    
    [self saveToUserDefaults:[NSNumber numberWithDouble:heatingSubtotal] forKey:@"heating"];
}

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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.valveField.delegate = self;
    self.thermostatField.delegate = self;
    
    self.heatingTable.delegate = self;
    self.heatingTable.dataSource = self;
    
    //Setting the content size of the scroll view
	self.myScroll.delegate = self;
    self.myScroll.contentSize=CGSizeMake(320,500);
    
    [self registerForKeyboardNotifications];
	
    heatingModes = [[NSArray alloc]
                    initWithObjects:@"Valve on the radiator", @"Thermostat", @"I have no controls", nil];
    
	self.title = @"Heating";
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [self calculateScore];
}

// Call this method somewhere in your view controller setup code.

- (void)registerForKeyboardNotifications
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}



// Called when the UIKeyboardDidShowNotification is sent.

- (void)keyboardDidShow:(NSNotification*)aNotification

{
    
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    
    self.view.center = CGPointMake(self.view.center.x, self.view.center.y - kbSize.height);
    [UIView commitAnimations];
    
    /* 
     
     commented out for the time being (not working yet)
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, kbSize.height, 0.0, 0.0);
    
    self.myScroll.contentInset = contentInsets;
    self.myScroll.scrollIndicatorInsets = contentInsets;
     
    */
    
}



// Called when the UIKeyboardWillHideNotification is sent

- (void)keyboardWillBeHidden:(NSNotification*)aNotification

{
    
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    
    self.myScroll.contentInset = contentInsets;
    self.myScroll.scrollIndicatorInsets = contentInsets;
    
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.

    return 3;
    
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"MenuListTableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...

    if (indexPath.row == 0) {
        cell.textLabel.text = @"Valve on the radiator";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"Thermostat";
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"I have no controls";
    }
    
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
    
    /*
    The code below will create an exclusive checklist from the heating modes.
    */
        
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSInteger catIndex = [heatingModes indexOfObject:self.currentHeatingSelection];
    
    if (catIndex == indexPath.row) {
        return;
    }
    NSIndexPath *oldIndexPath = [NSIndexPath indexPathForRow:catIndex inSection:0];
    
    
    UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
    if (newCell.accessoryType == UITableViewCellAccessoryNone) {
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
        self.currentHeatingSelection = [heatingModes objectAtIndex: indexPath.row];
    }
        
    UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:oldIndexPath];
    if (oldCell.accessoryType == UITableViewCellAccessoryCheckmark) {
        oldCell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    /*
     
     Here are the old codes
     
	if (indexPath.row == 0) {
        // When the 
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [self.valveField becomeFirstResponder];
        
	} else if (indexPath.row == 1) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [self.thermostatField becomeFirstResponder];
	} else {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
     
    */ 
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
