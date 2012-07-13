//
//  AuditResidenceViewController.h
//  ANUGreen
//
//  Created by Victor Hartanto Wibisono on 2/08/11.
//  Copyright 2011 ANUGreen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AbstractActionSheetPicker;
@interface AuditResidenceViewController :  UIViewController <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate> {
    
    @private
		IBOutlet UITextField *residenceField;
		IBOutlet UITextField *wingField;
	
};

// Array containing the residence list of the ANU
@property (nonatomic, strong) NSArray *buildingList;

@property (retain) IBOutlet	UITextField *residenceField;
@property (retain) IBOutlet	UITextField *wingField;

- (IBAction)selectAResidence:(id)sender;

@end
