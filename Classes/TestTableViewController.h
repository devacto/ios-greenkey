//
//  TestTableViewController.h
//  ANUGreen
//
//  Created by Victor Hartanto Wibisono on 2/08/11.
//  Copyright 2011 ANUGreen. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AuditLightingViewController.h"
#import "AuditResidenceViewController.h"
#import "AuditElectricityTableViewController.h"
#import "AuditHeatingViewController.h"
#import "AuditWaterViewController.h"

@interface TestTableViewController : UITableViewController <AuditLightingViewControllerDelegate, AuditResidenceViewControllerDelegate, AuditElectricityTableViewControllerDelegate, AuditHeatingViewControllerDelegate, AuditWaterViewControllerDelegate>

@end