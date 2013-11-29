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

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    // Get saved list from savedList.plist
    [self getFromPlist];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
#pragma mark - Section

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

#pragma mark - Table cell

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
    
    // TODO: save to plist
    
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

- (void)saveToPlist:(NSString*)place withIndex:(NSInteger)index {
    
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
    // If place already exists, alert and not store
    // TODO
    
//    NSMutableArray *newArray = [savedArray mutableCopy];
//    NSArray *emptyArray = [[NSArray alloc] init];
//    NSDictionary *tobeAddDict = [[NSDictionary alloc] initWithObjectsAndKeys:
//                                 title, @"tripName",
//                                 emptyArray, @"places", nil];
//    [newArray addObject:tobeAddDict];
//    [newArray writeToFile:path atomically:YES];
}

@end
