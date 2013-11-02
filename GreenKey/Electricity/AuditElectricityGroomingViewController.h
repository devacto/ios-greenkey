//
//  AuditElectricityGroomingViewController.h
//  ANUGreen
//
//  Created by Victor Hartanto Wibisono on 4/08/11.
//  Copyright 2011 ANUGreen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AuditElectricityGroomingViewController;

@protocol AuditElectricityGroomingViewControllerDelegate
- (void)auditElectricityGroomingViewControllerDidDone: (AuditElectricityGroomingViewController *)controller;
@end

@interface AuditElectricityGroomingViewController : UIViewController <UITextFieldDelegate> {
    
    @private
    IBOutlet UITextField *blowdryerField;
    IBOutlet UITextField *hairstraightenerField;
    
}

@property (nonatomic, strong) id <AuditElectricityGroomingViewControllerDelegate> delegate;

@property (retain) IBOutlet UITextField *blowdryerField;
@property (retain) IBOutlet UITextField *hairstraightenerField;

@property (nonatomic, strong) NSArray *minutesList;

- (IBAction)selectMinutes:(id)sender;
- (void)doneButtonClicked;

@end
