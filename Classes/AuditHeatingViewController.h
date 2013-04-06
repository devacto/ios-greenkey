//
//  AuditHeatingViewController.h
//  ANUGreen
//
//  Created by Victor Hartanto Wibisono on 2/08/11.
//  Copyright 2011 ANUGreen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AuditHeatingViewController;

@protocol AuditHeatingViewControllerDelegate
- (void)auditHeatingViewControllerDidDone: (AuditHeatingViewController *)controller;
@end


@interface AuditHeatingViewController : UIViewController <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate> {
    
    @private
    IBOutlet UITextField *valveField;
    IBOutlet UITextField *thermostatField;
    IBOutlet UITableView *heatingTable;
    IBOutlet UIScrollView *myScroll;
  
}

@property (nonatomic, strong) id <AuditHeatingViewControllerDelegate> delegate;

@property (retain) IBOutlet UITextField *valveField;
@property (retain) IBOutlet UITextField *thermostatField;
@property (retain) IBOutlet UITableView *heatingTable;
@property (retain) IBOutlet UIScrollView *myScroll;

@property (assign) NSString *currentHeatingSelection;
@property (retain) NSArray *heatingModes;

@property (nonatomic, strong) NSArray *valveList;
@property (nonatomic, strong) NSArray *thermostatList;

@property (nonatomic) BOOL valveSelected;
@property (nonatomic) BOOL thermostatSelected;
@property (nonatomic) BOOL noControSelected;

- (IBAction)selectValveSettings:(id)sender;
- (IBAction)selectThermostatSettings:(id)sender;

@end
