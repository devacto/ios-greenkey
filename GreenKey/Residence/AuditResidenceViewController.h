//
//  AuditResidenceViewController.h
//  ANUGreen
//
//  Created by Victor Hartanto Wibisono on 2/08/11.
//  Copyright 2011 ANUGreen. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GAITrackedViewController.h"


@class AuditResidenceViewController;

@protocol AuditResidenceViewControllerDelegate
- (void)auditResidenceViewControllerDidDone:(AuditResidenceViewController *)controller;
@end

@interface AuditResidenceViewController :  GAITrackedViewController <UITextFieldDelegate> {
    
    @private
		IBOutlet UITextField *residenceField;
		IBOutlet UITextField *wingField;
        IBOutlet UISegmentedControl *roomSharingField;
	
}

@property (nonatomic, strong) id <AuditResidenceViewControllerDelegate> delegate;

@property (nonatomic, strong) NSArray *buildingList;

@property (nonatomic, strong) NSArray *bruceHallWings;
@property (nonatomic, strong) NSArray *burgmannCollegeWings;
@property (nonatomic, strong) NSArray *johnXXIIICollegeWings;
@property (nonatomic, strong) NSArray *ursulaHallWings;
@property (nonatomic, strong) NSArray *fennerHallWings;
@property (nonatomic, strong) NSArray *burtonGarranHallWings;

@property (retain) IBOutlet	UITextField *residenceField;
@property (retain) IBOutlet	UITextField *wingField;
@property (retain) IBOutlet UISegmentedControl *roomSharingField;

- (IBAction)selectAResidence:(id)sender;
- (IBAction)selectAWing:(id)sender;

- (void)doneButtonClicked;

@end
