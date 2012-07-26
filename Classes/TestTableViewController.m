//
//  TestTableViewController.m
//  ANUGreen
//
//  Created by Victor Hartanto Wibisono on 2/08/11.
//  Copyright 2011 ANUGreen. All rights reserved.
//

#import "TestTableViewController.h"
#import "AuditResidenceViewController.h"
#import "AuditLightingViewController.h"
#import	"AuditElectricityTableViewController.h"
#import "AuditHeatingViewController.h"
#import "AuditWaterViewController.h"
#import "AuditCalculateViewController.h"
#import "InitiativesViewController.h"


@interface TestTableViewController()
@property (nonatomic, retain) NSArray *sections;
@property (nonatomic, retain) NSArray *menuResidence;
@property (nonatomic, retain) NSArray *menuScorecard;
@property (nonatomic, retain) NSArray *menuResult;
@property (nonatomic, retain) NSArray *scorecardImages;
@end

@implementation TestTableViewController

@synthesize sections, menuResidence, menuScorecard, menuResult, scorecardImages;

- (NSArray *)sections
{
	if (!sections) {
	
		NSString *aString[3]; 
		aString[0] = @"Personal Data";
		aString[1] = @"Scorecard";
		aString[2] = @"Result";
		
		sections = [[NSArray arrayWithObjects:aString count:3] retain];
		
		// strings array contains { @"First", @"Second" }
	}
	return sections;
}

- (NSArray *)menuResidence
{
	if (!menuResidence) {
		NSString *strings[1];
		strings[0] = @"Residence";
		
		menuResidence = [[NSArray arrayWithObjects:strings count:1] retain];
		// strings array contains { @"First", @"Second" }
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

#pragma mark -
#pragma mark Initialization

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
	self.title = @"Green Calculator";
	// self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

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
    UIImage *calculateImage = [UIImage imageNamed:@"clipboard-80.png"];
    
    // Configure the cell...

	if (indexPath.section == 0) {
		cell.textLabel.text = [self.menuResidence objectAtIndex:indexPath.row];
        cell.imageView.image = residenceImage;
	} else if (indexPath.section == 1) {
		cell.textLabel.text = [self.menuScorecard objectAtIndex:indexPath.row];
        cell.imageView.image = [self.scorecardImages objectAtIndex:indexPath.row];
	} else {
		cell.textLabel.text = [self.menuResult	objectAtIndex:indexPath.row];
        cell.imageView.image = calculateImage;
	};
	
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

	
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
	return [self.sections objectAtIndex:section];

}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    /*
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    */
	
	if (indexPath.section == 0) {
		AuditResidenceViewController *arvc = [[AuditResidenceViewController alloc] init];
		[self.navigationController pushViewController:arvc animated:YES];
		[arvc release];
	} else if (indexPath.section == 1) {
		if (indexPath.row == 0) {
            AuditLightingViewController *alvc = [[AuditLightingViewController alloc] init];
			[self.navigationController pushViewController:alvc animated:YES];
			[alvc release];
		} else if (indexPath.row == 1) {
			AuditElectricityTableViewController *aetvc = [[AuditElectricityTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
			[self.navigationController pushViewController:aetvc animated:YES];
			[aetvc release];
		} else if (indexPath.row == 2) {
			AuditHeatingViewController *ahvc = [[AuditHeatingViewController alloc] init];
			[self.navigationController pushViewController:ahvc animated:YES];
			[ahvc release];
		} else if (indexPath.row == 3) {
			AuditWaterViewController *awvc = [[AuditWaterViewController alloc] init];
			[self.navigationController pushViewController:awvc animated:YES];
			[awvc release];
		}
	} else if (indexPath.section == 2) {
		AuditCalculateViewController *acvc = [[AuditCalculateViewController alloc] init];
		[self.navigationController pushViewController:acvc animated:YES];
		[acvc release];
	}
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
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

