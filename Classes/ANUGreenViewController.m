//
//  ANUGreenViewController.m
//  ANUGreen
//
//  Created by Victor Hartanto Wibisono on 28/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ANUGreenViewController.h"
#import "AboutAppViewController.h"
#import "AboutANUGreenViewController.h"
#import "TestTableViewController.h"

@implementation ANUGreenViewController

- (IBAction)aboutApp {
	
	AboutAppViewController *aavc = [[AboutAppViewController alloc] init];
	
	aavc.title = [NSString stringWithFormat:@"Credits"];
    
    UIBarButtonItem * backButton = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStylePlain target:self.parentViewController action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    
	[self.navigationController pushViewController:aavc animated:YES];
    [backButton release];
	[aavc release];
	
}

- (IBAction)aboutANUGreen {

	AboutANUGreenViewController *aagvc = [[AboutANUGreenViewController alloc] init];
	
	aagvc.title = [NSString stringWithFormat:@"ANUgreen"];
    
    UIBarButtonItem * backButton = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStylePlain target:self.parentViewController action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    
	[self.navigationController pushViewController:aagvc animated:YES];
    [backButton release];
	[aagvc release];
	
}

- (IBAction)audit {

	TestTableViewController *ttvc = [[TestTableViewController alloc] initWithStyle: UITableViewStyleGrouped];
    
    UIColor *uni25 = [[UIColor alloc] initWithRed:234/255.f green:239/255.f blue:241/255.f alpha:1];
	
    ttvc.tableView.backgroundColor = uni25;
	ttvc.title = [NSString stringWithFormat:@"Energy Audit"];
    
    UIBarButtonItem * backButton = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStylePlain target:self.parentViewController action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    
	[self.navigationController pushViewController:ttvc animated:YES];
    [backButton release];
	[ttvc release];
    [uni25 release];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.title = @"Green Key";
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
}

@end
