//
//  AuditHeatingViewController.h
//  ANUGreen
//
//  Created by Victor Hartanto Wibisono on 2/08/11.
//  Copyright 2011 ANUGreen. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AuditHeatingViewController : UIViewController <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate> {
    
    @private
    IBOutlet UITextField *valveField;
    IBOutlet UITextField *thermostatField;
    IBOutlet UITableView *heatingTable;
    IBOutlet UIScrollView *myScroll;
  
}


-(void) registerForKeyboardNotifications;

@property (retain) IBOutlet UITextField *valveField;
@property (retain) IBOutlet UITextField *thermostatField;
@property (retain) IBOutlet UITableView *heatingTable;
@property (retain) IBOutlet UIScrollView *myScroll;

@property (assign) NSString *currentHeatingSelection;
@property (retain) NSArray *heatingModes;

@end
