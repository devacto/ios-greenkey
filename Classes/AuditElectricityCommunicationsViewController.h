//
//  AuditElectricityCommunicationsViewController.h
//  ANUGreen
//
//  Created by Victor Hartanto Wibisono on 2/08/11.
//  Copyright 2011 ANUGreen. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AuditElectricityCommunicationsViewController : UIViewController <UITextFieldDelegate> {

    @private
    IBOutlet UITextField *laptopField;
    IBOutlet UITextField *desktopField;
    IBOutlet UITextField *printerField;
    IBOutlet UITextField *scannerField;
    IBOutlet UITextField *mobileField;
    IBOutlet UITextField *ipodField;
    IBOutlet UISegmentedControl *shutdownField;
    IBOutlet UISegmentedControl *turnoffField;
}

@property (retain) IBOutlet UITextField *laptopField;
@property (retain) IBOutlet UITextField *desktopField;
@property (retain) IBOutlet UITextField *printerField;
@property (retain) IBOutlet UITextField *scannerField;
@property (retain) IBOutlet UITextField *mobileField;
@property (retain) IBOutlet UITextField *ipodField;
@property (retain) IBOutlet UISegmentedControl *shutdownField;
@property (retain) IBOutlet UISegmentedControl *turnoffField;

@property (nonatomic, strong) NSArray *hoursList;

- (IBAction)selectHours:(id)sender;


@end
