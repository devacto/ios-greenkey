//
//  AuditLightingViewController.h
//  ANUGreen
//
//  Created by Victor Hartanto Wibisono on 2/08/11.
//  Copyright 2011 ANUGreen. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AuditLightingViewController : UIViewController <UITextFieldDelegate> {

    @private
    IBOutlet UITextField *compactFluorescentField;
    IBOutlet UITextField *linearFluorescentField;
    IBOutlet UITextField *circularFluorescentField;
    IBOutlet UITextField *compactDownlightField;
    IBOutlet UITextField *halogenDownlightField;
    IBOutlet UITextField *incandescentBulbField;
    
    //For the number text fields
    IBOutlet UITextField *noCompactFluorescentField;
    IBOutlet UITextField *noLinearFluorescentField;
    IBOutlet UITextField *noCircularFluorescentField;
    IBOutlet UITextField *noCompactDownlightField;
    IBOutlet UITextField *noHalogenDownlightField;
    IBOutlet UITextField *noIncandescentBulbField;
    
    IBOutlet UISegmentedControl *turnOff;
}

@property (retain) IBOutlet UITextField *compactFluorescentField;
@property (retain) IBOutlet UITextField *linearFluorescentField;
@property (retain) IBOutlet UITextField *circularFluorescentField;
@property (retain) IBOutlet UITextField *compactDownlightField;
@property (retain) IBOutlet UITextField *halogenDownlightField;
@property (retain) IBOutlet UITextField *incandescentBulbField;

@property (retain) IBOutlet UITextField *noCompactFluorescentField;
@property (retain) IBOutlet UITextField *noLinearFluorescentField;
@property (retain) IBOutlet UITextField *noCircularFluorescentField;
@property (retain) IBOutlet UITextField *noCompactDownlightField;
@property (retain) IBOutlet UITextField *noHalogenDownlightField;
@property (retain) IBOutlet UITextField *noIncandescentBulbField;

@property (retain) IBOutlet UISegmentedControl *turnOff;

// properties for the different kinds of scroll pickers
@property (nonatomic, strong) NSArray *numberOfBulbList;
@property (nonatomic, strong) NSArray *durationList;

@end
