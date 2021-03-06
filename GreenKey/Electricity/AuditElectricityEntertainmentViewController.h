//
//  AuditElectricityEntertainmentViewController.h
//  ANUGreen
//
//  Created by Victor Hartanto Wibisono on 2/08/11.
//  Copyright 2011 ANUGreen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AuditElectricityEntertainmentViewController;

@protocol AuditElectricityEntertainmentViewControllerDelegate
- (void)auditElectricityEntertainmentViewControllerDidDone: (AuditElectricityEntertainmentViewController *)controller;
@end


@interface AuditElectricityEntertainmentViewController : UIViewController <UITextFieldDelegate> {

    @private
    IBOutlet UITextField *lcdtvField;
    IBOutlet UITextField *plasmatvField;
    IBOutlet UITextField *standardtvField;
    IBOutlet UITextField *stereoField;
    IBOutlet UITextField *speakerField;
    IBOutlet UITextField *consoleField;
    
}

@property (nonatomic, strong) id <AuditElectricityEntertainmentViewControllerDelegate> delegate;

@property (retain) IBOutlet UITextField *lcdtvField;
@property (retain) IBOutlet UITextField *plasmatvField;
@property (retain) IBOutlet UITextField *standardtvField;
@property (retain) IBOutlet UITextField *stereoField;
@property (retain) IBOutlet UITextField *speakerField;
@property (retain) IBOutlet UITextField *consoleField;

@property (nonatomic, strong) NSArray *hoursList;

- (IBAction)selectHours:(id)sender;
- (void)doneButtonClicked;

@end
