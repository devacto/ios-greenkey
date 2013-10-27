//
//  AboutANUGreenViewController.m
//  ANUGreen
//
//  Created by Victor Hartanto Wibisono on 1/08/11.
//  Copyright 2011 - 2013 The Australian National University. All rights reserved.
//

#import "AboutANUGreenViewController.h"


@implementation AboutANUGreenViewController

#pragma mark - View setup
- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
}

#pragma mark - Visit website button

- (IBAction)visitWebsite:(UIButton *)sender {
    NSString* launchUrl = @"http://www.anu.edu.au/anugreen/";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: launchUrl]];
}

#pragma mark - Garbage collection

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
