//
//  main.m
//  ANUGreen
//
//  Created by Victor Hartanto Wibisono on 28/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANUGreenAppDelegate.h"

int main(int argc, char *argv[]) {
    
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, NSStringFromClass([ANUGreenAppDelegate class]));
    [pool release];
    return retVal;
}
