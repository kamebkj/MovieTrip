//
//  MovieViewController.m
//  movieTrip
//
//  Created by Kate Hsiao on 11/26/13.
//  Copyright (c) 2013 Kate Hsiao. All rights reserved.
//

#import "MovieViewController.h"
#import "AFNetworking.h"

static NSString *const BaseURLString = @"http://people.ischool.berkeley.edu/~jthuang/i298/";

@interface MovieViewController ()

@end

@implementation MovieViewController
@synthesize movieId;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getLocationData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section==2) return @"Shooting Locations";
    else return @"";
}


#pragma mark - Table cell

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==2) return [locationsArray count];
    else return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) return 220.0;
    else if (indexPath.section==1) return 60.0;
    else return 44.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MovieCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.section==0) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 150)];
        [imageView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://mw2.google.com/mw-panoramio/photos/medium/17769178.jpg"]]]];
        
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 160, self.view.bounds.size.width, 50)];
        [textLabel setText:movieName];
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
        // Shooting locations
//        cell.textLabel.text = [locationsArray[indexPath.row] objectForKey:@""];
        cell.textLabel.text = @"location A";
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
    NSString *weatherUrl = [NSString stringWithFormat:@"%@movie.php?id=%@", BaseURLString, movieId];
    NSURL *url = [NSURL URLWithString:weatherUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation =
    [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                    success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                        [self setMovieData:(NSDictionary*)JSON];
                                                    }
                                                    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                        NSLog(@"error");
                                                    }
     ];
    [operation start];
}

- (void)setMovieData:(NSDictionary*)movieDict {
    movieName = [movieDict objectForKey:@"Title"];
//    locationsArray = (NSArray*) [movieDict objectForKey:@"Movies"];
    
    [self.tableView reloadData];
}


@end
