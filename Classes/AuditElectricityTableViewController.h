//
//  AuditElectricityTableViewController.h
//  ANUGreen
//
//  Created by Victor Hartanto Wibisono on 2/08/11.
//  Copyright 2011 ANUGreen. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AuditElectricityKitchenViewController.h"
#import "AuditElectricityEntertainmentViewController.h"
#import "AuditElectricityCommunicationsViewController.h"
#import "AuditElectricityGroomingViewController.h"

@class AuditElectricityTableViewController;

@protocol AuditElectricityTableViewControllerDelegate
- (void)auditElectricityTableViewControllerDidDone: (AuditElectricityTableViewController *)controller;
@end

@interface AuditElectricityTableViewController : UITableViewController <AuditElectricityKitchenViewControllerDelegate, AuditElectricityEntertainmentViewControllerDelegate, AuditElectricityCommunicationsViewControllerDelegate,
    AuditElectricityGroomingViewControllerDelegate> {

}

@property (nonatomic, strong) id <AuditElectricityTableViewControllerDelegate> delegate;

- (void)doneButtonClicked;

@end
