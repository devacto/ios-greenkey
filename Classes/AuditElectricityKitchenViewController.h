//
//  AuditElectricityKitchenViewController.h
//  ANUGreen
//
//  Created by Victor Hartanto Wibisono on 2/08/11.
//  Copyright 2011 ANUGreen. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AuditElectricityKitchenViewController : UIViewController <UITextFieldDelegate> {

    @private
    IBOutlet UITextField *kettleField;
    IBOutlet UITextField *microwaveField;
    IBOutlet UITextField *coffeemachineField;
    IBOutlet UITextField *toasterField;
}

@property (retain) IBOutlet UITextField *kettleField;
@property (retain) IBOutlet UITextField *microwaveField;
@property (retain) IBOutlet UITextField *coffeemachineField;
@property (retain) IBOutlet UITextField *toasterField;

@end
