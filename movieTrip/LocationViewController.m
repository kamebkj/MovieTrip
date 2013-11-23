//
//  LocationViewController.m
//  movieTrip
//
//  Created by Kate Hsiao on 11/22/13.
//  Copyright (c) 2013 Kate Hsiao. All rights reserved.
//

#import "LocationViewController.h"

@interface LocationViewController ()

@end

@implementation LocationViewController

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
    moviesShot = 5;
    
    selectedMovie = -1;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source
#pragma mark - Section

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    if (section==0) return @"title";
//    else if (section==1) return @"buttons";
//    else return @"movies";
    if (section==2) return @"Movies shot here";
    else return @"";
}


#pragma mark - Table cell

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==2) return moviesShot*2;
    else return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) return 170.0;
    else if (indexPath.section==1) return 60.0;
    else {
        // Initial
        if (selectedMovie==-1) {
            if (indexPath.row%2==0) return 44.0;
            else return 0.0;
        }
        else {
            if (indexPath.row%2==0) return 44.0;
            else if (indexPath.row == selectedMovie+1) return 100.0;
            else return 0.0;
        }
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.section==0) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 150, 150)];
        [imageView setImage:[UIImage imageNamed:@"campanile.jpg"]];
        
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(170, 10, 150, 150)];
        [textLabel setText:@"Sather Gate is a prominent landmark separating Sproul Plaza from the bridge over Strawberry Creek"];
        [textLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [textLabel setNumberOfLines:0];
        
        [cell addSubview:imageView];
        [cell addSubview:textLabel];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    else if (indexPath.section==1) {
        UIButton *checkButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 100, 40)];
        UIButton *saveButton = [[UIButton alloc] initWithFrame:CGRectMake(120, 10, 100, 40)];
        [checkButton setBackgroundColor:[UIColor redColor]];
        [checkButton setTitle:@"Checkin" forState:UIControlStateNormal];
        [checkButton addTarget:self action:@selector(clickCheckin:) forControlEvents:UIControlEventTouchUpInside];
        [saveButton setBackgroundColor:[UIColor redColor]];
        [saveButton setTitle:@"Save" forState:UIControlStateNormal];
        [saveButton addTarget:self action:@selector(clickSave:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:checkButton];
        [cell addSubview:saveButton];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    else {
        // Movies shot here
        if (indexPath.row%2==0) {
            cell.textLabel.text = @"movieTitle";
        }
        else {
            cell.textLabel.text = @"some content";
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [cell setUserInteractionEnabled:NO];
        }
    }
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section==2) {
        if (selectedMovie == indexPath.row) selectedMovie = -1;
        else {
            selectedMovie = indexPath.row;
        }
    }
    
    // Animated to display the whole cell with scrolling
    
//    [tableView scrollToNearestSelectedRowAtScrollPosition:UITableViewRowAnimationBottom animated:YES];
//    [tableView setContentOffset:<#(CGPoint)#>]
    [tableView reloadData];
    
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

#pragma mark - Button click

- (void)clickCheckin:(id)sender {
    NSLog(@"checkin");
}

- (void)clickSave:(id)sender {
    NSLog(@"save");
}

@end
