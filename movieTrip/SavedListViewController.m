//
//  SavedListViewController.m
//  movieTrip
//
//  Created by Kate Hsiao on 11/25/13.
//  Copyright (c) 2013 Kate Hsiao. All rights reserved.
//

#import "SavedListViewController.h"
#import "LocationViewController.h"

@interface SavedListViewController ()

@end

@implementation SavedListViewController
@synthesize savedTripDict;

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
    self.navigationItem.title = [savedTripDict objectForKey:@"tripName"];
    places = [savedTripDict objectForKey:@"places"];
    
    NSLog(@"places: %@", places);

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [places count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SavedListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [places[indexPath.row] objectForKey:@"placeName"];
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LocationViewController *locationVC = [[LocationViewController alloc] initWithNibName:@"LocationViewController" bundle:nil];
    locationVC.locationId =[places[indexPath.row] objectForKey:@"placeId"];
    [self.navigationController pushViewController:locationVC animated:YES];
    
}

@end
