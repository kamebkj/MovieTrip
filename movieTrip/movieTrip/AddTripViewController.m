//
//  AddTripViewController.m
//  movieTrip
//
//  Created by Kate Hsiao on 11/25/13.
//  Copyright (c) 2013 Kate Hsiao. All rights reserved.
//

#import "AddTripViewController.h"

@interface AddTripViewController ()

@end

@implementation AddTripViewController
@synthesize titleText, descText;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)actionDone:(id)sender {
    
    if ([titleText.text isEqualToString:@""]) {
        // TODO: alert or something
        NSLog(@"no title");
    }
    else {
        [self saveToPlist:titleText.text];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)saveToPlist:(NSString*)title {

    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingPathComponent:@"savedList.plist"];
    
    // If the file doesn't exist in the Documents Folder, copy it.
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path]) {
        NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"savedList" ofType:@"plist"];
        [fileManager copyItemAtPath:sourcePath toPath:path error:nil];
    }
    
    // Load the Property List.
    NSArray *savedArray = [[NSArray alloc] initWithContentsOfFile:path];
    // If title already exists, alert and not store
    for (int i=0; i<[savedArray count]; i++) {
        if ( [title isEqualToString:[savedArray[i] objectForKey:@"tripName"]] ) {
            //alert
            return;
        }
    }
    NSMutableArray *newArray = [savedArray mutableCopy];
    NSArray *emptyArray = [[NSArray alloc] init];
    NSDictionary *tobeAddDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 title, @"tripName",
                                 emptyArray, @"places", nil];
    [newArray addObject:tobeAddDict];
    [newArray writeToFile:path atomically:YES];
}

@end
