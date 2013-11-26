//
//  SavedViewController.m
//  movieTrip
//
//  Created by Kate Hsiao on 11/19/13.
//  Copyright (c) 2013 Kate Hsiao. All rights reserved.
//

#import "SavedViewController.h"
#import "SavedListViewController.h"
#import "AddTripViewController.h"

@interface SavedViewController ()

@end

@implementation SavedViewController
@synthesize editButton;

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
    
    // Configure button style
    [editButton setTitle:@"Edit"];
    
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
    
    SavedListViewController *savedListVC = [self.storyboard instantiateViewControllerWithIdentifier:@"savedListVC"];
    savedListVC.savedTripDict = savedArray[indexPath.row];
    [self.navigationController pushViewController:savedListVC animated:YES];
    
}


 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
     return YES;
 }


 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
     if (editingStyle == UITableViewCellEditingStyleDelete) {
         // TODO: Remove from plist
         NSLog(@"delete");
         [savedArray removeObjectAtIndex:indexPath.row];
         [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
         
     }
     else if (editingStyle == UITableViewCellEditingStyleInsert) {
         // Not used now
         // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
         NSLog(@"insert");
     }
 }


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

- (IBAction)actionEdit:(UIBarButtonItem *)sender {
    if (self.tableView.editing) {
        sender.title = @"Edit";
        [super setEditing:NO animated:YES];
    } else {
        sender.title = @"Done";
        [super setEditing:YES animated:YES];
    }
}

- (IBAction)actionAdd:(UIBarButtonItem *)sender {
    AddTripViewController *addTripVC = [self.storyboard instantiateViewControllerWithIdentifier:@"addTripVC"];
    [self.navigationController presentViewController:addTripVC animated:YES completion:nil];
}


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
@end
