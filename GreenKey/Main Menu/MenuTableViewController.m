//
//  MenuTableViewController.m
//  ANUGreen
//
//  Created by Victor Hartanto Wibisono on 2/08/11.
//  Copyright 2011 ANUGreen. All rights reserved.
//

#import "MenuTableViewController.h"
#import "AuditResidenceViewController.h"
#import "AuditLightingViewController.h"
#import	"AuditElectricityTableViewController.h"
#import "AuditHeatingViewController.h"
#import "AuditWaterViewController.h"
#import "AuditCalculateViewController.h"


@interface MenuTableViewController()
@property (nonatomic, retain) NSArray *sections;
@property (nonatomic, retain) NSArray *menuResidence;
@property (nonatomic, retain) NSArray *menuScorecard;
@property (nonatomic, retain) NSArray *menuResult;
@property (nonatomic, retain) NSArray *scorecardImages;

// properties for the checkmark on the different sections
@property (nonatomic) BOOL residenceDone;
@property (nonatomic) BOOL lightingDone;
@property (nonatomic) BOOL electricityDone;
@property (nonatomic) BOOL heatingDone;
@property (nonatomic) BOOL waterDone;

@end

@implementation MenuTableViewController

@synthesize sections, menuResidence, menuScorecard, menuResult, scorecardImages;
@synthesize residenceDone, lightingDone, electricityDone, heatingDone, waterDone;

#pragma mark - Data initialisation to generate the menu

- (NSArray *)sections
{
	if (!sections) {
	
		NSString *aString[3]; 
		aString[0] = @"Personal Data";
		aString[1] = @"Scorecard";
		aString[2] = @"Result";
		
		sections = [[NSArray arrayWithObjects:aString count:3] retain];
        
	}
	return sections;
}

- (NSArray *)menuResidence
{
	if (!menuResidence) {
		NSString *strings[1];
		strings[0] = @"Residence";
		
		menuResidence = [[NSArray arrayWithObjects:strings count:1] retain];
	}
	return menuResidence;
}

- (NSArray *)menuScorecard
{
	if (!menuScorecard) {
		NSString *strings[4];
		strings[0] = @"Lighting";
		strings[1] = @"Electricity";
		strings[2] = @"Heating";
		strings[3] = @"Water";
		
		menuScorecard = [[NSArray arrayWithObjects:strings count:4] retain];
	}
	
	return menuScorecard;
}

- (NSArray *)menuResult
{
	if (!menuResult) {
		NSString *strings[1];
		strings[0] = @"Calculate";
		
		menuResult = [[NSArray	arrayWithObjects:strings count:1] retain];
	}
	
	return menuResult;
}

- (NSArray *)scorecardImages
{
    
    if (!scorecardImages) {
        
        UIImage *images[4];
        images[0] = [UIImage imageNamed:@"light-80.png"];
        images[1] = [UIImage imageNamed:@"elecplug-80.png"];
        images[2] = [UIImage imageNamed:@"gas-80.png"];
        images[3] = [UIImage imageNamed:@"water-80.png"];
        
        scorecardImages = [[NSArray arrayWithObjects:images count:4] retain];
        
    }
    
    return scorecardImages;
    
}

#pragma mark - Saving to user defaults

- (void)saveBOOLToUserDefaults:(BOOL)myResult forKey:(NSString *)myKey {
    NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (standardUserDefaults) {
        [standardUserDefaults setBool:myResult forKey:myKey];
        [standardUserDefaults synchronize];
    }
}

#pragma mark - Loading from user defaults

- (BOOL)retrieveBOOLFromUserDefaultsForKey:(NSString *)key {
    NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
    BOOL value = NO;
    
    if (standardUserDefaults) {
        if ([standardUserDefaults objectForKey:key]) {
            value = [standardUserDefaults boolForKey:key];
        } else {
            value = NO;
        }
    }
    
    return value;
}

#pragma mark - Saving and loading inputs

- (void)saveInputs {
    [self saveBOOLToUserDefaults:residenceDone forKey:@"residenceDone"];
    [self saveBOOLToUserDefaults:lightingDone forKey:@"lightingDone"];
    [self saveBOOLToUserDefaults:electricityDone forKey:@"electricityDone"];
    [self saveBOOLToUserDefaults:heatingDone forKey:@"heatingDone"];
    [self saveBOOLToUserDefaults:waterDone forKey:@"waterDone"];
}

- (void)loadInputs {
    self.residenceDone = [self retrieveBOOLFromUserDefaultsForKey:@"residenceDone"];
    self.lightingDone  = [self retrieveBOOLFromUserDefaultsForKey:@"lightingDone"];
    self.electricityDone = [self retrieveBOOLFromUserDefaultsForKey:@"electricityDone"];
    self.heatingDone = [self retrieveBOOLFromUserDefaultsForKey:@"heatingDone"];
    self.waterDone = [self retrieveBOOLFromUserDefaultsForKey:@"waterDone"];
}

#pragma mark - Initialising Boolean Variables

- (void)initialiseAllDoneToFalse {
    self.residenceDone = NO;
    self.lightingDone = NO;
    self.electricityDone = NO;
    self.heatingDone = NO;
    self.waterDone = NO;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem * backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    
    [backButton release];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadInputs];
    [[self tableView] reloadData];
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return self.sections.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section == 0) {
		return 1;
	} else if (section == 1) {
		return 4;	
	} else {
		return 1;
	}

}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"MenuListTableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    UIImage *residenceImage = [UIImage imageNamed:@"home-80.png"];
    // UIImage *calculateImage = [UIImage imageNamed:@"clipboard-80.png"];
    
    UIColor * colorWhite  = [[UIColor alloc] initWithWhite:1.0 alpha:1.0];
    UIColor * colorVictor = [[UIColor alloc] initWithRed:0.0 green:148/255.f blue:68/255.f alpha:1];
    
    // Configure the cell...

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
	if (indexPath.section == 0) {
		cell.textLabel.text = [self.menuResidence objectAtIndex:indexPath.row];
        cell.imageView.image = residenceImage;
        if (residenceDone == YES) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
	} else if (indexPath.section == 1) {
		cell.textLabel.text = [self.menuScorecard objectAtIndex:indexPath.row];
        cell.imageView.image = [self.scorecardImages objectAtIndex:indexPath.row];
        
        if (indexPath.row == 0) {
            if (lightingDone == YES) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
        } else if (indexPath.row == 1) {
            if (electricityDone == YES) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
        } else if (indexPath.row == 2) {
            if (heatingDone == YES) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
        } else if (indexPath.row == 3) {
            if (waterDone == YES) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
        }
        
        
	} else {
		cell.textLabel.text = [self.menuResult	objectAtIndex:indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.backgroundColor = colorVictor;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
        cell.textLabel.textColor = colorWhite;
        
	};
	
    [colorWhite release];
    [colorVictor release];
    
    return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
	return [self.sections objectAtIndex:section];

}

#pragma mark - AuditLightingViewControllerDelegate

- (void)auditLightingViewControllerDidDone:(AuditLightingViewController *)controller {
    
    lightingDone = YES;
    [self saveInputs];
    [self.tableView reloadData];
}

#pragma mark - AuditResidenceViewControllerDelegate

- (void)auditResidenceViewControllerDidDone:(AuditResidenceViewController *)controller {
    
    residenceDone = YES;
    [self saveInputs];
    [self.tableView reloadData];
    
}

#pragma mark - AuditElectricityTableViewControllerDelegate

- (void)auditElectricityTableViewControllerDidDone:(AuditElectricityTableViewController *)controller {
    electricityDone = YES;
    [self saveInputs];
    [self.tableView reloadData];
}

#pragma mark - AuditHeatingViewControllerDelegate

- (void)auditHeatingViewControllerDidDone:(AuditHeatingViewController *)controller {
    heatingDone = YES;
    [self saveInputs];
    [self.tableView reloadData];
}

#pragma mark - AuditWaterViewControllerDelegate

- (void)auditWaterViewControllerDidDone:(AuditWaterViewController *)controller {
    waterDone = YES;
    [self saveInputs];
    [self.tableView reloadData];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if (indexPath.section == 0) {
		AuditResidenceViewController *arvc = [[AuditResidenceViewController alloc] init];
        arvc.delegate = self;
		[self.navigationController pushViewController:arvc animated:YES];
		[arvc release];
	} else if (indexPath.section == 1) {
		if (indexPath.row == 0) {
            AuditLightingViewController *alvc = [[AuditLightingViewController alloc] init];
            alvc.delegate = self;
			[self.navigationController pushViewController:alvc animated:YES];
			[alvc release];
		} else if (indexPath.row == 1) {
			AuditElectricityTableViewController *aetvc = [[AuditElectricityTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
            aetvc.delegate = self;
			[self.navigationController pushViewController:aetvc animated:YES];
			[aetvc release];
		} else if (indexPath.row == 2) {
			AuditHeatingViewController *ahvc = [[AuditHeatingViewController alloc] init];
            ahvc.delegate = self;
			[self.navigationController pushViewController:ahvc animated:YES];
			[ahvc release];
		} else if (indexPath.row == 3) {
			AuditWaterViewController *awvc = [[AuditWaterViewController alloc] init];
            awvc.delegate = self;
			[self.navigationController pushViewController:awvc animated:YES];
			[awvc release];
		}
	} else if (indexPath.section == 2) {
		AuditCalculateViewController *acvc = [[AuditCalculateViewController alloc] init];
		[self.navigationController pushViewController:acvc animated:YES];
		[acvc release];
	}
}

#pragma mark - Memory management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {

}


- (void)dealloc {
    [sections release];
	[menuResult release];
	[menuResidence release];
	[menuScorecard release];
    [scorecardImages release];
    
	[super dealloc];
}


@end

