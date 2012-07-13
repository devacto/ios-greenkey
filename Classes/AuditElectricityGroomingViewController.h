//
//  AuditElectricityGroomingViewController.h
//  ANUGreen
//
//  Created by Victor Hartanto Wibisono on 4/08/11.
//  Copyright 2011 ANUGreen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuditElectricityGroomingViewController : UIViewController <UITextFieldDelegate> {
    
@private
    IBOutlet UITextField *blowdryerField;
    IBOutlet UITextField *hairstraightenerField;
    
}

@property (retain) IBOutlet UITextField *blowdryerField;
@property (retain) IBOutlet UITextField *hairstraightenerField;

@end


