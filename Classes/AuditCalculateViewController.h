//
//  AuditCalculateViewController.h
//  ANUGreen
//
//  Created by Victor Hartanto Wibisono on 2/08/11.
//  Copyright 2011 ANUGreen. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface AuditCalculateViewController : UIViewController {

    IBOutlet UILabel *resultLabel;
    IBOutlet UILabel *electricityLabel;
    IBOutlet UILabel *heatingLabel;
    IBOutlet UILabel *waterLabel;
    IBOutlet UILabel *gradeLabel;
}

@property (retain) UILabel *resultLabel;
@property (retain) UILabel *electricityLabel;
@property (retain) UILabel *heatingLabel;
@property (retain) UILabel *waterLabel;
@property (retain) UILabel *gradeLabel;


@end
