//
//  DestToSaveViewController.m
//  movieTrip
//
//  Created by Kate Hsiao on 11/26/13.
//  Copyright (c) 2013 Kate Hsiao. All rights reserved.
//

#import "DestToSaveViewController.h"

@interface DestToSaveViewController ()

@end

@implementation DestToSaveViewController
@synthesize place, placeId;

//- (id)initWithStyle:(UITableViewStyle)style
//{
//    self = [super initWithStyle:style];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [myTableView setDelegate:self];
    [myTableView setDataSource:self];
    
}

- (void)viewWillAppear:(BOOL)animated {
    // Get saved list from savedList.plist
    [self getFromPlist];
    [myTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [savedArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"SavedCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [savedArray[indexPath.row] objectForKey:@"tripName"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self saveToPlist:indexPath.row];
}



#pragma mark - Plist operation

- (void)getFromPlist {
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingPathComponent:@"savedList.plist"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path]) {
        NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"savedList" ofType:@"plist"];
        [fileManager copyItemAtPath:sourcePath toPath:path error:nil];
    }
    savedArray = [[NSMutableArray alloc] initWithContentsOfFile:path];
    
}

- (void)saveToPlist:(NSInteger)index {
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingPathComponent:@"savedList.plist"];
    
    // If place already exists, alert and not store
    // TODO
    NSMutableArray *newArray = [savedArray mutableCopy];
    NSDictionary *newPlace = [[NSDictionary alloc] initWithObjectsAndKeys:
                              place, @"placeName",
                              placeId, @"placeId", nil];
    [[newArray[index] objectForKey:@"places"] addObject:newPlace];
    [newArray writeToFile:path atomically:YES];
    
    //
    //    NSArray *emptyArray = [[NSArray alloc] init];
    //    NSDictionary *tobeAddDict = [[NSDictionary alloc] initWithObjectsAndKeys:
    //                                 title, @"tripName",
    //                                 emptyArray, @"places", nil];
    //    [newArray addObject:tobeAddDict];
    //    [newArray writeToFile:path atomically:YES];
}

- (IBAction)clickCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
