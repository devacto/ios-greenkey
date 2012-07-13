//
//  AuditWaterViewController.h
//  ANUGreen
//
//  Created by Victor Hartanto Wibisono on 2/08/11.
//  Copyright 2011 ANUGreen. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AuditWaterViewController : UIViewController <UITextFieldDelegate> {

@private
    IBOutlet UITextField *showerField;
    IBOutlet UITextField *tapField;
    IBOutlet UITextField *halfflushField;
    IBOutlet UITextField *fullflushField;
    IBOutlet UITextField *washField;
    IBOutlet UISegmentedControl *coldwashField;
    IBOutlet UISegmentedControl *fullwashField;
    
    
}

@property (retain) IBOutlet UITextField *showerField;
@property (retain) IBOutlet UITextField *tapField;
@property (retain) IBOutlet UITextField *halfflushField;
@property (retain) IBOutlet UITextField *fullflushField;
@property (retain) IBOutlet UITextField *washField;
@property (retain) IBOutlet UISegmentedControl *coldwashField;
@property (retain) IBOutlet UISegmentedControl *fullwashField;

@end
