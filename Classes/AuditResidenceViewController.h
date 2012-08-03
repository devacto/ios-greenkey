//
//  AuditResidenceViewController.h
//  ANUGreen
//
//  Created by Victor Hartanto Wibisono on 2/08/11.
//  Copyright 2011 ANUGreen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AbstractActionSheetPicker;
@interface AuditResidenceViewController :  UIViewController <UITextFieldDelegate> {
    
    @private
		IBOutlet UITextField *residenceField;
		IBOutlet UITextField *wingField;
	
};

// Array containing the residence list of the ANU
@property (nonatomic, strong) NSArray *buildingList;

@property (nonatomic, strong) NSArray *bruceHallWings;
@property (nonatomic, strong) NSArray *burgmannCollegeWings;
@property (nonatomic, strong) NSArray *johnXXIIICollegeWings;
@property (nonatomic, strong) NSArray *ursulaHallWings;
@property (nonatomic, strong) NSArray *fennerHallWings;
@property (nonatomic, strong) NSArray *burtonGarranHallWings;


@property (retain) IBOutlet	UITextField *residenceField;
@property (retain) IBOutlet	UITextField *wingField;

- (IBAction)selectAResidence:(id)sender;

- (IBAction)selectAWing:(id)sender;

@end
