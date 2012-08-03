//
//  AuditResidenceViewController.m
//  ANUGreen
//
//  Created by Victor Hartanto Wibisono on 2/08/11.
//  Copyright 2011 ANUGreen. All rights reserved.
//

#import "AuditResidenceViewController.h"
#import "ActionSheetPicker.h"


@implementation AuditResidenceViewController

@synthesize residenceField;
@synthesize wingField;

@synthesize buildingList;

@synthesize bruceHallWings;
@synthesize burgmannCollegeWings;
@synthesize johnXXIIICollegeWings;
@synthesize ursulaHallWings;
@synthesize fennerHallWings;
@synthesize burtonGarranHallWings;


// These methods are for the data source of the picker view object
// Components are the number of columns of the picker view
// These methods are necessary for the 

- (IBAction)selectAResidence:(UIControl *)sender {
    ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        if ([sender respondsToSelector:@selector(setText:)]) {
            [sender performSelector:@selector(setText:) withObject:selectedValue];
        }
    };
    ActionStringCancelBlock cancel = ^(ActionSheetStringPicker *picker) {
        NSLog(@"Block Picker Canceled");
    };
    [ActionSheetStringPicker showPickerWithTitle:@"Select a Residence" rows:buildingList initialSelection:0 doneBlock:done cancelBlock:cancel origin:sender];
    
}

- (IBAction)selectAWing:(UIControl *)sender {
    ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        if ([sender respondsToSelector:@selector(setText:)]) {
            [sender performSelector:@selector(setText:) withObject:selectedValue];
        }
    };
    ActionStringCancelBlock cancel = ^(ActionSheetStringPicker *picker) {
        NSLog(@"Block Picker Canceled");
    };
    if ([residenceField.text isEqualToString:@"Bruce Hall"]) {
        bruceHallWings = [[NSArray alloc]
                          initWithObjects:@"Bruce Hall Wing 1", @"Bruce Hall Wing 2", nil];
        [ActionSheetStringPicker showPickerWithTitle:@"Select a Building Wing" rows:bruceHallWings initialSelection:0 doneBlock:done cancelBlock:cancel origin:sender];
    } else if ([residenceField.text isEqualToString:@"Burgmann College"]) {
        burgmannCollegeWings = [[NSArray alloc]
                                initWithObjects:@"Burgmann Wing 1", @"Burgmann Wing 2", nil];
        [ActionSheetStringPicker showPickerWithTitle:@"Select a Building Wing" rows:burgmannCollegeWings initialSelection:0 doneBlock:done cancelBlock:cancel origin:sender];    
    } else if ([residenceField.text isEqualToString:@"John XXIII College"]) {
        johnXXIIICollegeWings = [[NSArray alloc]
                                 initWithObjects:@"John XXIII Wing 1", @"John XXIII Wing 2", nil];
        [ActionSheetStringPicker showPickerWithTitle:@"Select a Building Wing" rows:johnXXIIICollegeWings initialSelection:0 doneBlock:done cancelBlock:cancel origin:sender];
    } else if ([residenceField.text isEqualToString:@"Ursula Hall"]) {
        ursulaHallWings = [[NSArray alloc]
                           initWithObjects:@"Ursula Wing 1", @"Ursula Wing 2", nil];
        [ActionSheetStringPicker showPickerWithTitle:@"Select a Building Wing" rows:ursulaHallWings initialSelection:0 doneBlock:done cancelBlock:cancel origin:sender];
    } else if ([residenceField.text isEqualToString:@"Fenner Hall"]) {
        fennerHallWings = [[NSArray alloc]
                           initWithObjects:@"Fenner Wing 1", @"Fenner Wing 2", nil];
        [ActionSheetStringPicker showPickerWithTitle:@"Select a Building Wing" rows:fennerHallWings initialSelection:0 doneBlock:done cancelBlock:cancel origin:sender];
    } else if ([residenceField.text isEqualToString:@"Burton & Garran Hall"]) {
        burtonGarranHallWings = [[NSArray alloc]
                                 initWithObjects:@"B&G Wing 1", @"B&G Wing 2", nil];
        [ActionSheetStringPicker showPickerWithTitle:@"Select a Building Wing" rows:burtonGarranHallWings initialSelection:0 doneBlock:done cancelBlock:cancel origin:sender];        
    }

}

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.residenceField.delegate = self;
	self.wingField.delegate = self;

	self.title = @"Residence";
    
    buildingList = [[NSArray alloc]
                    initWithObjects:@"Bruce Hall", @"Burgmann College", @"John XXIII College", @"Ursula Hall", @"Fenner Hall", @"Burton & Garran Hall", @"Davey Lodge", @"Kinloch Lodge", @"Warrumbul Lodge", @"Lena Karmel Lodge", nil];
    
    
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
	[super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	
	self.residenceField = nil;
	self.wingField = nil;
	
}


- (void)dealloc {
	[residenceField release];
	[wingField release];
    [super dealloc];
}


@end
