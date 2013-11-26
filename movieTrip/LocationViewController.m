//
//  LocationViewController.m
//  movieTrip
//
//  Created by Kate Hsiao on 11/22/13.
//  Copyright (c) 2013 Kate Hsiao. All rights reserved.
//

#import "LocationViewController.h"
#import "AFNetworking.h"

static NSString *const BaseURLString = @"http://people.ischool.berkeley.edu/~jthuang/i298/";


@interface LocationViewController ()

@end

@implementation LocationViewController
@synthesize locationId;


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
    [self getLocationData];
    selectedMovie = -1;
    
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
    if (section==2) return @"Movies shot here";
    else return @"";
}


#pragma mark - Table cell

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==2) return [moviesArray count]*2;
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
    static NSString *CellIdentifier = @"LocationCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.section==0) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 150)];
        [imageView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://mw2.google.com/mw-panoramio/photos/medium/17769178.jpg"]]]];
        
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.view.bounds.size.width, 50)];
        [textLabel setText:locationName];
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
            cell.textLabel.text = [moviesArray[indexPath.row/2] objectForKey:@"Title"];
        }
        else {
            cell.textLabel.text = [moviesArray[indexPath.row/2] objectForKey:@"Description"];
            [cell.textLabel setLineBreakMode:NSLineBreakByWordWrapping];
            [cell.textLabel setNumberOfLines:0];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [cell setUserInteractionEnabled:NO];
        }
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
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
    [self.tableView reloadData];
}

#pragma mark - Button click

- (void)clickCheckin:(id)sender {
    NSLog(@"checkin");
}

- (void)clickSave:(id)sender {
    NSLog(@"save");
}

#pragma mark - Get data

- (void)getLocationData {
    NSString *weatherUrl = [NSString stringWithFormat:@"%@location.php?id=%@", BaseURLString, locationId];
    NSURL *url = [NSURL URLWithString:weatherUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation =
    [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                    success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                        //                                                        locationObj = (NSDictionary*)JSON;
                                                        [self setLocationData:(NSDictionary*)JSON];
                                                    }
                                                    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                        NSLog(@"error");
                                                    }
     ];
    [operation start];
}

- (void)setLocationData:(NSDictionary*)locationDict {
    locationName = [locationDict objectForKey:@"Description"];
    moviesArray = (NSArray*) [locationDict objectForKey:@"Movies"];
    
    [self.tableView reloadData];
}

@end
