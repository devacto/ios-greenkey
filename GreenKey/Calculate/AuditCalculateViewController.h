//
//  AuditCalculateViewController.h
//  ANUGreen
//
//  Created by Victor Hartanto Wibisono on 2/08/11.
//  Copyright 2011 ANUGreen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuditCalculateViewController : UIViewController {

    IBOutlet UILabel *gradeLabel;
}

@property (retain) UILabel *gradeLabel;
@property (nonatomic, strong) NSString *resultingGrade;

- (IBAction)resetButtonTouchedUpInside:(UIButton *)sender;

@end
