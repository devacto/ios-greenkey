//
//  AuditElectricityTableViewController.m
//  ANUGreen
//
//  Created by Victor Hartanto Wibisono on 2/08/11.
//  Copyright 2011 ANUGreen. All rights reserved.
//

#import "AuditElectricityTableViewController.h"
#import "AuditElectricityKitchenViewController.h"
#import "AuditElectricityCommunicationsViewController.h"
#import "AuditElectricityEntertainmentViewController.h"
#import "AuditElectricityGroomingViewController.h"

@interface AuditElectricityTableViewController()
@property (nonatomic, retain) NSArray *menu;

// properties for the checkmark
@property (nonatomic) BOOL kitchenDone;
@property (nonatomic) BOOL communicationsDone;
@property (nonatomic) BOOL entertainmentDone;
@property (nonatomic) BOOL groomingDone;

@end

@implementation AuditElectricityTableViewController

@synthesize menu;
@synthesize delegate;
@synthesize kitchenDone, communicationsDone, entertainmentDone, groomingDone;

- (NSArray *) menu {
	if (!menu) {
		NSString *strings[4];
		strings[0] = @"Kitchen";
		strings[1] = @"Communications";
		strings[2] = @"Entertainment";
		strings[3] = @"Grooming";
		
		menu = [[NSArray arrayWithObjects:strings count:4] retain];
	}
	
	return menu;
}

#pragma mark - Done button event

- (void)doneButtonClicked {
    [self.delegate auditElectricityTableViewControllerDidDone:self];
    [[self navigationController] popViewControllerAnimated:YES];
}

#pragma mark - AuditElectricityKitchenViewControllerDelegate

- (void)auditElectricityKitchenViewControllerDidDone:(AuditElectricityKitchenViewController *)controller {
    kitchenDone = YES;
    [self.tableView reloadData];
}

#pragma mark - AuditElectricityEntertainmentViewControllerDelegate

- (void)auditElectricityEntertainmentViewControllerDidDone:(AuditElectricityEntertainmentViewController *)controller {
    entertainmentDone = YES;
    [self.tableView reloadData];
}

#pragma mark - AuditElectricityCommunicationsViewControllerDelegate

- (void)auditElectricityCommunicationsViewControllerDidDone:(AuditElectricityCommunicationsViewController *)controller {
    communicationsDone = YES;
    [self.tableView reloadData];
}

#pragma mark - AuditElectricityGroomingViewControllerDelegate

- (void)auditElectricityGroomingViewControllerDidDone:(AuditElectricityGroomingViewController *)controller {
    groomingDone = YES;
    [self.tableView reloadData];
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialiseAllDoneToFalse];
	
	self.title = @"Electricity";
    
    UIBarButtonItem * backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonClicked)];
    self.navigationItem.rightBarButtonItem = doneButton;
    [doneButton autorelease];
    [backButton autorelease];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.menu.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    
	cell.textLabel.text = [self.menu objectAtIndex:indexPath.row];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    // This is to mark the cell which are done with the checkmark
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            if (kitchenDone == YES) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
        } else if (indexPath.row == 1) {
            if (communicationsDone == YES) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
        } else if (indexPath.row == 2) {
            if (entertainmentDone == YES) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
        } else if (indexPath.row == 3) {
            if (groomingDone == YES) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
        }
    }
	
    return cell;
}

#pragma mark - Initialising boolean variables

- (void)initialiseAllDoneToFalse {
    self.kitchenDone = NO;
    self.communicationsDone = NO;
    self.entertainmentDone = NO;
    self.groomingDone = NO;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if (indexPath.row == 0) {
		AuditElectricityKitchenViewController *aekvc = [[AuditElectricityKitchenViewController alloc] init];
        aekvc.delegate = self;
		[self.navigationController pushViewController:aekvc animated:YES];
		[aekvc release];
	} else if (indexPath.row == 1) {
		AuditElectricityCommunicationsViewController *aecvc = [[AuditElectricityCommunicationsViewController alloc] init];
        aecvc.delegate = self;
		[self.navigationController pushViewController:aecvc animated:YES];
		[aecvc release];
	} else if (indexPath.row == 2) {
		AuditElectricityEntertainmentViewController *aeevc = [[AuditElectricityEntertainmentViewController alloc] init];
        aeevc.delegate = self;
		[self.navigationController pushViewController:aeevc animated:YES];
		[aeevc release];
	} else if (indexPath.row == 3) {
		AuditElectricityGroomingViewController *aegvc = [[AuditElectricityGroomingViewController alloc] init];
        aegvc.delegate = self;
		[self.navigationController pushViewController:aegvc animated:YES];
		[aegvc release];
	}
}

#pragma mark - Memory management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {

}


- (void)dealloc {
	[menu release];
    [super dealloc];
}


@end

